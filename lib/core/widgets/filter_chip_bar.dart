import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// A single selectable filter chip. Selected = brand tint background, brand
/// text and a brand border; unselected = surface with a neutral border.
/// Fixed height and no checkmark, so selecting never changes its size.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({super.key, required this.label, required this.selected, required this.onSelected});

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(AppRadius.sm + 2);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: selected ? scheme.primary : scheme.outlineVariant),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onSelected,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSizes.chipHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Center(
                widthFactor: 1,
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? scheme.onPrimaryContainer : scheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterOption<T> {
  const FilterOption(this.value, this.label);

  final T value;
  final String label;
}

/// One horizontally scrolling row of single-select filter chips. Scrolls
/// within its own bounds (never the page), keeps the gutter padding at both
/// ends, and its height is derived from the chip height plus vertical
/// breathing room — chips can't be clipped the way a fixed-height box
/// around Material chips clipped their 48px tap target.
class FilterChipBar<T> extends StatelessWidget {
  const FilterChipBar({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.semanticLabel,
  });

  final List<FilterOption<T>> options;
  final T selected;
  final ValueChanged<T> onSelected;
  final String? semanticLabel;

  static const double height = AppSizes.chipHeight + AppSpacing.sm * 2;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      container: true,
      child: SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final option = options[index];
            return AppFilterChip(
              key: ValueKey(option.value),
              label: option.label,
              selected: option.value == selected,
              onSelected: () => onSelected(option.value),
            );
          },
        ),
      ),
    );
  }
}
