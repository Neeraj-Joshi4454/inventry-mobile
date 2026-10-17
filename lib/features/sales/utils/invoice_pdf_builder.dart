import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import '../data/models/sale_invoice.dart';
import '../../../core/constants/brand.dart';

final _currency = NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ', decimalDigits: 2);
final _date = DateFormat('dd MMM yyyy');

/// Builds a single-page A4 invoice PDF from [invoice] — the printable
/// counterpart to the Sale Details screen. Values are taken as-is from the
/// backend response (already tenant-scoped, tax-resolved, and rounded);
/// this file only lays them out, it never recomputes a total.
/// [logo] is the business logo from this phone's storage, if one is set.
Future<pw.Document> buildInvoicePdf(SaleInvoice invoice, {Uint8List? logo}) async {
  final doc = pw.Document();
  final showCgstSgst = invoice.taxType == 'CGST_SGST' || invoice.taxType == 'UTGST';
  final stateTaxLabel = invoice.taxType == 'UTGST' ? 'UTGST' : 'SGST';

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (logo != null) ...[
                  pw.Container(width: 64, height: 64, child: pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.contain)),
                  pw.SizedBox(width: 12),
                ],
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        invoice.business.name ?? 'Business',
                        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                      ),
                      if (invoice.business.addressLine != null)
                        pw.Text(invoice.business.addressLine!, style: const pw.TextStyle(fontSize: 10)),
                      if (invoice.business.contactLine != null)
                        pw.Text(invoice.business.contactLine!, style: const pw.TextStyle(fontSize: 10)),
                      if (invoice.business.gstin != null)
                        pw.Text('GSTIN: ${invoice.business.gstin}', style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('TAX INVOICE', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 4),
                    pw.Text('Invoice #: ${invoice.invoiceNumber}', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('Date: ${_date.format(invoice.invoiceDate)}', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400)),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Bill To', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                  pw.Text(invoice.customer.name ?? 'Customer', style: const pw.TextStyle(fontSize: 11)),
                  if (invoice.customer.addressLine != null)
                    pw.Text(invoice.customer.addressLine!, style: const pw.TextStyle(fontSize: 9)),
                  if (invoice.customer.gstin != null)
                    pw.Text('GSTIN: ${invoice.customer.gstin}', style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(1.2),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1.2),
                4: const pw.FlexColumnWidth(1.2),
                5: const pw.FlexColumnWidth(1.4),
                6: const pw.FlexColumnWidth(1.4),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _headerCell('Item'),
                    _headerCell('HSN'),
                    _headerCell('Qty'),
                    _headerCell('Rate'),
                    _headerCell('Discount'),
                    _headerCell('Taxable'),
                    _headerCell('Total'),
                  ],
                ),
                for (final item in invoice.items)
                  pw.TableRow(
                    children: [
                      _cell(item.productName ?? '-'),
                      _cell(item.hsnCode ?? '-'),
                      _cell('${item.quantity} ${item.unitSymbol ?? ''}'),
                      _cell(_currency.format(item.rate)),
                      _cell(_currency.format(item.discount)),
                      _cell(_currency.format(item.taxableValue)),
                      _cell(_currency.format(item.lineTotal)),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.SizedBox(
                width: 240,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    _totalRow('Subtotal', invoice.subTotal),
                    _totalRow('Discount', -invoice.discountAmount),
                    _totalRow('Taxable Amount', invoice.taxableAmount),
                    if (invoice.taxType == 'IGST')
                      _totalRow('IGST', invoice.igstAmount)
                    else if (showCgstSgst) ...[
                      _totalRow('CGST', invoice.cgstAmount),
                      _totalRow(stateTaxLabel, invoice.sgstAmount),
                    ],
                    _totalRow('Total Tax', invoice.totalTax),
                    pw.Divider(),
                    _totalRow('Grand Total', invoice.grandTotal, bold: true),
                  ],
                ),
              ),
            ),
            if (invoice.invoiceFooterNote != null && invoice.invoiceFooterNote!.isNotEmpty) ...[
              pw.SizedBox(height: 24),
              pw.Text(invoice.invoiceFooterNote!, style: const pw.TextStyle(fontSize: 9)),
            ],
            // Pinned to the bottom of the page on every invoice.
            pw.Spacer(),
            pw.Divider(color: PdfColors.grey400, thickness: 0.5),
            pw.Center(
              child: pw.Text(
                Brand.invoiceAttribution(),
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
              ),
            ),
          ],
        );
      },
    ),
  );

  return doc;
}

pw.Widget _headerCell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(text, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
  );
}

pw.Widget _cell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(text, style: const pw.TextStyle(fontSize: 9)),
  );
}

pw.Widget _totalRow(String label, double value, {bool bold = false}) {
  final style = pw.TextStyle(fontSize: bold ? 11 : 9, fontWeight: bold ? pw.FontWeight.bold : null);
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: style),
        pw.Text(_currency.format(value), style: style),
      ],
    ),
  );
}
