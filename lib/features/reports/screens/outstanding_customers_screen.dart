import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/search_input.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

class OutstandingCustomersScreen extends ConsumerStatefulWidget {
  const OutstandingCustomersScreen({super.key});

  @override
  ConsumerState<OutstandingCustomersScreen> createState() => _OutstandingCustomersScreenState();
}

class _OutstandingCustomersScreenState extends ConsumerState<OutstandingCustomersScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

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
      ref.read(outstandingCustomersProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(outstandingCustomersProvider);
    final notifier = ref.read(outstandingCustomersProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Outstanding Customers')),
      body: RefreshIndicator(
        onRefresh: notifier.refresh,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            SearchInput(controller: _searchController, hintText: 'Search customer', onChanged: notifier.setSearch),
            const SizedBox(height: 16),
            if (state.summary != null)
              SummaryCardGrid(
                cards: [
                  SummaryCard(
                    label: 'Customers Owing',
                    value: '${state.summary!.totalOutstandingCustomers}',
                    color: AppColors.warning,
                  ),
                  SummaryCard(
                    label: 'Total Outstanding',
                    value: Formatters.currency(state.summary!.totalOutstandingAmount),
                    color: AppColors.error,
                  ),
                ],
              ),
            const SizedBox(height: 16),
            _buildBody(state),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(OutstandingCustomersState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: LoadingIndicator());
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.invalidate(outstandingCustomersProvider));
    }
    if (state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: EmptyState(
          icon: Icons.check_circle_outline,
          title: 'No outstanding balances',
          description: 'Every customer is paid up.',
        ),
      );
    }

    return Card(
      child: Column(
        children: [
          for (final row in state.items) ...[
            ListTile(
              title: Text(row.customerName),
              subtitle: Text(
                'Sold ${Formatters.currency(row.totalSales)} · Paid ${Formatters.currency(row.paidAmount)}'
                '${row.lastTransactionDate != null ? ' · Last: ${Formatters.date(row.lastTransactionDate!)}' : ''}',
              ),
              trailing: Text(
                Formatters.currency(row.outstandingAmount),
                style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.error),
              ),
              onTap: () => context.push('/customers/${row.customerId}'),
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
    );
  }
}
