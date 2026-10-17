import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../reports/widgets/summary_card.dart';
import '../data/models/supplier.dart';
import '../providers/supplier_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class SupplierDetailScreen extends ConsumerStatefulWidget {
  const SupplierDetailScreen({super.key, required this.supplierId});

  final String supplierId;

  @override
  ConsumerState<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends ConsumerState<SupplierDetailScreen> {
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
      ref.read(supplierPurchaseHistoryProvider(widget.supplierId).notifier).loadMore();
    }
  }

  Future<void> _toggleStatus(Supplier supplier) async {
    final success = await ref.read(supplierListProvider.notifier).setActive(supplier.id, !supplier.isActive);
    ref.invalidate(supplierDetailProvider(widget.supplierId));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (supplier.isActive ? 'Supplier deactivated' : 'Supplier activated')
              : 'Failed to update supplier status',
        ),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final notifier = ref.read(supplierPurchaseHistoryProvider(widget.supplierId).notifier);
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    final supplierAsync = ref.watch(supplierDetailProvider(widget.supplierId));
    final historyState = ref.watch(supplierPurchaseHistoryProvider(widget.supplierId));
    final historyNotifier = ref.read(supplierPurchaseHistoryProvider(widget.supplierId).notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Supplier'),
        actions: [
          IconButton(
            icon: Icon(historyState.hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filter purchase history by date',
            onPressed: _pickDateRange,
          ),
          supplierAsync.maybeWhen(
            data: (supplier) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push('/suppliers/${widget.supplierId}/edit', extra: supplier),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: supplierAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error is ApiException ? error.message : '$error',
          onRetry: () => ref.invalidate(supplierDetailProvider(widget.supplierId)),
        ),
        data: (supplier) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(supplierDetailProvider(widget.supplierId));
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
                            Expanded(child: Text(supplier.name, style: Theme.of(context).textTheme.titleLarge)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (supplier.isActive ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                supplier.isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: supplier.isActive ? AppColors.success : AppColors.error,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        _InfoRow(icon: Icons.person_outline, label: 'Contact Person', value: supplier.contactPerson),
                        _InfoRow(icon: Icons.phone_outlined, label: 'Mobile', value: supplier.mobileNumber),
                        _InfoRow(icon: Icons.email_outlined, label: 'Email', value: supplier.email),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: _formatAddress(supplier.address),
                        ),
                        _InfoRow(icon: Icons.receipt_long_outlined, label: 'GST Number', value: supplier.gstNumber),
                        _InfoRow(icon: Icons.notes_outlined, label: 'Notes', value: supplier.notes),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _toggleStatus(supplier),
                  icon: Icon(supplier.isActive ? Icons.block_outlined : Icons.check_circle_outline),
                  label: Text(supplier.isActive ? 'Deactivate Supplier' : 'Activate Supplier'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: supplier.isActive ? AppColors.error : AppColors.success,
                  ),
                ),
                const SizedBox(height: 24),
                Text('Purchase History', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                _buildHistoryBody(historyState, historyNotifier),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHistoryBody(SupplierPurchaseHistoryState state, SupplierPurchaseHistoryNotifier notifier) {
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
        if (summary != null)
          SummaryCardGrid(
            cards: [
              SummaryCard(label: 'Invoices', value: '${summary.totalPurchases}'),
              SummaryCard(label: 'Qty Purchased', value: Formatters.quantity(summary.totalQuantityPurchased)),
              SummaryCard(
                label: 'Total Purchases',
                value: Formatters.currency(summary.totalAmount),
                color: AppColors.info,
              ),
              SummaryCard(
                label: 'Outstanding',
                value: Formatters.currency(summary.outstandingAmount),
                color: summary.outstandingAmount > 0 ? AppColors.warning : AppColors.success,
              ),
            ],
          ),
        const SizedBox(height: 16),
        if (state.items.isEmpty)
          const EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'No purchases yet',
            description: 'Purchases recorded from this supplier will appear here.',
          )
        else
          Card(
            child: Column(
              children: [
                for (final purchase in state.items) ...[
                  ListTile(
                    title: Text(purchase.purchaseNumber),
                    subtitle: Text(Formatters.date(purchase.purchaseDate)),
                    trailing: Text(
                      Formatters.currency(purchase.totalAmount),
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                    onTap: () => context.push('/purchases/${purchase.id}'),
                  ),
                  if (purchase != state.items.last) const Divider(height: 1),
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

  String? _formatAddress(SupplierAddress? address) {
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
