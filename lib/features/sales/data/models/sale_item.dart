import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_item.freezed.dart';

@freezed
abstract class SaleItem with _$SaleItem {
  const factory SaleItem({
    required String id,
    required String productId,
    required String productName,
    required String productSku,
    required String unitSymbol,
    required double quantity,
    required double unitPrice,
    required double taxRate,
    required double lineTotal,
  }) = _SaleItem;

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    final product = json['productId'];
    final unit = product is Map ? product['unitId'] : null;
    final quantity = (json['quantity'] as num).toDouble();
    return SaleItem(
      id: (json['_id'] ?? json['id']).toString(),
      productId: (product is Map ? product['_id'] : product).toString(),
      productName: product is Map ? product['name'] as String : 'Unknown product',
      productSku: product is Map ? (product['sku'] as String? ?? '') : '',
      unitSymbol: unit is Map ? (unit['symbol'] as String? ?? '') : '',
      quantity: quantity,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }
}

/// A line item still being edited on the Create Sale form — distinct from
/// [SaleItem] (a committed line from the backend) so the draft can hold a
/// product picked from inventory, its available stock for the inline
/// insufficient-stock UX check, without pretending it's already a saved
/// sale line.
class SaleLineDraft {
  SaleLineDraft({
    required this.productId,
    required this.productName,
    required this.unitSymbol,
    required this.availableStock,
    this.quantity,
    this.unitPrice,
    this.taxRate = 0,
  });

  final String productId;
  final String productName;
  final String unitSymbol;
  final double availableStock;
  double? quantity;
  double? unitPrice;
  double taxRate;

  double get lineSubTotal => (quantity ?? 0) * (unitPrice ?? 0);
  double get lineTax => lineSubTotal * (taxRate / 100);
  double get lineTotal => lineSubTotal + lineTax;

  /// UX-only check — the backend performs the authoritative stock
  /// validation atomically at submit time; this only prevents an obviously
  /// doomed request from being sent.
  bool get exceedsAvailableStock => (quantity ?? 0) > availableStock;

  bool get isValid => (quantity ?? 0) > 0 && (unitPrice ?? -1) >= 0 && !exceedsAvailableStock;
}
