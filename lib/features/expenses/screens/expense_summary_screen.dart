import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../reports/widgets/summary_card.dart';
import '../providers/expense_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ExpenseSummaryScreen extends ConsumerWidget {
  const ExpenseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(expenseSummaryProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Expense Summary')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(expenseSummaryProvider.future),
        child: summaryAsync.when(
          loading: () => const LoadingIndicator(),
          error: (error, _) => ErrorView(message: '$error', onRetry: () => ref.invalidate(expenseSummaryProvider)),
          data: (summary) {
            final comparison = summary.previousMonthComparison;
            final isIncrease = comparison.change >= 0;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SummaryCardGrid(
                  cards: [
                    SummaryCard(
                      label: "Today's Expenses",
                      value: Formatters.currency(summary.todayExpenses.amount),
                      color: AppColors.error,
                    ),
                    SummaryCard(
                      label: 'This Month',
                      value: Formatters.currency(summary.thisMonthExpenses.amount),
                      color: AppColors.error,
                    ),
                    SummaryCard(label: 'Total Expenses', value: Formatters.currency(summary.totalExpenses.amount)),
                    SummaryCard(label: 'Total Entries', value: '${summary.totalExpenses.count}'),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('vs. Previous Month', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Previous: ${Formatters.currency(comparison.previousMonthAmount)}'),
                            Text('Current: ${Formatters.currency(comparison.currentMonthAmount)}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                              size: 16,
                              color: isIncrease ? AppColors.error : AppColors.success,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${Formatters.currency(comparison.change.abs())} '
                              '(${comparison.changePercent.abs().toStringAsFixed(1)}%)',
                              style: TextStyle(
                                color: isIncrease ? AppColors.error : AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('By Category', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (summary.expensesByCategory.isEmpty)
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('No expenses recorded yet.'))
                else
                  Card(
                    child: Column(
                      children: [
                        for (final row in summary.expensesByCategory) ...[
                          ListTile(
                            title: Text(row.categoryName),
                            subtitle: Text('${row.count} entries'),
                            trailing: Text(
                              Formatters.currency(row.amount),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (row != summary.expensesByCategory.last) const Divider(height: 1),
                        ],
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                Text('By Payment Method', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (summary.expensesByPaymentMethod.isEmpty)
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('No expenses recorded yet.'))
                else
                  Card(
                    child: Column(
                      children: [
                        for (final row in summary.expensesByPaymentMethod) ...[
                          ListTile(
                            title: Text(row.paymentMethod),
                            subtitle: Text('${row.count} entries'),
                            trailing: Text(
                              Formatters.currency(row.amount),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (row != summary.expensesByPaymentMethod.last) const Divider(height: 1),
                        ],
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
