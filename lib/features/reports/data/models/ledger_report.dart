import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../inventory/data/models/inventory_transaction.dart';

part 'ledger_report.freezed.dart';

@freezed
abstract class LedgerReportSummary with _$LedgerReportSummary {
  const factory LedgerReportSummary({required double totalIn, required double totalOut}) = _LedgerReportSummary;

  factory LedgerReportSummary.fromJson(Map<String, dynamic> json) {
    return LedgerReportSummary(
      totalIn: (json['totalIn'] as num).toDouble(),
      totalOut: (json['totalOut'] as num).toDouble(),
    );
  }
}

@freezed
abstract class LedgerReportRow with _$LedgerReportRow {
  const factory LedgerReportRow({
    required String id,
    required InventoryTransactionType type,
    required String productName,
    required String productSku,
    required double inQuantity,
    required double outQuantity,
    required double previousStock,
    required double resultingStock,
    String? referenceNumber,
    String? createdByName,
    String? reason,
    required DateTime createdAt,
  }) = _LedgerReportRow;

  factory LedgerReportRow.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>;
    final reference = json['reference'] as Map<String, dynamic>?;
    final createdBy = json['createdBy'] as Map<String, dynamic>?;
    return LedgerReportRow(
      id: json['id'].toString(),
      type: InventoryTransactionType.fromWire(json['type'] as String),
      productName: product['name'] as String,
      productSku: product['sku'] as String,
      inQuantity: (json['inQuantity'] as num).toDouble(),
      outQuantity: (json['outQuantity'] as num).toDouble(),
      previousStock: (json['previousStock'] as num).toDouble(),
      resultingStock: (json['resultingStock'] as num).toDouble(),
      referenceNumber: reference?['number'] as String?,
      createdByName: createdBy?['name'] as String?,
      reason: json['reason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
