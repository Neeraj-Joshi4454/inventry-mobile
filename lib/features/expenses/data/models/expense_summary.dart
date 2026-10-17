import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_summary.freezed.dart';

@freezed
abstract class ExpenseActivityCount with _$ExpenseActivityCount {
  const factory ExpenseActivityCount({required int count, required double amount}) = _ExpenseActivityCount;

  factory ExpenseActivityCount.fromJson(Map<String, dynamic> json) {
    return ExpenseActivityCount(count: (json['count'] as num).toInt(), amount: (json['amount'] as num).toDouble());
  }
}

@freezed
abstract class PreviousMonthComparison with _$PreviousMonthComparison {
  const factory PreviousMonthComparison({
    required double previousMonthAmount,
    required double currentMonthAmount,
    required double change,
    required double changePercent,
  }) = _PreviousMonthComparison;

  factory PreviousMonthComparison.fromJson(Map<String, dynamic> json) {
    return PreviousMonthComparison(
      previousMonthAmount: (json['previousMonthAmount'] as num).toDouble(),
      currentMonthAmount: (json['currentMonthAmount'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
    );
  }
}

@freezed
abstract class ExpenseCategorySummaryRow with _$ExpenseCategorySummaryRow {
  const factory ExpenseCategorySummaryRow({
    required String categoryId,
    required String categoryName,
    required double amount,
    required int count,
  }) = _ExpenseCategorySummaryRow;

  factory ExpenseCategorySummaryRow.fromJson(Map<String, dynamic> json) {
    return ExpenseCategorySummaryRow(
      categoryId: json['categoryId'].toString(),
      categoryName: json['categoryName'] as String,
      amount: (json['amount'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );
  }
}

@freezed
abstract class ExpenseMethodSummaryRow with _$ExpenseMethodSummaryRow {
  const factory ExpenseMethodSummaryRow({required String paymentMethod, required double amount, required int count}) =
      _ExpenseMethodSummaryRow;

  factory ExpenseMethodSummaryRow.fromJson(Map<String, dynamic> json) {
    return ExpenseMethodSummaryRow(
      paymentMethod: json['paymentMethod'] as String,
      amount: (json['amount'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );
  }
}

@freezed
abstract class ExpenseSummary with _$ExpenseSummary {
  const factory ExpenseSummary({
    required ExpenseActivityCount todayExpenses,
    required ExpenseActivityCount thisMonthExpenses,
    required ExpenseActivityCount totalExpenses,
    required PreviousMonthComparison previousMonthComparison,
    required List<ExpenseCategorySummaryRow> expensesByCategory,
    required List<ExpenseMethodSummaryRow> expensesByPaymentMethod,
  }) = _ExpenseSummary;

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) {
    return ExpenseSummary(
      todayExpenses: ExpenseActivityCount.fromJson(json['todayExpenses'] as Map<String, dynamic>),
      thisMonthExpenses: ExpenseActivityCount.fromJson(json['thisMonthExpenses'] as Map<String, dynamic>),
      totalExpenses: ExpenseActivityCount.fromJson(json['totalExpenses'] as Map<String, dynamic>),
      previousMonthComparison: PreviousMonthComparison.fromJson(
        json['previousMonthComparison'] as Map<String, dynamic>,
      ),
      expensesByCategory: (json['expensesByCategory'] as List<dynamic>)
          .map((e) => ExpenseCategorySummaryRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      expensesByPaymentMethod: (json['expensesByPaymentMethod'] as List<dynamic>)
          .map((e) => ExpenseMethodSummaryRow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
