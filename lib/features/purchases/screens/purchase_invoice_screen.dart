import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../core/constants/brand.dart';
import '../../../core/storage/local_image_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/purchase_invoice.dart';
import '../providers/purchase_providers.dart';
import '../utils/purchase_invoice_pdf_builder.dart';
import '../../../core/widgets/brand_app_bar.dart';

/// Purchase-side mirror of sales/screens/invoice_screen.dart — same
/// on-screen preview plus native print/share via the `printing` package.
class PurchaseInvoiceScreen extends ConsumerWidget {
  const PurchaseInvoiceScreen({super.key, required this.purchaseId});

  final String purchaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceAsync = ref.watch(purchaseInvoiceProvider(purchaseId));

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Purchase Bill'),
        actions: [
          invoiceAsync.maybeWhen(
            data: (invoice) => Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.print_outlined),
                  tooltip: 'Print',
                  onPressed: () async {
                    final doc = await buildPurchaseInvoicePdf(invoice, logo: await _logoBytes(ref));
                    await Printing.layoutPdf(onLayout: (_) => doc.save());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.ios_share_outlined),
                  tooltip: 'Share / Download',
                  onPressed: () async {
                    final doc = await buildPurchaseInvoicePdf(invoice, logo: await _logoBytes(ref));
                    await Printing.sharePdf(bytes: await doc.save(), filename: '${invoice.invoiceNumber}.pdf');
                  },
                ),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: invoiceAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) =>
            ErrorView(message: '$error', onRetry: () => ref.invalidate(purchaseInvoiceProvider(purchaseId))),
        data: (invoice) => _PurchaseInvoicePreview(invoice: invoice, logo: ref.watch(businessLogoProvider).valueOrNull),
      ),
    );
  }
}

class _PurchaseInvoicePreview extends StatelessWidget {
  const _PurchaseInvoicePreview({required this.invoice, this.logo});

  final PurchaseInvoice invoice;
  final File? logo;

  @override
  Widget build(BuildContext context) {
    final showCgstSgst = invoice.taxType == 'CGST_SGST' || invoice.taxType == 'UTGST';
    final stateTaxLabel = invoice.taxType == 'UTGST' ? 'UTGST' : 'SGST';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (logo != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(logo!, key: ValueKey(logo!.path), width: 56, height: 56, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(invoice.business.name ?? 'Business', style: Theme.of(context).textTheme.titleLarge),
                          if (invoice.business.addressLine != null) Text(invoice.business.addressLine!),
                          if (invoice.business.contactLine != null) Text(invoice.business.contactLine!),
                          if (invoice.business.gstin != null) Text('GSTIN: ${invoice.business.gstin}'),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text('Purchase #${invoice.invoiceNumber}', style: const TextStyle(fontWeight: FontWeight.w600)),
                if (invoice.supplierInvoiceNumber != null) Text('Supplier Bill #${invoice.supplierInvoiceNumber}'),
                Text(Formatters.date(invoice.invoiceDate)),
                const SizedBox(height: 12),
                Text('Purchased From', style: Theme.of(context).textTheme.labelLarge),
                Text(invoice.supplier.name ?? 'Supplier'),
                if (invoice.supplier.addressLine != null) Text(invoice.supplier.addressLine!),
                if (invoice.supplier.gstin != null) Text('GSTIN: ${invoice.supplier.gstin}'),
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
              for (final item in invoice.items) ...[
                ListTile(
                  title: Text(item.productName ?? 'Item'),
                  subtitle: Text(
                    '${item.hsnCode != null ? 'HSN ${item.hsnCode} · ' : ''}'
                    '${Formatters.quantity(item.quantity)} ${item.unitSymbol ?? ''} × '
                    '${Formatters.currency(item.rate)}'
                    '${item.discount > 0 ? ' · disc ${Formatters.currency(item.discount)}' : ''}',
                  ),
                  trailing: Text(
                    Formatters.currency(item.lineTotal),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (item != invoice.items.last) const Divider(height: 1),
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
                _Row(label: 'Subtotal', value: invoice.subTotal),
                _Row(label: 'Discount', value: -invoice.discountAmount),
                _Row(label: 'Taxable Amount', value: invoice.taxableAmount),
                if (invoice.taxType == 'IGST')
                  _Row(label: 'IGST', value: invoice.igstAmount)
                else if (showCgstSgst) ...[
                  _Row(label: 'CGST', value: invoice.cgstAmount),
                  _Row(label: stateTaxLabel, value: invoice.sgstAmount),
                ],
                _Row(label: 'Total Tax', value: invoice.totalTax),
                const Divider(height: 20),
                _Row(label: 'Grand Total', value: invoice.grandTotal, emphasize: true),
              ],
            ),
          ),
        ),
        if (invoice.invoiceFooterNote != null && invoice.invoiceFooterNote!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(invoice.invoiceFooterNote!, style: Theme.of(context).textTheme.bodySmall),
        ],
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 8),
        Text(Brand.invoiceAttribution(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.emphasize = false});

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

/// Bytes of this phone's business logo for the PDF, or null if none is set.
Future<Uint8List?> _logoBytes(WidgetRef ref) async {
  final file = await ref.read(businessLogoProvider.future);
  return file?.readAsBytes();
}
