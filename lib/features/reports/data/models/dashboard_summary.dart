import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_summary.freezed.dart';

@freezed
abstract class ActivityCount with _$ActivityCount {
  const factory ActivityCount({required int count, required double amount}) = _ActivityCount;

  factory ActivityCount.fromJson(Map<String, dynamic> json) {
    return ActivityCount(count: (json['count'] as num).toInt(), amount: (json['amount'] as num).toDouble());
  }
}

@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int totalProducts,
    required double totalStockQuantity,
    required double totalStockValue,
    required int lowStockProducts,
    required int outOfStockProducts,
    required ActivityCount todaysSales,
    required ActivityCount todaysPurchases,
    required ActivityCount todaysExpenses,
    required ActivityCount thisMonthExpenses,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalProducts: (json['totalProducts'] as num).toInt(),
      totalStockQuantity: (json['totalStockQuantity'] as num).toDouble(),
      totalStockValue: (json['totalStockValue'] as num).toDouble(),
      lowStockProducts: (json['lowStockProducts'] as num).toInt(),
      outOfStockProducts: (json['outOfStockProducts'] as num).toInt(),
      todaysSales: ActivityCount.fromJson(json['todaysSales'] as Map<String, dynamic>),
      todaysPurchases: ActivityCount.fromJson(json['todaysPurchases'] as Map<String, dynamic>),
      todaysExpenses: json['todaysExpenses'] != null
          ? ActivityCount.fromJson(json['todaysExpenses'] as Map<String, dynamic>)
          : const ActivityCount(count: 0, amount: 0),
      thisMonthExpenses: json['thisMonthExpenses'] != null
          ? ActivityCount.fromJson(json['thisMonthExpenses'] as Map<String, dynamic>)
          : const ActivityCount(count: 0, amount: 0),
    );
  }
}
