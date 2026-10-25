import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/report_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ProfitSummaryScreen extends ConsumerWidget {
  const ProfitSummaryScreen({super.key});

  Future<void> _pickDateRange(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) {
      ref.read(profitSummaryProvider.notifier).setDateRange(range.start, range.end);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profitSummaryProvider);
    final notifier = ref.read(profitSummaryProvider.notifier);
    final hasRange = state.fromDate != null || state.toDate != null;

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Profit Summary'),
        actions: [
          IconButton(
            icon: Icon(hasRange ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Date range',
            onPressed: () => _pickDateRange(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(context, state, notifier)),
    );
  }

  Widget _buildBody(BuildContext context, ProfitSummaryState state, ProfitSummaryNotifier notifier) {
    if (state.isLoading && state.data == null) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.data == null) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }

    final data = state.data;
    if (data == null) return const SizedBox.shrink();

    final hasRange = state.fromDate != null || state.toDate != null;
    final rangeLabel = hasRange
        ? '${state.fromDate != null ? Formatters.date(state.fromDate!) : 'Start'}'
              ' – ${state.toDate != null ? Formatters.date(state.toDate!) : 'Today'}'
        : 'All time';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(rangeLabel, style: Theme.of(context).textTheme.bodyMedium),
            if (hasRange) TextButton(onPressed: notifier.clearFilters, child: const Text('Clear')),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _Row(label: 'Sales Revenue', value: Formatters.currency(data.salesRevenue)),
                const SizedBox(height: 12),
                _Row(
                  label: 'Cost of Goods Sold',
                  value: '- ${Formatters.currency(data.costOfGoodsSold)}',
                  color: AppColors.error,
                ),
                const Divider(height: 32),
                _Row(
                  label: 'Gross Profit',
                  value: Formatters.currency(data.grossProfit),
                  emphasize: true,
                  color: data.grossProfit >= 0 ? AppColors.success : AppColors.error,
                ),
                const SizedBox(height: 16),
                _Row(label: 'Gross Margin', value: '${data.grossMarginPercent.toStringAsFixed(1)}%', emphasize: true),
                const SizedBox(height: 16),
                _Row(
                  label: 'Operating Expenses',
                  value: '- ${Formatters.currency(data.operatingExpenses)}',
                  color: AppColors.error,
                ),
                const Divider(height: 32),
                _Row(
                  label: 'Net Profit',
                  value: Formatters.currency(data.netProfit),
                  emphasize: true,
                  color: data.netProfit >= 0 ? AppColors.success : AppColors.error,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'All amounts exclude GST. Cost of goods sold is each sold item\'s quantity × its '
          'average purchase cost across all your purchases (or the product\'s purchase price '
          'if it was never purchased).',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.color, this.emphasize = false});

  final String label;
  final String value;
  final Color? color;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: emphasize ? 16 : 14, fontWeight: emphasize ? FontWeight.w700 : null),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: emphasize ? 20 : 16,
            fontWeight: FontWeight.w700,
            color: color ?? (emphasize ? AppColors.primary : null),
          ),
        ),
      ],
    );
  }
}
