import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/search_input.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/list_row_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../customers/providers/customer_providers.dart';
import '../providers/sale_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
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
      ref.read(saleListProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(SaleListNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) {
      notifier.setDateRange(range.start, range.end);
    }
  }

  void _showFilterSheet(SaleListState state, SaleListNotifier notifier) {
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
                Text('Filter Sales', style: Theme.of(context).textTheme.titleMedium),
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
                if (state.customerId != null || state.fromDate != null) ...[
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
    final state = ref.watch(saleListProvider);
    final notifier = ref.read(saleListProvider.notifier);
    final hasActiveFilters = state.customerId != null || state.fromDate != null;

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Sales'),
        actions: [
          IconButton(
            icon: Icon(hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
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
          await context.push('/sales/new');
          ref.read(saleListProvider.notifier).refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('New Sale'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by sale number',
              onChanged: (value) => notifier.setSearch(value),
            ),
          ),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(SaleListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const ListSkeleton();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(saleListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.point_of_sale_outlined,
        title: 'No sales yet',
        description: 'Record a sale to see it here.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(saleListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.fabClearance),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.items.length) return const ListLoadingMore();
          final sale = state.items[index];
          return ListRowCard(
            key: ValueKey(sale.id),
            title: sale.saleNumber,
            subtitle:
                '${sale.customerName} · ${Formatters.date(sale.saleDate)}'
                '${sale.createdByName != null ? ' · ${sale.createdByName}' : ''}',
            onTap: () => context.push('/sales/${sale.id}'),
            trailing: _AmountWithStatus(amount: sale.totalAmount, paymentStatus: sale.paymentStatus),
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
