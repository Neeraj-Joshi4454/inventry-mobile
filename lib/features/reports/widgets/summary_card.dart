import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';

/// One stat tile ("Total Products: 42") used across every report screen's
/// summary row — kept as a single shared widget so all reports look and
/// behave the same rather than each screen hand-rolling its own card.
class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.label, required this.value, this.color, this.caption});

  final String label;
  final String value;
  final Color? color;

  /// Optional secondary line under the value (e.g. "4 invoices").
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: textTheme.labelMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppSpacing.xs),
            // Large amounts shrink to fit rather than overflow the tile.
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                maxLines: 1,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color ?? textTheme.titleLarge?.color,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            if (caption != null) ...[
              const SizedBox(height: 2),
              Text(caption!, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ],
        ),
      ),
    );
  }
}

/// Responsive grid of [SummaryCard]s — two columns on phones, three from
/// 600px. Rows size to their content (no fixed aspect ratio), so tiles
/// never clip at narrow widths or with large system text sizes; tiles in
/// the same row share the tallest tile's height.
class SummaryCardGrid extends StatelessWidget {
  const SummaryCardGrid({super.key, required this.cards});

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 600 ? 3 : 2;
        final rows = <Widget>[];
        for (var start = 0; start < cards.length; start += columns) {
          final rowCards = cards.sublist(start, (start + columns).clamp(0, cards.length));
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < columns; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.md),
                    Expanded(child: i < rowCards.length ? rowCards[i] : const SizedBox.shrink()),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            for (var i = 0; i < rows.length; i++) ...[if (i > 0) const SizedBox(height: AppSpacing.md), rows[i]],
          ],
        );
      },
    );
  }
}
