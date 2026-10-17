import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';

@freezed
abstract class Sale with _$Sale {
  const factory Sale({
    required String id,
    required String saleNumber,
    String? customerId,
    required String customerName,
    required DateTime saleDate,
    required double subTotal,
    required double discountAmount,
    @Default(0) double taxableAmount,
    @Default(0) double cgstAmount,
    @Default(0) double sgstAmount,
    @Default(0) double igstAmount,
    required double taxAmount,
    @Default('NO_TAX') String taxType,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    required String paymentStatus,
    String? paymentMethod,
    String? createdByName,
    String? notes,
    DateTime? createdAt,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) {
    final customer = json['customerId'];
    final createdBy = json['createdBy'];
    return Sale(
      id: (json['_id'] ?? json['id']).toString(),
      saleNumber: json['saleNumber'] as String,
      customerId: customer is Map ? (customer['_id'] ?? customer['id'])?.toString() : null,
      customerName: customer is Map ? customer['name'] as String : 'Unknown customer',
      saleDate: DateTime.parse(json['saleDate'] as String),
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
      createdByName: createdBy is Map ? createdBy['name'] as String? : null,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
    );
  }
}
