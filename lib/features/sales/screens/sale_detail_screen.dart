import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/status_badge.dart';
import '../../customerPayments/screens/add_payment_screen.dart';
import '../providers/sale_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class SaleDetailScreen extends ConsumerWidget {
  const SaleDetailScreen({super.key, required this.saleId});

  final String saleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(saleDetailProvider(saleId));

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Sale Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            tooltip: 'View Invoice',
            onPressed: () => context.push('/sales/$saleId/invoice'),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) =>
            ErrorView(message: error.toString(), onRetry: () => ref.invalidate(saleDetailProvider(saleId))),
        data: (result) {
          final sale = result.sale;
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
                          Text(sale.saleNumber, style: Theme.of(context).textTheme.titleLarge),
                          PaymentStatusBadge(status: sale.paymentStatus),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(Formatters.date(sale.saleDate), style: Theme.of(context).textTheme.bodySmall),
                      const Divider(height: 24),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Text(sale.customerName, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      if (sale.notes != null && sale.notes!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.notes_outlined, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Expanded(child: Text(sale.notes!)),
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
                          '${Formatters.quantity(item.quantity)} ${item.unitSymbol} × '
                          '${Formatters.currency(item.unitPrice)}'
                          '${item.taxRate > 0 ? ' (+${item.taxRate}% tax)' : ''}',
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
                      _SummaryRow(label: 'Subtotal', value: sale.subTotal),
                      _SummaryRow(label: 'Discount', value: -sale.discountAmount),
                      _SummaryRow(label: 'Taxable Amount', value: sale.taxableAmount),
                      if (sale.taxType == 'IGST')
                        _SummaryRow(label: 'IGST', value: sale.igstAmount)
                      else if (sale.taxType == 'CGST_SGST' || sale.taxType == 'UTGST') ...[
                        _SummaryRow(label: 'CGST', value: sale.cgstAmount),
                        _SummaryRow(label: sale.taxType == 'UTGST' ? 'UTGST' : 'SGST', value: sale.sgstAmount),
                      ],
                      _SummaryRow(label: 'Total Tax', value: sale.taxAmount),
                      const Divider(height: 20),
                      _SummaryRow(label: 'Grand Total', value: sale.totalAmount, emphasize: true),
                      const Divider(height: 20),
                      _SummaryRow(label: 'Paid', value: sale.paidAmount),
                      _SummaryRow(
                        label: 'Outstanding',
                        value: sale.dueAmount,
                        valueColor: sale.dueAmount > 0 ? AppColors.warning : AppColors.success,
                      ),
                    ],
                  ),
                ),
              ),
              if (sale.dueAmount > 0) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final recorded = await Navigator.of(context).push<bool>(
                      MaterialPageRoute<bool>(
                        builder: (_) => AddPaymentScreen(
                          saleId: sale.id,
                          customerId: sale.customerId ?? '',
                          saleNumber: sale.saleNumber,
                          dueAmount: sale.dueAmount,
                        ),
                      ),
                    );
                    if (recorded == true) {
                      ref.invalidate(saleDetailProvider(saleId));
                    }
                  },
                  icon: const Icon(Icons.add_card_outlined),
                  label: const Text('Add Payment'),
                ),
              ],
              const SizedBox(height: 16),
              if (sale.createdByName != null)
                Text(
                  'Created by ${sale.createdByName}'
                  '${sale.createdAt != null ? ' on ${Formatters.dateTime(sale.createdAt!)}' : ''}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (result.payments.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('Payment History', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      for (final payment in result.payments) ...[
                        ListTile(
                          title: Text(Formatters.currency(payment.amount)),
                          subtitle: Text(
                            '${payment.method} · ${Formatters.date(payment.paymentDate)}'
                            '${payment.referenceNumber != null ? ' · Ref ${payment.referenceNumber}' : ''}'
                            '${payment.notes != null && payment.notes!.isNotEmpty ? ' · ${payment.notes}' : ''}',
                          ),
                          trailing: const Icon(Icons.check_circle_outline, color: AppColors.success),
                        ),
                        if (payment != result.payments.last) const Divider(height: 1),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.emphasize = false, this.valueColor});

  final String label;
  final double value;
  final bool emphasize;
  final Color? valueColor;

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
              color: valueColor ?? (emphasize ? AppColors.primary : null),
            ),
          ),
        ],
      ),
    );
  }
}
