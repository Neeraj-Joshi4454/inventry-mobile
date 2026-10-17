import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_invoice.freezed.dart';

@freezed
abstract class InvoiceParty with _$InvoiceParty {
  const factory InvoiceParty({String? name, String? addressLine, String? gstin, String? phone, String? email}) =
      _InvoiceParty;

  const InvoiceParty._();

  /// "Ph: 98… · email" — null when neither is set.
  String? get contactLine {
    final parts = [if (phone?.isNotEmpty ?? false) 'Ph: $phone', if (email?.isNotEmpty ?? false) email!];
    return parts.isEmpty ? null : parts.join('  ·  ');
  }

  factory InvoiceParty.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    String? addressLine;
    if (address is Map) {
      final parts = [
        address['line1'],
        address['line2'],
        address['city'],
        address['state'],
        address['pincode'],
      ].whereType<String>().where((p) => p.isNotEmpty).toList();
      addressLine = parts.isEmpty ? null : parts.join(', ');
    }
    return InvoiceParty(
      name: json['name'] as String?,
      addressLine: addressLine,
      gstin: json['gstin'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }
}

@freezed
abstract class InvoiceLineItem with _$InvoiceLineItem {
  const factory InvoiceLineItem({
    String? productName,
    String? hsnCode,
    required double quantity,
    String? unitSymbol,
    required double rate,
    required double discount,
    required double taxableValue,
    required double taxRate,
    required double cgst,
    required double sgst,
    required double igst,
    required double lineTotal,
  }) = _InvoiceLineItem;

  factory InvoiceLineItem.fromJson(Map<String, dynamic> json) {
    return InvoiceLineItem(
      productName: json['productName'] as String?,
      hsnCode: json['hsnCode'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unitSymbol: json['unitSymbol'] as String?,
      rate: (json['rate'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      taxableValue: (json['taxableValue'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      cgst: (json['cgst'] as num).toDouble(),
      sgst: (json['sgst'] as num).toDouble(),
      igst: (json['igst'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }
}

@freezed
abstract class SaleInvoice with _$SaleInvoice {
  const factory SaleInvoice({
    required InvoiceParty business,
    required InvoiceParty customer,
    required String invoiceNumber,
    required DateTime invoiceDate,
    required String taxType,
    required List<InvoiceLineItem> items,
    required double subTotal,
    required double discountAmount,
    required double taxableAmount,
    required double cgstAmount,
    required double sgstAmount,
    required double igstAmount,
    required double totalTax,
    required double grandTotal,
    String? invoiceFooterNote,
  }) = _SaleInvoice;

  factory SaleInvoice.fromJson(Map<String, dynamic> json) {
    final business = json['business'] as Map<String, dynamic>? ?? {};
    return SaleInvoice(
      business: InvoiceParty.fromJson(business),
      customer: InvoiceParty.fromJson(json['customer'] as Map<String, dynamic>? ?? {}),
      invoiceNumber: json['invoiceNumber'] as String,
      invoiceDate: DateTime.parse(json['invoiceDate'] as String),
      taxType: json['taxType'] as String? ?? 'NO_TAX',
      items: (json['items'] as List<dynamic>).map((e) => InvoiceLineItem.fromJson(e as Map<String, dynamic>)).toList(),
      subTotal: (json['subTotal'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      taxableAmount: (json['taxableAmount'] as num).toDouble(),
      cgstAmount: (json['cgstAmount'] as num).toDouble(),
      sgstAmount: (json['sgstAmount'] as num).toDouble(),
      igstAmount: (json['igstAmount'] as num).toDouble(),
      totalTax: (json['totalTax'] as num).toDouble(),
      grandTotal: (json['grandTotal'] as num).toDouble(),
      invoiceFooterNote: business['invoiceFooterNote'] as String?,
    );
  }
}
