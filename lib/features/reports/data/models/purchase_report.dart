import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_report.freezed.dart';

@freezed
abstract class PurchaseReportSummary with _$PurchaseReportSummary {
  const factory PurchaseReportSummary({
    required int totalPurchases,
    required double totalQuantityPurchased,
    required double totalDiscount,
    required double totalTax,
    required double netPurchaseAmount,
  }) = _PurchaseReportSummary;

  factory PurchaseReportSummary.fromJson(Map<String, dynamic> json) {
    return PurchaseReportSummary(
      totalPurchases: (json['totalPurchases'] as num).toInt(),
      totalQuantityPurchased: (json['totalQuantityPurchased'] as num).toDouble(),
      totalDiscount: (json['totalDiscount'] as num).toDouble(),
      totalTax: (json['totalTax'] as num).toDouble(),
      netPurchaseAmount: (json['netPurchaseAmount'] as num).toDouble(),
    );
  }
}

@freezed
abstract class PurchaseReportRow with _$PurchaseReportRow {
  const factory PurchaseReportRow({
    required String id,
    required String purchaseNumber,
    required DateTime purchaseDate,
    required double totalAmount,
    required String paymentStatus,
    required String supplierName,
    String? createdByName,
  }) = _PurchaseReportRow;

  factory PurchaseReportRow.fromJson(Map<String, dynamic> json) {
    return PurchaseReportRow(
      id: (json['_id'] ?? json['id']).toString(),
      purchaseNumber: json['purchaseNumber'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      supplierName: (json['supplier'] as Map<String, dynamic>?)?['name'] as String? ?? 'Unknown',
      createdByName: (json['createdBy'] as Map<String, dynamic>?)?['name'] as String?,
    );
  }
}
