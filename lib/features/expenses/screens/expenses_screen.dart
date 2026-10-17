import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/search_input.dart';
import '../providers/expense_category_providers.dart';
import '../providers/expense_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD', 'OTHER'];

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
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
      ref.read(expenseListProvider.notifier).loadMore();
    }
  }

  Future<void> _pickDateRange(ExpenseListNotifier notifier) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) notifier.setDateRange(range.start, range.end);
  }

  void _showFilterSheet(ExpenseListState state, ExpenseListNotifier notifier) {
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
                Text('Filter Expenses', style: Theme.of(context).textTheme.titleMedium),
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
    final state = ref.watch(expenseListProvider);
    final notifier = ref.read(expenseListProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_outlined),
            tooltip: 'Expense Summary',
            onPressed: () => context.push('/expenses/summary'),
          ),
          IconButton(
            icon: const Icon(Icons.category_outlined),
            tooltip: 'Categories',
            onPressed: () => context.push('/expenses/categories'),
          ),
          IconButton(
            icon: Icon(state.hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(state, notifier),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search expenses',
              onChanged: notifier.setSearch,
            ),
          ),
          Expanded(
            child: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(state, notifier)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () => context.push('/expenses/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(ExpenseListState state, ExpenseListNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.request_quote_outlined,
        title: 'No expenses yet',
        description: 'Tap + to record your first business expense.',
      );
    }

    return ListView(
      controller: _scrollController,
      // Bottom padding lets the last row scroll clear of the FAB.
      padding: const EdgeInsets.fromLTRB(16, 16, 16, AppSpacing.fabClearance),
      children: [
        Card(
          child: Column(
            children: [
              for (final expense in state.items) ...[
                ListTile(
                  title: Text(expense.title),
                  subtitle: Text(
                    '${expense.categoryName} · ${Formatters.date(expense.expenseDate)} · ${expense.paymentMethod}',
                  ),
                  trailing: Text(
                    Formatters.currency(expense.amount),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: expense.status == 'CANCELLED' ? AppColors.error : AppColors.primary,
                      decoration: expense.status == 'CANCELLED' ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  onTap: () => context.push('/expenses/${expense.id}'),
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
