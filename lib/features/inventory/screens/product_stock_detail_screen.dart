import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/inventory_providers.dart';
import '../widgets/stock_status_chip.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ProductStockDetailScreen extends ConsumerWidget {
  const ProductStockDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(productStockDetailProvider(productId));

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Product Stock')),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) =>
            ErrorView(message: error.toString(), onRetry: () => ref.invalidate(productStockDetailProvider(productId))),
        data: (item) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(productStockDetailProvider(productId)),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(item.name, style: Theme.of(context).textTheme.titleLarge)),
                            StockStatusChip(status: item.status),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('${item.sku} · ${item.category.name}', style: Theme.of(context).textTheme.bodySmall),
                        const Divider(height: 32),
                        _StatRow(
                          label: 'Current Stock',
                          value: '${Formatters.quantity(item.currentStock)} ${item.unit.symbol}',
                          highlight: true,
                        ),
                        const SizedBox(height: 12),
                        _StatRow(
                          label: 'Minimum Stock',
                          value: '${Formatters.quantity(item.lowStockThreshold)} ${item.unit.symbol}',
                        ),
                        const SizedBox(height: 12),
                        _StatRow(label: 'Unit', value: item.unit.name),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
                    title: const Text('Stock Movement History'),
                    subtitle: const Text('View the full inventory ledger for this product'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/inventory/$productId/ledger'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value, this.highlight = false});

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 20 : 15,
            fontWeight: FontWeight.w700,
            color: highlight ? AppColors.primary : null,
          ),
        ),
      ],
    );
  }
}
