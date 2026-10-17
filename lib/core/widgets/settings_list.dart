import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// A titled group of [SettingsListItem]s on one bordered surface, with
/// hairline separators between rows (inset to align with the text).
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) rows.add(const Divider(indent: AppSpacing.lg + AppSizes.listLeading + AppSpacing.md));
      rows.add(children[i]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xs, 0, AppSpacing.xs, AppSpacing.sm),
            child: Text(title!.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
          ),
        Card(child: Column(children: rows)),
      ],
    );
  }
}

/// One settings / navigation row: tinted icon tile, title, optional
/// subtitle, optional trailing widget (badge, value), and a chevron when
/// it navigates.
class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.destructive = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = destructive ? scheme.error : scheme.onSurface;
    final iconColor = destructive ? scheme.error : scheme.onPrimaryContainer;
    final iconFill = destructive ? scheme.error.withValues(alpha: 0.08) : scheme.primaryContainer;

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: AppSizes.listLeading,
                height: AppSizes.listLeading,
                decoration: BoxDecoration(color: iconFill, borderRadius: BorderRadius.circular(AppRadius.md)),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: foreground),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: AppSpacing.sm), trailing!],
              if (showChevron && onTap != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(Icons.chevron_right, size: AppSizes.icon, color: scheme.onSurfaceVariant),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
