import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';

@freezed
abstract class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String title,
    required String categoryId,
    required String categoryName,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    String? attachmentUrl,
    required String status,
    String? createdByName,
    String? updatedByName,
    DateTime? createdAt,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) {
    final category = json['categoryId'];
    final createdBy = json['createdBy'];
    final updatedBy = json['updatedBy'];
    return Expense(
      id: (json['_id'] ?? json['id']).toString(),
      title: json['title'] as String,
      categoryId: category is Map ? (category['_id'] ?? category['id']).toString() : category.toString(),
      categoryName: category is Map ? category['name'] as String? ?? 'Unknown' : 'Unknown',
      amount: (json['amount'] as num).toDouble(),
      expenseDate: DateTime.parse(json['expenseDate'] as String),
      paymentMethod: json['paymentMethod'] as String,
      referenceNumber: json['referenceNumber'] as String?,
      notes: json['notes'] as String?,
      attachmentUrl: json['attachmentUrl'] as String?,
      status: json['status'] as String? ?? 'ACTIVE',
      createdByName: createdBy is Map ? createdBy['name'] as String? : null,
      updatedByName: updatedBy is Map ? updatedBy['name'] as String? : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
    );
  }
}
