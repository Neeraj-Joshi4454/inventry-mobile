import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_item.freezed.dart';

@freezed
abstract class PurchaseItem with _$PurchaseItem {
  const factory PurchaseItem({
    required String id,
    required String productId,
    required String productName,
    required String productSku,
    required String unitSymbol,
    required double quantity,
    required double unitPrice,
    required double taxRate,
    required double lineTotal,
    double? previousStock,
    double? resultingStock,
  }) = _PurchaseItem;

  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    final product = json['productId'];
    final unit = product is Map ? product['unitId'] : null;
    final quantity = (json['quantity'] as num).toDouble();
    final inventoryImpact = json['inventoryImpact'] as Map<String, dynamic>?;
    return PurchaseItem(
      id: (json['_id'] ?? json['id']).toString(),
      productId: (product is Map ? product['_id'] : product).toString(),
      productName: product is Map ? product['name'] as String : 'Unknown product',
      productSku: product is Map ? (product['sku'] as String? ?? '') : '',
      unitSymbol: unit is Map ? (unit['symbol'] as String? ?? '') : '',
      quantity: quantity,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      lineTotal: (json['lineTotal'] as num).toDouble(),
      previousStock: (inventoryImpact?['previousStock'] as num?)?.toDouble(),
      resultingStock: (inventoryImpact?['resultingStock'] as num?)?.toDouble(),
    );
  }
}

/// A line item still being edited on the Create Purchase form — distinct
/// from [PurchaseItem] (which represents a committed line from the
/// backend) so the draft can hold a product picked from the inventory list
/// without pretending it's already a saved purchase line.
class PurchaseLineDraft {
  PurchaseLineDraft({
    required this.productId,
    required this.productName,
    required this.unitSymbol,
    required this.currentStock,
    this.quantity,
    this.unitPrice,
    this.taxRate = 0,
  });

  final String productId;
  final String productName;
  final String unitSymbol;
  final double currentStock;
  double? quantity;
  double? unitPrice;
  double taxRate;

  double get lineSubTotal => (quantity ?? 0) * (unitPrice ?? 0);
  double get lineTax => lineSubTotal * (taxRate / 100);
  double get lineTotal => lineSubTotal + lineTax;

  bool get isValid => (quantity ?? 0) > 0 && (unitPrice ?? -1) >= 0;
}
