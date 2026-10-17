import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class ProductCategory with _$ProductCategory {
  const factory ProductCategory({required String id, required String name}) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(
    // Category read endpoints return Mongo's `_id`; nested product.categoryId
    // populate() also returns `_id` — normalize both to `id` here so every
    // call site uses one field name regardless of which endpoint it came from.
    {'id': json['_id'] ?? json['id'], 'name': json['name']},
  );
}
