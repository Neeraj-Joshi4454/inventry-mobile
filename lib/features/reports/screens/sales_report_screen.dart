import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../customers/providers/customer_providers.dart';
import '../../inventory/widgets/product_picker_page.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

class SalesReportScreen extends ConsumerStatefulWidget {
  const SalesReportScreen({super.key});

  @override
  ConsumerState<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends ConsumerState<SalesReportScreen> {
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
      ref.read(salesReportProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(SalesReportNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  void _showFilterSheet(SalesReportState state, SalesReportNotifier notifier) {
    final customersAsync = ref.read(customersProvider);
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
                Text('Filter Sales Report', style: Theme.of(context).textTheme.titleMedium),
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
                Text('Customer', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                customersAsync.when(
                  loading: () =>
                      const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2)),
                  error: (error, _) => Text('$error'),
                  data: (customers) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('All Customers'),
                        selected: state.customerId == null,
                        onSelected: (_) {
                          notifier.setCustomer(null);
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                      for (final customer in customers)
                        ChoiceChip(
                          label: Text(customer.name),
                          selected: state.customerId == customer.id,
                          onSelected: (_) {
                            notifier.setCustomer(customer.id);
                            Navigator.of(sheetContext).pop();
                          },
                        ),
                    ],
                  ),
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
    final state = ref.watch(salesReportProvider);
    final notifier = ref.read(salesReportProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Sales Report'),
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

  Widget _buildBody(SalesReportState state, SalesReportNotifier notifier) {
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
              SummaryCard(label: 'Total Sales', value: '${summary.totalSales}'),
              SummaryCard(label: 'Qty Sold', value: Formatters.quantity(summary.totalQuantitySold)),
              SummaryCard(label: 'Net Sales', value: Formatters.currency(summary.netSales), color: AppColors.success),
              SummaryCard(label: 'Tax', value: Formatters.currency(summary.totalTax)),
            ],
          ),
        const SizedBox(height: 16),
        if (state.items.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: EmptyState(
              icon: Icons.point_of_sale_outlined,
              title: 'No sales in this range',
              description: 'Try widening the date range or clearing filters.',
            ),
          )
        else
          Card(
            child: Column(
              children: [
                for (final sale in state.items) ...[
                  ListTile(
                    title: Text(sale.saleNumber),
                    subtitle: Text('${sale.customerName} · ${Formatters.date(sale.saleDate)}'),
                    trailing: Text(
                      Formatters.currency(sale.totalAmount),
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
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
}
