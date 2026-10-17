import 'package:flutter/material.dart';

import '../../../core/widgets/status_badge.dart';
import '../data/models/stock_status.dart';

/// Stock status as a [StatusBadge]: green / amber / red.
class StockStatusChip extends StatelessWidget {
  const StockStatusChip({super.key, required this.status});

  final StockStatus status;

  @override
  Widget build(BuildContext context) => StatusBadge(label: status.label, tone: status.tone);
}
