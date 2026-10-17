import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/status_badge.dart';
import '../providers/purchase_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class PurchaseDetailScreen extends ConsumerWidget {
  const PurchaseDetailScreen({super.key, required this.purchaseId});

  final String purchaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(purchaseDetailProvider(purchaseId));

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Purchase Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            tooltip: 'View Purchase Bill',
            onPressed: () => context.push('/purchases/$purchaseId/invoice'),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) =>
            ErrorView(message: error.toString(), onRetry: () => ref.invalidate(purchaseDetailProvider(purchaseId))),
        data: (result) {
          final purchase = result.purchase;
          return ListView(
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
                          Text(purchase.purchaseNumber, style: Theme.of(context).textTheme.titleLarge),
                          PaymentStatusBadge(status: purchase.paymentStatus),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(Formatters.date(purchase.purchaseDate), style: Theme.of(context).textTheme.bodySmall),
                      const Divider(height: 24),
                      Row(
                        children: [
                          const Icon(Icons.local_shipping_outlined, size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Text(purchase.supplierName, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      if (purchase.invoiceNumber != null && purchase.invoiceNumber!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.receipt_long_outlined, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text('Invoice: ${purchase.invoiceNumber}', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ],
                      if (purchase.createdByName != null && purchase.createdByName!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text('Created by ${purchase.createdByName}', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ],
                      if (purchase.notes != null && purchase.notes!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.notes_outlined, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Expanded(child: Text(purchase.notes!, style: Theme.of(context).textTheme.bodyMedium)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Items', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    for (final item in result.items) ...[
                      ListTile(
                        title: Text(item.productName),
                        subtitle: Text(
                          '${Formatters.quantity(item.quantity)} ${item.unitSymbol} × ${Formatters.currency(item.unitPrice)}'
                          '${item.taxRate > 0 ? ' (+${item.taxRate}% tax)' : ''}'
                          '${item.previousStock != null && item.resultingStock != null ? ' · stock ${Formatters.quantity(item.previousStock!)} → ${Formatters.quantity(item.resultingStock!)}' : ''}',
                        ),
                        trailing: Text(
                          Formatters.currency(item.lineTotal),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (item != result.items.last) const Divider(height: 1),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _SummaryRow(label: 'Subtotal', value: purchase.subTotal),
                      _SummaryRow(label: 'Discount', value: -purchase.discountAmount),
                      _SummaryRow(label: 'Taxable Amount', value: purchase.taxableAmount),
                      if (purchase.taxType == 'IGST')
                        _SummaryRow(label: 'IGST', value: purchase.igstAmount)
                      else if (purchase.taxType == 'CGST_SGST' || purchase.taxType == 'UTGST') ...[
                        _SummaryRow(label: 'CGST', value: purchase.cgstAmount),
                        _SummaryRow(label: purchase.taxType == 'UTGST' ? 'UTGST' : 'SGST', value: purchase.sgstAmount),
                      ],
                      _SummaryRow(label: 'Total Tax', value: purchase.taxAmount),
                      const Divider(height: 20),
                      _SummaryRow(label: 'Grand Total', value: purchase.totalAmount, emphasize: true),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.emphasize = false});

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: emphasize ? FontWeight.w700 : FontWeight.w400, fontSize: emphasize ? 16 : 14),
          ),
          Text(
            Formatters.currency(value),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: emphasize ? 18 : 14,
              color: emphasize ? AppColors.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
