import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../inventory/data/models/inventory_transaction.dart';
import '../../inventory/widgets/product_picker_page.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

class InventoryLedgerReportScreen extends ConsumerStatefulWidget {
  const InventoryLedgerReportScreen({super.key});

  @override
  ConsumerState<InventoryLedgerReportScreen> createState() => _InventoryLedgerReportScreenState();
}

class _InventoryLedgerReportScreenState extends ConsumerState<InventoryLedgerReportScreen> {
  final _scrollController = ScrollController();
  String? _productName;

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
      ref.read(ledgerReportProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(LedgerReportNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  void _showFilterSheet(LedgerReportState state, LedgerReportNotifier notifier) {
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
                Text('Filter Ledger', style: Theme.of(context).textTheme.titleMedium),
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
                OutlinedButton.icon(
                  onPressed: () async {
                    Navigator.of(sheetContext).pop();
                    final picked = await pickProduct(context);
                    if (picked == null) return;
                    setState(() => _productName = picked.name);
                    notifier.setProduct(picked.productId);
                  },
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: Text(_productName == null ? 'Filter by Product' : 'Product: $_productName'),
                ),
                const SizedBox(height: 12),
                Text('Transaction Type', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Types'),
                      selected: state.type == null,
                      onSelected: (_) {
                        notifier.setType(null);
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                    for (final type in InventoryTransactionType.filterable)
                      ChoiceChip(
                        label: Text(type.label),
                        selected: state.type == type.wireValue,
                        onSelected: (_) {
                          notifier.setType(type.wireValue);
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                  ],
                ),
                if (state.hasActiveFilters) ...[
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      setState(() => _productName = null);
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
    final state = ref.watch(ledgerReportProvider);
    final notifier = ref.read(ledgerReportProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Inventory Ledger'),
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

  Widget _buildBody(LedgerReportState state, LedgerReportNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }

    final summary = state.summary;
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        if (summary != null)
          SummaryCardGrid(
            cards: [
              SummaryCard(
                label: 'Total In',
                value: '+${Formatters.quantity(summary.totalIn)}',
                color: AppColors.success,
              ),
              SummaryCard(
                label: 'Total Out',
                value: '-${Formatters.quantity(summary.totalOut)}',
                color: AppColors.error,
              ),
            ],
          ),
        const SizedBox(height: 16),
        if (state.items.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No stock movements found',
              description: 'Try widening the date range or clearing filters.',
            ),
          )
        else
          Card(
            child: Column(
              children: [
                for (final row in state.items) ...[
                  ListTile(
                    title: Text(row.productName),
                    subtitle: Text(
                      '${row.type.label} · ${row.productSku} · ${Formatters.date(row.createdAt)}'
                      '${row.referenceNumber != null ? ' · ${row.referenceNumber}' : ''}',
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          row.inQuantity > 0
                              ? '+${Formatters.quantity(row.inQuantity)}'
                              : '-${Formatters.quantity(row.outQuantity)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: row.inQuantity > 0 ? AppColors.success : AppColors.error,
                          ),
                        ),
                        Text(
                          'Balance: ${Formatters.quantity(row.resultingStock)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (row != state.items.last) const Divider(height: 1),
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
