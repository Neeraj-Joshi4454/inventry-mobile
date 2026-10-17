import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum AppButtonVariant {
  /// Main action on a screen (Save, Sign In). One per screen.
  primary,

  /// Supporting action next to or instead of a primary one.
  secondary,

  /// Lightweight action (Cancel, Clear filters).
  tertiary,

  /// Irreversible action (Delete). Filled red.
  destructive,
}

enum AppButtonSize { regular, compact }

/// The app's one button component. Wraps the theme's Material buttons so
/// every screen gets the same height, radius, typography, and loading /
/// disabled behaviour. Full width by default (form footers); pass
/// `expand: false` for inline use.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    // While loading the button is non-interactive but keeps its enabled
    // colours, so it doesn't flash grey mid-submit.
    final effectiveOnPressed = isLoading ? () {} : onPressed;
    final height = size == AppButtonSize.compact ? AppSizes.buttonHeightCompact : AppSizes.buttonHeight;
    final minimumSize = Size(expand ? double.infinity : 64, height);

    final child = _ButtonContent(label: label, icon: icon, isLoading: isLoading, spinnerColor: _spinnerColor(context));

    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(minimumSize: minimumSize),
        child: child,
      ),
      AppButtonVariant.destructive => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          minimumSize: minimumSize,
          backgroundColor: AppColors.error,
          disabledBackgroundColor: AppColors.error.withValues(alpha: 0.4),
        ),
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(minimumSize: minimumSize),
        child: child,
      ),
      AppButtonVariant.tertiary => TextButton(
        onPressed: effectiveOnPressed,
        style: TextButton.styleFrom(minimumSize: minimumSize),
        child: child,
      ),
    };

    return Semantics(
      liveRegion: isLoading,
      child: AbsorbPointer(absorbing: isLoading, child: button),
    );
  }

  Color _spinnerColor(BuildContext context) => switch (variant) {
    AppButtonVariant.primary || AppButtonVariant.destructive => Colors.white,
    _ => Theme.of(context).colorScheme.primary,
  };
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({required this.label, required this.icon, required this.isLoading, required this.spinnerColor});

  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color spinnerColor;

  @override
  Widget build(BuildContext context) {
    // The label stays laid out (just invisible) while loading so the button
    // never changes width when the spinner appears.
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: AppSizes.iconSm), const SizedBox(width: AppSpacing.sm)],
        Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
    if (!isLoading) return content;
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: content),
        SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2.25, color: spinnerColor)),
      ],
    );
  }
}
