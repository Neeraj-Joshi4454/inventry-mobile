import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';

@freezed
abstract class Purchase with _$Purchase {
  const factory Purchase({
    required String id,
    required String purchaseNumber,
    String? invoiceNumber,
    String? supplierId,
    required String supplierName,
    required DateTime purchaseDate,
    required double subTotal,
    @Default(0) double discountAmount,
    @Default(0) double taxableAmount,
    @Default(0) double cgstAmount,
    @Default(0) double sgstAmount,
    @Default(0) double igstAmount,
    required double taxAmount,
    @Default('NO_TAX') String taxType,
    required double totalAmount,
    @Default(0) double paidAmount,
    @Default(0) double dueAmount,
    required String paymentStatus,
    String? paymentMethod,
    String? paymentReference,
    String? notes,
    String? createdByName,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) {
    final supplier = json['supplierId'];
    final createdBy = json['createdBy'];
    return Purchase(
      id: (json['_id'] ?? json['id']).toString(),
      purchaseNumber: json['purchaseNumber'] as String,
      invoiceNumber: json['invoiceNumber'] as String?,
      supplierId: supplier is Map ? (supplier['_id'] ?? supplier['id']).toString() : supplier?.toString(),
      supplierName: supplier is Map ? supplier['name'] as String : 'Unknown supplier',
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      subTotal: (json['subTotal'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      taxableAmount: (json['taxableAmount'] as num?)?.toDouble() ?? 0,
      cgstAmount: (json['cgstAmount'] as num?)?.toDouble() ?? 0,
      sgstAmount: (json['sgstAmount'] as num?)?.toDouble() ?? 0,
      igstAmount: (json['igstAmount'] as num?)?.toDouble() ?? 0,
      taxAmount: (json['taxAmount'] as num).toDouble(),
      taxType: json['taxType'] as String? ?? 'NO_TAX',
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
      dueAmount: (json['dueAmount'] as num?)?.toDouble() ?? 0,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      paymentReference: json['paymentReference'] as String?,
      notes: json['notes'] as String?,
      createdByName: createdBy is Map ? createdBy['name'] as String? : null,
    );
  }
}
