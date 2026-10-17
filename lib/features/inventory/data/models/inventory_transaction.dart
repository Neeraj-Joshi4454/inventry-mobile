import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_transaction.freezed.dart';

enum InventoryTransactionType {
  // Legacy: Opening Stock was removed; kept so older ledger rows still render.
  openingStock('OPENING_STOCK', 'Opening Stock'),
  purchase('PURCHASE', 'Purchase'),
  sale('SALE', 'Sale'),
  // Legacy: returns were removed; kept so older ledger rows still render.
  saleReturn('SALE_RETURN', 'Sale Return'),
  purchaseReturn('PURCHASE_RETURN', 'Purchase Return'),
  stockAdjustmentIn('STOCK_ADJUSTMENT_IN', 'Adjustment In'),
  stockAdjustmentOut('STOCK_ADJUSTMENT_OUT', 'Adjustment Out');

  const InventoryTransactionType(this.wireValue, this.label);

  final String wireValue;
  final String label;

  /// Types offered in ledger filters — excludes legacy ones no longer created.
  static List<InventoryTransactionType> get filterable => values
      .where(
        (t) =>
            t != InventoryTransactionType.openingStock &&
            t != InventoryTransactionType.saleReturn &&
            t != InventoryTransactionType.purchaseReturn,
      )
      .toList();

  static InventoryTransactionType fromWire(String value) {
    return InventoryTransactionType.values.firstWhere(
      (t) => t.wireValue == value,
      orElse: () => InventoryTransactionType.stockAdjustmentIn,
    );
  }

  /// Matches STOCK_INCREASING_TYPES in the backend
  /// (backend/src/types/enums.ts) — the single source of truth for stock
  /// direction is that file; this must stay in sync with it by hand since
  /// there's no shared-package mechanism between the Node backend and this
  /// Flutter app.
  bool get isIncrease => switch (this) {
    InventoryTransactionType.openingStock => true,
    InventoryTransactionType.purchase => true,
    InventoryTransactionType.saleReturn => true,
    InventoryTransactionType.stockAdjustmentIn => true,
    InventoryTransactionType.sale => false,
    InventoryTransactionType.purchaseReturn => false,
    InventoryTransactionType.stockAdjustmentOut => false,
  };
}

@freezed
abstract class InventoryLedgerEntry with _$InventoryLedgerEntry {
  const factory InventoryLedgerEntry({
    required String id,
    required InventoryTransactionType type,
    required double quantity,
    required double previousStock,
    required double resultingStock,
    required String referenceType,
    required String referenceId,
    required DateTime createdAt,
    String? notes,
    String? reason,
  }) = _InventoryLedgerEntry;

  factory InventoryLedgerEntry.fromJson(Map<String, dynamic> json) {
    return InventoryLedgerEntry(
      id: (json['_id'] ?? json['id']).toString(),
      type: InventoryTransactionType.fromWire(json['type'] as String),
      quantity: (json['quantity'] as num).toDouble(),
      previousStock: (json['previousStock'] as num).toDouble(),
      resultingStock: (json['resultingStock'] as num).toDouble(),
      referenceType: json['referenceType'] as String,
      referenceId: json['referenceId'].toString(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      notes: json['notes'] as String?,
      reason: json['reason'] as String?,
    );
  }
}
