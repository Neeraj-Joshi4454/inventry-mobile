import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';
import 'unit.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String sku,
    required ProductCategory category,
    required ProductUnit unit,
    required double purchasePrice,
    required double sellingPrice,
    required double lowStockThreshold,
    required bool isActive,
    String? description,
    String? hsnCode,
    @Default(0) double taxRate,
    @Default(false) bool isPriceInclusive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson({
    'id': json['_id'] ?? json['id'],
    'name': json['name'],
    'sku': json['sku'],
    'category': json['categoryId'],
    'unit': json['unitId'],
    'purchasePrice': json['purchasePrice'],
    'sellingPrice': json['sellingPrice'],
    'lowStockThreshold': json['lowStockThreshold'],
    'isActive': json['isActive'] ?? true,
    'description': json['description'],
    'hsnCode': json['hsnCode'],
    'taxRate': json['taxRate'] ?? 0,
    'isPriceInclusive': json['isPriceInclusive'] ?? false,
  });
}
