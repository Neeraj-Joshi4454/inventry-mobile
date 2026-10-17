import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_report.freezed.dart';

@freezed
abstract class ExpenseReportSummary with _$ExpenseReportSummary {
  const factory ExpenseReportSummary({required int totalExpenses, required double totalAmount}) = _ExpenseReportSummary;

  factory ExpenseReportSummary.fromJson(Map<String, dynamic> json) {
    return ExpenseReportSummary(
      totalExpenses: (json['totalExpenses'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }
}

@freezed
abstract class ExpenseCategoryBreakdown with _$ExpenseCategoryBreakdown {
  const factory ExpenseCategoryBreakdown({
    required String categoryId,
    required String categoryName,
    required double amount,
    required int count,
  }) = _ExpenseCategoryBreakdown;

  factory ExpenseCategoryBreakdown.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryBreakdown(
      categoryId: json['categoryId'].toString(),
      categoryName: json['categoryName'] as String,
      amount: (json['amount'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );
  }
}

@freezed
abstract class ExpenseReportRow with _$ExpenseReportRow {
  const factory ExpenseReportRow({
    required String id,
    required String title,
    required String categoryName,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? createdByName,
  }) = _ExpenseReportRow;

  factory ExpenseReportRow.fromJson(Map<String, dynamic> json) {
    final category = json['categoryId'];
    final createdBy = json['createdBy'];
    return ExpenseReportRow(
      id: (json['_id'] ?? json['id']).toString(),
      title: json['title'] as String,
      categoryName: category is Map ? category['name'] as String? ?? 'Unknown' : 'Unknown',
      amount: (json['amount'] as num).toDouble(),
      expenseDate: DateTime.parse(json['expenseDate'] as String),
      paymentMethod: json['paymentMethod'] as String,
      createdByName: createdBy is Map ? createdBy['name'] as String? : null,
    );
  }
}
