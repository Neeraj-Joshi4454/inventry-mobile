import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/report_providers.dart';
import '../widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ReportsDashboardScreen extends ConsumerWidget {
  const ReportsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Reports')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSummaryProvider.future),
        child: summaryAsync.when(
          loading: () => const LoadingIndicator(),
          error: (error, _) => ErrorView(message: '$error', onRetry: () => ref.invalidate(dashboardSummaryProvider)),
          data: (summary) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text("Today", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                SummaryCardGrid(
                  cards: [
                    SummaryCard(
                      label: "Today's Sales",
                      value: Formatters.currency(summary.todaysSales.amount),
                      color: AppColors.success,
                    ),
                    SummaryCard(
                      label: "Today's Purchases",
                      value: Formatters.currency(summary.todaysPurchases.amount),
                      color: AppColors.info,
                    ),
                    SummaryCard(
                      label: "Today's Expenses",
                      value: Formatters.currency(summary.todaysExpenses.amount),
                      color: AppColors.error,
                    ),
                    SummaryCard(
                      label: 'Monthly Expenses',
                      value: Formatters.currency(summary.thisMonthExpenses.amount),
                      color: AppColors.error,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Inventory', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                SummaryCardGrid(
                  cards: [
                    SummaryCard(label: 'Total Products', value: '${summary.totalProducts}'),
                    SummaryCard(label: 'Total Stock Value', value: Formatters.currency(summary.totalStockValue)),
                    SummaryCard(label: 'Low Stock', value: '${summary.lowStockProducts}', color: AppColors.warning),
                    SummaryCard(label: 'Out of Stock', value: '${summary.outOfStockProducts}', color: AppColors.error),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Reports', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                _ReportTile(
                  icon: Icons.point_of_sale_outlined,
                  title: 'Sales Report',
                  subtitle: 'Revenue, quantity sold, discounts and tax',
                  onTap: () => context.push('/reports/sales'),
                ),
                _ReportTile(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Purchase Report',
                  subtitle: 'Spend, quantity purchased and tax',
                  onTap: () => context.push('/reports/purchases'),
                ),
                _ReportTile(
                  icon: Icons.inventory_2_outlined,
                  title: 'Stock Report',
                  subtitle: 'Current stock and stock value by product',
                  onTap: () => context.push('/reports/stock'),
                ),
                _ReportTile(
                  icon: Icons.receipt_long_outlined,
                  title: 'Inventory Ledger',
                  subtitle: 'Every stock movement across all products',
                  onTap: () => context.push('/reports/ledger'),
                ),
                _ReportTile(
                  icon: Icons.trending_up_outlined,
                  title: 'Profit Summary',
                  subtitle: 'Revenue, cost of goods sold and margin',
                  onTap: () => context.push('/reports/profit'),
                ),
                _ReportTile(
                  icon: Icons.money_off_outlined,
                  title: 'Outstanding Customers',
                  subtitle: 'Customers with unpaid or partially paid sales',
                  onTap: () => context.push('/reports/outstanding-customers'),
                ),
                _ReportTile(
                  icon: Icons.request_quote_outlined,
                  title: 'Expense Report',
                  subtitle: 'Business expenses by category and date range',
                  onTap: () => context.push('/reports/expenses'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
