import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Static placeholder rows shaped like the list that's loading, so the
/// first load doesn't jump from a centred spinner to a full list. No
/// shimmer animation — just calm grey blocks.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.rows = 8});

  final int rows;

  @override
  Widget build(BuildContext context) {
    final fill = Theme.of(context).colorScheme.surfaceContainerHighest;
    Widget bar(double width, double height) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(AppRadius.sm)),
    );

    return Semantics(
      label: 'Loading',
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
        itemCount: rows,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bar(160, 14),
                      const SizedBox(height: AppSpacing.sm),
                      bar(90, 11),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    bar(56, 14),
                    const SizedBox(height: AppSpacing.sm),
                    bar(72, 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
