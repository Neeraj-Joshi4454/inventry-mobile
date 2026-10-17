import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_sales_summary.freezed.dart';

@freezed
abstract class CustomerSalesSummary with _$CustomerSalesSummary {
  const factory CustomerSalesSummary({
    required int totalSales,
    required double totalAmount,
    required double totalPaid,
    required double totalOutstanding,
    DateTime? lastSaleDate,
    DateTime? lastPaymentDate,
    required int unpaidOrPartialCount,
  }) = _CustomerSalesSummary;

  factory CustomerSalesSummary.fromJson(Map<String, dynamic> json) {
    return CustomerSalesSummary(
      totalSales: (json['totalSales'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      totalPaid: (json['totalPaid'] as num).toDouble(),
      totalOutstanding: (json['totalOutstanding'] as num).toDouble(),
      lastSaleDate: json['lastSaleDate'] != null ? DateTime.parse(json['lastSaleDate'] as String) : null,
      lastPaymentDate: json['lastPaymentDate'] != null ? DateTime.parse(json['lastPaymentDate'] as String) : null,
      unpaidOrPartialCount: (json['unpaidOrPartialCount'] as num).toInt(),
    );
  }
}
