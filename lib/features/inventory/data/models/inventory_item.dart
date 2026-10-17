import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../products/data/models/category.dart';
import '../../../products/data/models/unit.dart';
import 'stock_status.dart';

part 'inventory_item.freezed.dart';

/// One row of the Inventory list / a single product's stock snapshot.
/// Reuses [ProductCategory]/[ProductUnit] from the products feature rather
/// than redefining them — same data, same normalization needs (the backend
/// returns them shaped slightly differently depending on whether the
/// response came from an aggregation `$project` or a Mongoose `populate()`,
/// which those models' `fromJson` already account for).
@freezed
abstract class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required String productId,
    required String name,
    required String sku,
    required ProductCategory category,
    required ProductUnit unit,
    required double currentStock,
    required double lowStockThreshold,
    required StockStatus status,
    @Default(0) double taxRate,
    @Default(false) bool isPriceInclusive,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      productId: (json['productId'] ?? json['_id']).toString(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      category: ProductCategory.fromJson(json['category'] as Map<String, dynamic>),
      unit: ProductUnit.fromJson(json['unit'] as Map<String, dynamic>),
      currentStock: (json['currentStock'] as num).toDouble(),
      lowStockThreshold: (json['lowStockThreshold'] as num).toDouble(),
      status: StockStatus.fromWire(json['status'] as String),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      isPriceInclusive: json['isPriceInclusive'] as bool? ?? false,
    );
  }
}
