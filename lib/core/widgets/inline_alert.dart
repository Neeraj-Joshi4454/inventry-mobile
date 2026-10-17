import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import 'status_badge.dart';

/// A tappable in-page alert row (e.g. "3 stock alerts"): tinted background,
/// matching border, icon, wrapping text, optional count, and a chevron when
/// it navigates somewhere.
class InlineAlert extends StatelessWidget {
  const InlineAlert({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.tone = StatusTone.warning,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? message;
  final StatusTone tone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = switch (tone) {
      StatusTone.success => isDark ? const Color(0xFF4ADE80) : const Color(0xFF15803D),
      StatusTone.warning => isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
      StatusTone.error => isDark ? const Color(0xFFF87171) : const Color(0xFFC62828),
      StatusTone.info => scheme.onPrimaryContainer,
      StatusTone.neutral => scheme.onSurfaceVariant,
    };
    final radius = BorderRadius.circular(AppRadius.lg);

    return Material(
      color: accent.withValues(alpha: isDark ? 0.14 : 0.07),
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: accent.withValues(alpha: 0.35)),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: accent, size: AppSizes.icon),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.onSurface)),
                    if (message != null) ...[
                      const SizedBox(height: 2),
                      Text(message!, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: AppSizes.icon),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
