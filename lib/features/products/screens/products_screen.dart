import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/filter_chip_bar.dart';
import '../../../core/widgets/list_row_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/search_input.dart';
import '../providers/product_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
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
      ref.read(productListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Products')),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () => context.push('/products/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xs),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by name or SKU',
              onChanged: (value) => ref.read(productListProvider.notifier).setSearch(value),
            ),
          ),
          SizedBox(
            height: FilterChipBar.height,
            child: categoriesAsync.maybeWhen(
              data: (categories) => FilterChipBar<String?>(
                semanticLabel: 'Category filter',
                selected: state.categoryId,
                onSelected: (id) => ref.read(productListProvider.notifier).setCategory(id),
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

  Widget _buildBody(ProductListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const ListSkeleton();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(productListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      final filtered = state.search.isNotEmpty || state.categoryId != null;
      return RefreshIndicator(
        onRefresh: () => ref.read(productListProvider.notifier).refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: AppSpacing.xxl),
            filtered
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'No matching products',
                    description: 'Try a different search or category.',
                  )
                : EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'No products yet',
                    description: 'Add a product to start building your catalog.',
                    action: AppButton(
                      label: 'Add product',
                      icon: Icons.add,
                      variant: AppButtonVariant.secondary,
                      expand: false,
                      onPressed: () => context.push('/products/new'),
                    ),
                  ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(productListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.fabClearance),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.items.length) return const ListLoadingMore();
          final product = state.items[index];
          return ListRowCard(
            key: ValueKey(product.id),
            title: product.name,
            subtitle: '${product.sku} · ${product.category.name}',
            onTap: () => context.push('/inventory/${product.id}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Formatters.currency(product.sellingPrice),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Text('Selling price', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: AppSizes.iconSm),
                  tooltip: 'Edit product',
                  onPressed: () => context.push('/products/${product.id}/edit', extra: product),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
