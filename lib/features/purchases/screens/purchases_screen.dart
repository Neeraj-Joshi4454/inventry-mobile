import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/list_row_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/search_input.dart';
import '../../../core/widgets/status_badge.dart';
import '../../suppliers/providers/supplier_providers.dart';
import '../providers/purchase_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class PurchasesScreen extends ConsumerStatefulWidget {
  const PurchasesScreen({super.key});

  @override
  ConsumerState<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends ConsumerState<PurchasesScreen> {
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
      ref.read(purchaseListProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(PurchaseListState state, PurchaseListNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: state.fromDate != null && state.toDate != null
          ? DateTimeRange(start: state.fromDate!, end: state.toDate!)
          : null,
    );
    if (range != null) {
      notifier.setDateRange(range.start, range.end);
    }
  }

  void _showFilterSheet(PurchaseListState state, PurchaseListNotifier notifier) {
    final suppliersAsync = ref.read(suppliersProvider);
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
                Text('Filter Purchases', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _pickDateRange(state, notifier);
                  },
                  icon: const Icon(Icons.date_range_outlined),
                  label: Text(
                    state.fromDate != null && state.toDate != null
                        ? '${Formatters.date(state.fromDate!)} – ${Formatters.date(state.toDate!)}'
                        : 'Choose Date Range',
                  ),
                ),
                const SizedBox(height: 12),
                Text('Supplier', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                suppliersAsync.when(
                  loading: () =>
                      const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2)),
                  error: (error, _) => Text('$error'),
                  data: (suppliers) => Flexible(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('All Suppliers'),
                            selected: state.supplierId == null,
                            onSelected: (_) {
                              notifier.setSupplier(null);
                              Navigator.of(sheetContext).pop();
                            },
                          ),
                          for (final supplier in suppliers)
                            ChoiceChip(
                              label: Text(supplier.name),
                              selected: state.supplierId == supplier.id,
                              onSelected: (_) {
                                notifier.setSupplier(supplier.id);
                                Navigator.of(sheetContext).pop();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
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

  /// "Shree Traders · 1 Oct – 17 Oct" — what the list is narrowed to.
  String _activeFilterSummary(PurchaseListState state) {
    final parts = <String>[];
    if (state.supplierId != null) {
      final suppliers = ref.read(suppliersProvider).valueOrNull ?? const [];
      final match = suppliers.where((s) => s.id == state.supplierId);
      parts.add(match.isEmpty ? 'One supplier' : match.first.name);
    }
    if (state.fromDate != null && state.toDate != null) {
      parts.add('${Formatters.date(state.fromDate!)} – ${Formatters.date(state.toDate!)}');
    }
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchaseListProvider);
    final notifier = ref.read(purchaseListProvider.notifier);
    // Re-render the summary once supplier names arrive.
    ref.watch(suppliersProvider);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Purchases'),
        actions: [
          IconButton(
            icon: Icon(state.hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(state, notifier),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () async {
          await context.push('/purchases/new');
          ref.read(purchaseListProvider.notifier).refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('New Purchase'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by purchase number',
              onChanged: notifier.setSearch,
            ),
          ),
          if (state.hasActiveFilters)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _activeFilterSummary(state),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(onPressed: notifier.clearFilters, child: const Text('Clear')),
                ],
              ),
            ),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(PurchaseListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const ListSkeleton();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(purchaseListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      final filtered = state.hasActiveFilters || state.search.isNotEmpty;
      return EmptyState(
        icon: Icons.shopping_bag_outlined,
        title: filtered ? 'No matching purchases' : 'No purchases yet',
        description: filtered
            ? 'Try a different search, supplier or date range.'
            : 'Record a stock-in purchase to see it here.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(purchaseListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.fabClearance),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.items.length) return const ListLoadingMore();
          final purchase = state.items[index];
          return ListRowCard(
            key: ValueKey(purchase.id),
            title: purchase.purchaseNumber,
            subtitle: '${purchase.supplierName} · ${Formatters.date(purchase.purchaseDate)}',
            onTap: () => context.push('/purchases/${purchase.id}'),
            trailing: _AmountWithStatus(amount: purchase.totalAmount, paymentStatus: purchase.paymentStatus),
          );
        },
      ),
    );
  }
}

class _AmountWithStatus extends StatelessWidget {
  const _AmountWithStatus({required this.amount, required this.paymentStatus});

  final double amount;
  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Formatters.currency(amount),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        PaymentStatusBadge(status: paymentStatus),
      ],
    );
  }
}
