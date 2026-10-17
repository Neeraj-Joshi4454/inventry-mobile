import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum StatusTone { success, warning, error, info, neutral }

/// Compact status pill: tinted background, dot, and text-safe foreground.
/// The one badge style for stock status, payment status, active/inactive.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.tone, this.showDot = true});

  final String label;
  final StatusTone tone;

  /// Dot for states (In stock, Paid); off for plain labels (a role).
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final (foreground, background) = _colors(tone, isDark, Theme.of(context).colorScheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: foreground, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: foreground, fontSize: 11.5, fontWeight: FontWeight.w600, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  static (Color, Color) _colors(StatusTone tone, bool isDark, ColorScheme scheme) {
    Color tint(Color c) => c.withValues(alpha: isDark ? 0.22 : 1);
    return switch (tone) {
      StatusTone.success => (
        isDark ? const Color(0xFF4ADE80) : AppColors.success,
        isDark ? tint(AppColors.success) : AppColors.successSoft,
      ),
      StatusTone.warning => (
        isDark ? const Color(0xFFFBBF24) : AppColors.warning,
        isDark ? tint(AppColors.warning) : AppColors.warningSoft,
      ),
      StatusTone.error => (
        isDark ? const Color(0xFFF87171) : AppColors.error,
        isDark ? tint(AppColors.error) : AppColors.errorSoft,
      ),
      StatusTone.info => (scheme.onPrimaryContainer, scheme.primaryContainer),
      StatusTone.neutral => (scheme.onSurfaceVariant, scheme.surfaceContainerHighest),
    };
  }
}

/// Payment status of a sale or purchase ("PAID", "PARTIAL", "CREDIT"/"UNPAID")
/// as a [StatusBadge]. Shared by lists, detail screens and the sale preview.
class PaymentStatusBadge extends StatelessWidget {
  const PaymentStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final tone = switch (status) {
      'PAID' => StatusTone.success,
      'PARTIAL' => StatusTone.warning,
      _ => StatusTone.error,
    };
    final label = status.isEmpty ? status : status[0] + status.substring(1).toLowerCase();
    return StatusBadge(label: label, tone: tone);
  }
}
