import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_invoice.freezed.dart';

@freezed
abstract class PurchaseInvoiceParty with _$PurchaseInvoiceParty {
  const factory PurchaseInvoiceParty({String? name, String? addressLine, String? gstin, String? phone, String? email}) =
      _PurchaseInvoiceParty;

  const PurchaseInvoiceParty._();

  /// "Ph: 98… · email" — null when neither is set.
  String? get contactLine {
    final parts = [if (phone?.isNotEmpty ?? false) 'Ph: $phone', if (email?.isNotEmpty ?? false) email!];
    return parts.isEmpty ? null : parts.join('  ·  ');
  }

  factory PurchaseInvoiceParty.fromJson(Map<String, dynamic> json) {
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
    return PurchaseInvoiceParty(
      name: json['name'] as String?,
      addressLine: addressLine,
      gstin: json['gstin'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }
}

@freezed
abstract class PurchaseInvoiceLineItem with _$PurchaseInvoiceLineItem {
  const factory PurchaseInvoiceLineItem({
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
  }) = _PurchaseInvoiceLineItem;

  factory PurchaseInvoiceLineItem.fromJson(Map<String, dynamic> json) {
    return PurchaseInvoiceLineItem(
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
abstract class PurchaseInvoice with _$PurchaseInvoice {
  const factory PurchaseInvoice({
    required PurchaseInvoiceParty business,
    required PurchaseInvoiceParty supplier,
    required String invoiceNumber,
    String? supplierInvoiceNumber,
    required DateTime invoiceDate,
    required String taxType,
    required List<PurchaseInvoiceLineItem> items,
    required double subTotal,
    required double discountAmount,
    required double taxableAmount,
    required double cgstAmount,
    required double sgstAmount,
    required double igstAmount,
    required double totalTax,
    required double grandTotal,
    String? invoiceFooterNote,
  }) = _PurchaseInvoice;

  factory PurchaseInvoice.fromJson(Map<String, dynamic> json) {
    final business = json['business'] as Map<String, dynamic>? ?? {};
    return PurchaseInvoice(
      business: PurchaseInvoiceParty.fromJson(business),
      supplier: PurchaseInvoiceParty.fromJson(json['supplier'] as Map<String, dynamic>? ?? {}),
      invoiceNumber: json['invoiceNumber'] as String,
      supplierInvoiceNumber: json['supplierInvoiceNumber'] as String?,
      invoiceDate: DateTime.parse(json['invoiceDate'] as String),
      taxType: json['taxType'] as String? ?? 'NO_TAX',
      items: (json['items'] as List<dynamic>)
          .map((e) => PurchaseInvoiceLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
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
