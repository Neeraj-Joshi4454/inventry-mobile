import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../expenses/providers/expense_category_providers.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD', 'OTHER'];

class ExpenseReportScreen extends ConsumerStatefulWidget {
  const ExpenseReportScreen({super.key});

  @override
  ConsumerState<ExpenseReportScreen> createState() => _ExpenseReportScreenState();
}

class _ExpenseReportScreenState extends ConsumerState<ExpenseReportScreen> {
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
      ref.read(expenseReportProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(ExpenseReportNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  void _showFilterSheet(ExpenseReportState state, ExpenseReportNotifier notifier) {
    final categoriesAsync = ref.read(activeExpenseCategoriesProvider);
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
                Text('Filter Expense Report', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _pickDateRange(notifier);
                  },
                  icon: const Icon(Icons.date_range_outlined),
                  label: const Text('Choose Date Range'),
                ),
                const SizedBox(height: 16),
                Text('Category', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                categoriesAsync.when(
                  loading: () =>
                      const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2)),
                  error: (error, _) => Text('$error'),
                  data: (categories) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('All Categories'),
                        selected: state.categoryId == null,
                        onSelected: (_) {
                          notifier.setCategory(null);
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                      for (final category in categories)
                        ChoiceChip(
                          label: Text(category.name),
                          selected: state.categoryId == category.id,
                          onSelected: (_) {
                            notifier.setCategory(category.id);
                            Navigator.of(sheetContext).pop();
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text('Payment Method', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Methods'),
                      selected: state.paymentMethod == null,
                      onSelected: (_) {
                        notifier.setPaymentMethod(null);
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                    for (final method in _paymentMethods)
                      ChoiceChip(
                        label: Text(method),
                        selected: state.paymentMethod == method,
                        onSelected: (_) {
                          notifier.setPaymentMethod(method);
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
    final state = ref.watch(expenseReportProvider);
    final notifier = ref.read(expenseReportProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Expense Report'),
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

  Widget _buildBody(ExpenseReportState state, ExpenseReportNotifier notifier) {
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
              SummaryCard(label: 'Total Expenses', value: '${summary.totalExpenses}'),
              SummaryCard(
                label: 'Total Amount',
                value: Formatters.currency(summary.totalAmount),
                color: AppColors.error,
              ),
            ],
          ),
        if (state.categoryBreakdown.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('By Category', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                for (final row in state.categoryBreakdown) ...[
                  ListTile(dense: true, title: Text(row.categoryName), trailing: Text(Formatters.currency(row.amount))),
                  if (row != state.categoryBreakdown.last) const Divider(height: 1),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        if (state.items.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: EmptyState(
              icon: Icons.request_quote_outlined,
              title: 'No expenses in this range',
              description: 'Try widening the date range or clearing filters.',
            ),
          )
        else
          Card(
            child: Column(
              children: [
                for (final expense in state.items) ...[
                  ListTile(
                    title: Text(expense.title),
                    subtitle: Text('${expense.categoryName} · ${Formatters.date(expense.expenseDate)}'),
                    trailing: Text(
                      Formatters.currency(expense.amount),
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                  ),
                  if (expense != state.items.last) const Divider(height: 1),
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
