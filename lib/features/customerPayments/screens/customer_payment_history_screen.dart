import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/customer_payment_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD', 'CREDIT'];

class CustomerPaymentHistoryScreen extends ConsumerStatefulWidget {
  const CustomerPaymentHistoryScreen({super.key, required this.customerId, required this.customerName});

  final String customerId;
  final String customerName;

  @override
  ConsumerState<CustomerPaymentHistoryScreen> createState() => _CustomerPaymentHistoryScreenState();
}

class _CustomerPaymentHistoryScreenState extends ConsumerState<CustomerPaymentHistoryScreen> {
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
      ref.read(customerPaymentHistoryProvider(widget.customerId).notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(CustomerPaymentHistoryNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  void _showFilterSheet(CustomerPaymentHistoryState state, CustomerPaymentHistoryNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter Payments', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _pickDateRange(notifier);
                  },
                  icon: const Icon(Icons.date_range_outlined),
                  label: const Text('Choose Date Range'),
                ),
                const SizedBox(height: 12),
                Text('Method', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Methods'),
                      selected: state.method == null,
                      onSelected: (_) {
                        notifier.setMethod(null);
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                    for (final method in _paymentMethods)
                      ChoiceChip(
                        label: Text(method),
                        selected: state.method == method,
                        onSelected: (_) {
                          notifier.setMethod(method);
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                  ],
                ),
                if (state.hasActiveFilters) ...[
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      notifier.clearFilters();
                      Navigator.of(sheetContext).pop();
                    },
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text('Clear filters'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerPaymentHistoryProvider(widget.customerId));
    final notifier = ref.read(customerPaymentHistoryProvider(widget.customerId).notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: Text('${widget.customerName} — Payments'),
        actions: [
          IconButton(
            icon: Icon(state.hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(state, notifier),
          ),
        ],
      ),
      body: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(state, notifier)),
    );
  }

  Widget _buildBody(CustomerPaymentHistoryState state, CustomerPaymentHistoryNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.payments_outlined,
        title: 'No payments yet',
        description: 'Payments recorded against this customer\'s sales will appear here.',
      );
    }

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Column(
            children: [
              for (final payment in state.items) ...[
                ListTile(
                  title: Text(Formatters.currency(payment.amount)),
                  subtitle: Text(
                    '${payment.saleNumber ?? 'Sale'} · ${payment.method} · '
                    '${Formatters.date(payment.paymentDate)}'
                    '${payment.referenceNumber != null ? ' · Ref ${payment.referenceNumber}' : ''}'
                    '${payment.notes != null && payment.notes!.isNotEmpty ? ' · ${payment.notes}' : ''}',
                  ),
                  trailing: const Icon(Icons.check_circle_outline, color: AppColors.success),
                ),
                if (payment != state.items.last) const Divider(height: 1),
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
}
