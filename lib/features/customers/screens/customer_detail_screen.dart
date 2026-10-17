import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../customerPayments/screens/customer_payment_history_screen.dart';
import '../../reports/widgets/summary_card.dart';
import '../data/models/customer.dart';
import '../providers/customer_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class CustomerDetailScreen extends ConsumerStatefulWidget {
  const CustomerDetailScreen({super.key, required this.customerId});

  final String customerId;

  @override
  ConsumerState<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(customerSalesHistoryProvider(widget.customerId).notifier).loadMore();
    }
  }

  Future<void> _toggleStatus(Customer customer) async {
    final success = await ref.read(customerListProvider.notifier).setStatus(customer.id, !customer.isActive);
    ref.invalidate(customerDetailProvider(widget.customerId));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (customer.isActive ? 'Customer deactivated' : 'Customer activated')
              : 'Failed to update customer status',
        ),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final notifier = ref.read(customerSalesHistoryProvider(widget.customerId).notifier);
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    final customerAsync = ref.watch(customerDetailProvider(widget.customerId));
    final historyState = ref.watch(customerSalesHistoryProvider(widget.customerId));
    final historyNotifier = ref.read(customerSalesHistoryProvider(widget.customerId).notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Customer'),
        actions: [
          IconButton(
            icon: Icon(historyState.hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filter sales history by date',
            onPressed: _pickDateRange,
          ),
          customerAsync.maybeWhen(
            data: (customer) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push('/customers/${widget.customerId}/edit', extra: customer),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: customerAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error is ApiException ? error.message : '$error',
          onRetry: () => ref.invalidate(customerDetailProvider(widget.customerId)),
        ),
        data: (customer) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(customerDetailProvider(widget.customerId));
              await historyNotifier.refresh();
            },
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(customer.name, style: Theme.of(context).textTheme.titleLarge)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (customer.isActive ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                customer.isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: customer.isActive ? AppColors.success : AppColors.error,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        _InfoRow(icon: Icons.phone_outlined, label: 'Mobile', value: customer.mobileNumber),
                        _InfoRow(icon: Icons.email_outlined, label: 'Email', value: customer.email),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: _formatAddress(customer.address),
                        ),
                        _InfoRow(icon: Icons.receipt_long_outlined, label: 'GST Number', value: customer.gstNumber),
                        _InfoRow(icon: Icons.notes_outlined, label: 'Notes', value: customer.notes),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _toggleStatus(customer),
                  icon: Icon(customer.isActive ? Icons.block_outlined : Icons.check_circle_outline),
                  label: Text(customer.isActive ? 'Deactivate Customer' : 'Activate Customer'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: customer.isActive ? AppColors.error : AppColors.success,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sales History', style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              CustomerPaymentHistoryScreen(customerId: widget.customerId, customerName: customer.name),
                        ),
                      ),
                      child: const Text('Payment History'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _buildHistoryBody(historyState, historyNotifier),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHistoryBody(CustomerSalesHistoryState state, CustomerSalesHistoryNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }

    final summary = state.summary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (summary != null) ...[
          SummaryCardGrid(
            cards: [
              SummaryCard(label: 'Total Sales', value: '${summary.totalSales}'),
              SummaryCard(
                label: 'Total Amount',
                value: Formatters.currency(summary.totalAmount),
                color: AppColors.info,
              ),
              SummaryCard(
                label: 'Outstanding',
                value: Formatters.currency(summary.totalOutstanding),
                color: summary.totalOutstanding > 0 ? AppColors.warning : AppColors.success,
              ),
              SummaryCard(label: 'Unpaid/Partial', value: '${summary.unpaidOrPartialCount}'),
            ],
          ),
          const SizedBox(height: 8),
          if (summary.lastSaleDate != null)
            Text(
              'Last sale: ${Formatters.date(summary.lastSaleDate!)}'
              '${summary.lastPaymentDate != null ? ' · Last payment: ${Formatters.date(summary.lastPaymentDate!)}' : ''}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          const SizedBox(height: 16),
        ],
        if (state.items.isEmpty)
          const EmptyState(
            icon: Icons.point_of_sale_outlined,
            title: 'No sales yet',
            description: 'Sales recorded for this customer will appear here.',
          )
        else
          Card(
            child: Column(
              children: [
                for (final sale in state.items) ...[
                  ListTile(
                    title: Text(sale.saleNumber),
                    subtitle: Text('${Formatters.date(sale.saleDate)} · ${sale.paymentStatus}'),
                    trailing: Text(
                      Formatters.currency(sale.totalAmount),
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                    onTap: () => context.push('/sales/${sale.id}'),
                  ),
                  if (sale != state.items.last) const Divider(height: 1),
                ],
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  String? _formatAddress(CustomerAddress? address) {
    if (address == null) return null;
    final parts = [
      address.line1,
      address.line2,
      address.city,
      address.state,
      address.pincode,
    ].where((p) => p != null && p.isNotEmpty).toList();
    return parts.isEmpty ? null : parts.join(', ');
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
