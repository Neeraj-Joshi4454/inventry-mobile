import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/filter_chip_bar.dart';
import '../../../core/widgets/list_row_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/search_input.dart';
import '../../products/providers/product_providers.dart';
import '../data/models/stock_status.dart';
import '../providers/inventory_providers.dart';
import '../widgets/product_picker_page.dart';
import '../widgets/stock_status_chip.dart';
import '../../../core/widgets/brand_app_bar.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
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
      ref.read(inventoryListProvider.notifier).loadMore();
    }
  }

  Future<void> _openStockHistory() async {
    final picked = await pickProduct(context);
    if (!mounted || picked == null) return;
    context.push('/inventory/${picked.productId}/ledger');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Stock Adjustment',
            onPressed: () => context.push('/inventory/adjustment'),
          ),
          IconButton(icon: const Icon(Icons.history), tooltip: 'Stock History', onPressed: _openStockHistory),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () => context.push('/purchases/new'),
        icon: const Icon(Icons.add_shopping_cart_outlined),
        label: const Text('Purchase stock'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xs),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by name or SKU',
              onChanged: (value) => ref.read(inventoryListProvider.notifier).setSearch(value),
            ),
          ),
          FilterChipBar<StockStatus?>(
            semanticLabel: 'Stock status filter',
            selected: state.status,
            onSelected: (status) => ref.read(inventoryListProvider.notifier).setStatus(status),
            options: [
              const FilterOption(null, 'All status'),
              for (final status in StockStatus.values) FilterOption(status, status.label),
            ],
          ),
          // Fixed-height slot whether categories are loading, loaded or
          // failed, so the list below never jumps when they arrive.
          SizedBox(
            height: FilterChipBar.height,
            child: categoriesAsync.maybeWhen(
              data: (categories) => FilterChipBar<String?>(
                semanticLabel: 'Category filter',
                selected: state.categoryId,
                onSelected: (id) => ref.read(inventoryListProvider.notifier).setCategory(id),
                options: [
                  const FilterOption(null, 'All categories'),
                  for (final category in categories) FilterOption(category.id, category.name),
                ],
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
          const Divider(),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(InventoryListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const ListSkeleton();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(inventoryListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => ref.read(inventoryListProvider.notifier).refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: AppSpacing.xxl),
            EmptyState(
              icon: Icons.inventory_outlined,
              title: 'No matching products',
              description: 'Try a different search or filter.',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(inventoryListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.fabClearance),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.items.length) return const ListLoadingMore();
          final item = state.items[index];
          return ListRowCard(
            key: ValueKey(item.productId),
            title: item.name,
            subtitle: '${item.sku} · ${item.category.name}',
            onTap: () => context.push('/inventory/${item.productId}'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: Formatters.quantity(item.currentStock),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ' ${item.unit.symbol}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: AppSpacing.xs),
                StockStatusChip(status: item.status),
              ],
            ),
          );
        },
      ),
    );
  }
}
