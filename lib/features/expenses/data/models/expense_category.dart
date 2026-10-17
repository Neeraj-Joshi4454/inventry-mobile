import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_category.freezed.dart';

@freezed
abstract class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    required String id,
    required String name,
    String? description,
    required bool isSystem,
    required bool isActive,
  }) = _ExpenseCategory;

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      id: (json['_id'] ?? json['id']).toString(),
      name: json['name'] as String,
      description: json['description'] as String?,
      isSystem: json['isSystem'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
