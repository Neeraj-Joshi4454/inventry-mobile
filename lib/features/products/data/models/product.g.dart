// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  sku: json['sku'] as String,
  category: ProductCategory.fromJson(json['category'] as Map<String, dynamic>),
  unit: ProductUnit.fromJson(json['unit'] as Map<String, dynamic>),
  purchasePrice: (json['purchasePrice'] as num).toDouble(),
  sellingPrice: (json['sellingPrice'] as num).toDouble(),
  lowStockThreshold: (json['lowStockThreshold'] as num).toDouble(),
  isActive: json['isActive'] as bool,
  description: json['description'] as String?,
  hsnCode: json['hsnCode'] as String?,
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
  isPriceInclusive: json['isPriceInclusive'] as bool? ?? false,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sku': instance.sku,
  'category': instance.category,
  'unit': instance.unit,
  'purchasePrice': instance.purchasePrice,
  'sellingPrice': instance.sellingPrice,
  'lowStockThreshold': instance.lowStockThreshold,
  'isActive': instance.isActive,
  'description': instance.description,
  'hsnCode': instance.hsnCode,
  'taxRate': instance.taxRate,
  'isPriceInclusive': instance.isPriceInclusive,
};
