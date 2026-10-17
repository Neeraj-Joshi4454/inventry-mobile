import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Full-section "nothing here yet" state — used for empty lists once
/// products/inventory/sales/etc. are built, and for feature placeholders
/// in the meantime.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, this.description, this.action});

  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, size: 30, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(title, style: textTheme.titleMedium, textAlign: TextAlign.center),
            if (description != null) ...[
              const SizedBox(height: 6),
              Text(description!, style: textTheme.bodySmall, textAlign: TextAlign.center),
            ],
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
