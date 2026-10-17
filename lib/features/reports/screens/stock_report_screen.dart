import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/filter_chip_bar.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/search_input.dart';
import '../../inventory/data/models/stock_status.dart';
import '../../inventory/widgets/stock_status_chip.dart';
import '../../products/providers/product_providers.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

class StockReportScreen extends ConsumerStatefulWidget {
  const StockReportScreen({super.key});

  @override
  ConsumerState<StockReportScreen> createState() => _StockReportScreenState();
}

class _StockReportScreenState extends ConsumerState<StockReportScreen> {
  final _searchController = TextEditingController();
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
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(stockReportProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockReportProvider);
    final notifier = ref.read(stockReportProvider.notifier);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Stock Report')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xs),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by name or SKU',
              onChanged: notifier.setSearch,
            ),
          ),
          FilterChipBar<String?>(
            semanticLabel: 'Stock status filter',
            selected: state.status,
            onSelected: notifier.setStatus,
            options: [
              const FilterOption(null, 'All status'),
              for (final status in StockStatus.values) FilterOption(status.wireValue, status.label),
            ],
          ),
          SizedBox(
            height: FilterChipBar.height,
            child: categoriesAsync.maybeWhen(
              data: (categories) => FilterChipBar<String?>(
                semanticLabel: 'Category filter',
                selected: state.categoryId,
                onSelected: notifier.setCategory,
                options: [
                  const FilterOption(null, 'All categories'),
                  for (final category in categories) FilterOption(category.id, category.name),
                ],
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
          const Divider(),
          Expanded(child: _buildBody(state, notifier)),
        ],
      ),
    );
  }

  Widget _buildBody(StockReportState state, StockReportNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }

    final summary = state.summary;
    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          if (summary != null)
            SummaryCardGrid(
              cards: [
                SummaryCard(label: 'Products', value: '${summary.totalProducts}'),
                SummaryCard(
                  label: 'Total Stock Value',
                  value: Formatters.currency(summary.totalStockValue),
                  color: AppColors.success,
                ),
              ],
            ),
          const SizedBox(height: 16),
          if (state.items.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: EmptyState(
                icon: Icons.inventory_2_outlined,
                title: 'No matching products',
                description: 'Try a different search or filter.',
              ),
            )
          else
            Card(
              child: Column(
                children: [
                  for (final row in state.items) ...[
                    ListTile(
                      title: Text(row.name),
                      subtitle: Text('${row.sku} · ${row.categoryName}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Formatters.quantity(row.currentStock),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          StockStatusChip(status: row.status),
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
      ),
    );
  }
}
