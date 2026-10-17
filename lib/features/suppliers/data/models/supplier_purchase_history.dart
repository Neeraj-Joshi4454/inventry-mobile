import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_purchase_history.freezed.dart';

@freezed
abstract class SupplierPurchaseSummary with _$SupplierPurchaseSummary {
  const factory SupplierPurchaseSummary({
    required int totalPurchases,
    required double totalAmount,
    required double totalQuantityPurchased,
    required double outstandingAmount,
  }) = _SupplierPurchaseSummary;

  factory SupplierPurchaseSummary.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseSummary(
      totalPurchases: (json['totalPurchases'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      totalQuantityPurchased: (json['totalQuantityPurchased'] as num).toDouble(),
      outstandingAmount: (json['outstandingAmount'] as num).toDouble(),
    );
  }
}
