import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/status_badge.dart';

/// Mirrors the backend's computed status exactly
/// (backend/src/modules/inventory/inventory.query.service.ts::computeStatus).
enum StockStatus {
  inStock('IN_STOCK'),
  lowStock('LOW_STOCK'),
  outOfStock('OUT_OF_STOCK');

  const StockStatus(this.wireValue);

  final String wireValue;

  static StockStatus fromWire(String value) {
    return StockStatus.values.firstWhere((s) => s.wireValue == value, orElse: () => StockStatus.outOfStock);
  }

  String get label => switch (this) {
    StockStatus.inStock => 'In Stock',
    StockStatus.lowStock => 'Low Stock',
    StockStatus.outOfStock => 'Out of Stock',
  };

  Color get color => switch (this) {
    StockStatus.inStock => AppColors.success,
    StockStatus.lowStock => AppColors.warning,
    StockStatus.outOfStock => AppColors.error,
  };

  StatusTone get tone => switch (this) {
    StockStatus.inStock => StatusTone.success,
    StockStatus.lowStock => StatusTone.warning,
    StockStatus.outOfStock => StatusTone.error,
  };
}
