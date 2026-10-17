import 'package:freezed_annotation/freezed_annotation.dart';

part 'profit_summary.freezed.dart';

@freezed
abstract class ProfitSummary with _$ProfitSummary {
  const factory ProfitSummary({
    required double salesRevenue,
    required double costOfGoodsSold,
    required double grossProfit,
    required double grossMarginPercent,
    required double operatingExpenses,
    required double netProfit,
  }) = _ProfitSummary;

  factory ProfitSummary.fromJson(Map<String, dynamic> json) {
    return ProfitSummary(
      salesRevenue: (json['salesRevenue'] as num).toDouble(),
      costOfGoodsSold: (json['costOfGoodsSold'] as num).toDouble(),
      grossProfit: (json['grossProfit'] as num).toDouble(),
      grossMarginPercent: (json['grossMarginPercent'] as num).toDouble(),
      operatingExpenses: (json['operatingExpenses'] as num?)?.toDouble() ?? 0,
      netProfit: (json['netProfit'] as num?)?.toDouble() ?? (json['grossProfit'] as num).toDouble(),
    );
  }
}
