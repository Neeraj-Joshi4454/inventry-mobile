import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// A tappable list row on its own bordered surface — the row style for
/// product / inventory lists. Title wraps to two lines at most, the
/// subtitle to one; the trailing column is right-aligned and capped in
/// width so long names and big quantities can't push each other out.
class ListRowCard extends StatelessWidget {
  const ListRowCard({super.key, required this.title, this.subtitle, this.trailing, this.onTap});

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleSmall?.copyWith(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.md),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.42),
                  child: trailing,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Spinner row shown at the bottom of a paginated list while the next
/// page loads.
class ListLoadingMore extends StatelessWidget {
  const ListLoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Center(child: SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))),
    );
  }
}
