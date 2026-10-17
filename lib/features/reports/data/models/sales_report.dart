import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_report.freezed.dart';

@freezed
abstract class SalesReportSummary with _$SalesReportSummary {
  const factory SalesReportSummary({
    required int totalSales,
    required double totalQuantitySold,
    required double totalDiscount,
    required double totalTax,
    required double netSales,
  }) = _SalesReportSummary;

  factory SalesReportSummary.fromJson(Map<String, dynamic> json) {
    return SalesReportSummary(
      totalSales: (json['totalSales'] as num).toInt(),
      totalQuantitySold: (json['totalQuantitySold'] as num).toDouble(),
      totalDiscount: (json['totalDiscount'] as num).toDouble(),
      totalTax: (json['totalTax'] as num).toDouble(),
      netSales: (json['netSales'] as num).toDouble(),
    );
  }
}

@freezed
abstract class SalesReportRow with _$SalesReportRow {
  const factory SalesReportRow({
    required String id,
    required String saleNumber,
    required DateTime saleDate,
    required double totalAmount,
    required String paymentStatus,
    required String customerName,
    String? createdByName,
  }) = _SalesReportRow;

  factory SalesReportRow.fromJson(Map<String, dynamic> json) {
    return SalesReportRow(
      id: (json['_id'] ?? json['id']).toString(),
      saleNumber: json['saleNumber'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      customerName: (json['customer'] as Map<String, dynamic>?)?['name'] as String? ?? 'Unknown',
      createdByName: (json['createdBy'] as Map<String, dynamic>?)?['name'] as String?,
    );
  }
}
