import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../inventory/data/models/stock_status.dart';

part 'stock_report.freezed.dart';

@freezed
abstract class StockReportSummary with _$StockReportSummary {
  const factory StockReportSummary({
    required int totalProducts,
    required double totalStockQuantity,
    required double totalStockValue,
  }) = _StockReportSummary;

  factory StockReportSummary.fromJson(Map<String, dynamic> json) {
    return StockReportSummary(
      totalProducts: (json['totalProducts'] as num).toInt(),
      totalStockQuantity: (json['totalStockQuantity'] as num).toDouble(),
      totalStockValue: (json['totalStockValue'] as num).toDouble(),
    );
  }
}

@freezed
abstract class StockReportRow with _$StockReportRow {
  const factory StockReportRow({
    required String productId,
    required String name,
    required String sku,
    required String categoryName,
    required double currentStock,
    required double lowStockThreshold,
    required double purchasePrice,
    required double sellingPrice,
    required double stockValue,
    required StockStatus status,
  }) = _StockReportRow;

  factory StockReportRow.fromJson(Map<String, dynamic> json) {
    return StockReportRow(
      productId: json['productId'].toString(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      categoryName: (json['category'] as Map<String, dynamic>?)?['name'] as String? ?? '—',
      currentStock: (json['currentStock'] as num).toDouble(),
      lowStockThreshold: (json['lowStockThreshold'] as num).toDouble(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      stockValue: (json['stockValue'] as num).toDouble(),
      status: StockStatus.fromWire(json['stockStatus'] as String),
    );
  }
}
