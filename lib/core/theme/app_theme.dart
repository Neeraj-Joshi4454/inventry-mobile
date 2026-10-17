import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

/// Neutral, flat-by-default theme: surfaces are separated by a hairline
/// border on a light grey background rather than by shadows. Elevation is
/// reserved for things that genuinely float (dialogs, sheets, the FAB).
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final background = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceMuted = isDark ? AppColors.darkSurfaceMuted : AppColors.lightSurfaceMuted;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final borderStrong = isDark ? AppColors.darkBorderStrong : AppColors.lightBorderStrong;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    // Brand blue for text/icons on surfaces — lighter in dark mode for contrast.
    final brandOnSurface = isDark ? AppColors.primaryLight : AppColors.primary;
    final selectedFill = isDark ? AppColors.primary.withValues(alpha: 0.22) : AppColors.primarySoft;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: selectedFill,
      onPrimaryContainer: brandOnSurface,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      surfaceContainerLowest: surface,
      surfaceContainerLow: surface,
      surfaceContainer: surface,
      surfaceContainerHigh: surface,
      surfaceContainerHighest: surfaceMuted,
      outline: borderStrong,
      outlineVariant: border,
      shadow: Colors.black,
      surfaceTint: Colors.transparent,
    );

    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md));
    const buttonText = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.1);
    const buttonPadding = EdgeInsets.symmetric(horizontal: AppSpacing.lg);
    const buttonMinSize = Size(64, AppSizes.buttonHeight);

    OutlineInputBorder inputBorder(Color color, [double width = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: color, width: width),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      textTheme: AppTypography.textTheme(textPrimary, textSecondary),
      iconTheme: IconThemeData(color: textSecondary, size: AppSizes.icon),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: AppSpacing.lg,
        toolbarHeight: 56,
        iconTheme: IconThemeData(color: textPrimary, size: AppSizes.icon),
        actionsIconTheme: IconThemeData(color: textPrimary, size: AppSizes.icon),
        titleTextStyle: AppTypography.appBarTitle.copyWith(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: border),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: textSecondary,
        textColor: textPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        minLeadingWidth: 24,
        horizontalTitleGap: AppSpacing.md,
        titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: textPrimary),
        subtitleTextStyle: TextStyle(fontSize: 13, color: textSecondary, height: 1.3),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 14),
        hintStyle: TextStyle(color: textSecondary, fontSize: 15),
        labelStyle: TextStyle(color: textSecondary),
        floatingLabelStyle: TextStyle(color: brandOnSurface),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        border: inputBorder(border),
        enabledBorder: inputBorder(border),
        disabledBorder: inputBorder(border.withValues(alpha: 0.6)),
        focusedBorder: inputBorder(AppColors.primary, 1.5),
        errorBorder: inputBorder(AppColors.error),
        focusedErrorBorder: inputBorder(AppColors.error, 1.5),
      ),
      // Primary action. AppButton builds on these themes; raw Material
      // buttons elsewhere get the same look.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.9),
          minimumSize: buttonMinSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.9),
          minimumSize: buttonMinSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          backgroundColor: surface,
          minimumSize: buttonMinSize,
          padding: buttonPadding,
          side: BorderSide(color: borderStrong),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: brandOnSurface,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: textPrimary, minimumSize: const Size(44, 44), shape: buttonShape),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        focusElevation: 3,
        hoverElevation: 3,
        highlightElevation: 1,
        extendedTextStyle: buttonText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
      ),
      // Used by ChoiceChip/FilterChip still found in forms (e.g. GST rate);
      // filter bars use AppFilterChip, which follows the same tokens.
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: selectedFill,
        disabledColor: surfaceMuted,
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(color: states.contains(WidgetState.selected) ? AppColors.primary : border),
        ),
        labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textPrimary),
        secondaryLabelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: brandOnSurface),
        checkmarkColor: brandOnSurface,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm + 2)),
        elevation: 0,
        pressElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        height: 64,
        indicatorColor: selectedFill,
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: AppSizes.icon,
            color: states.contains(WidgetState.selected) ? brandOnSurface : textSecondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            height: 1.2,
            fontWeight: states.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? brandOnSurface : textSecondary,
          ),
        ),
      ),
      badgeTheme: const BadgeThemeData(
        backgroundColor: AppColors.error,
        textColor: Colors.white,
        textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
        contentTextStyle: TextStyle(fontSize: 14, height: 1.45, color: textSecondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        showDragHandle: true,
        dragHandleColor: borderStrong,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl))),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: border),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.darkSurfaceMuted : AppColors.lightTextPrimary,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actionTextColor: AppColors.primaryLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: border,
        circularTrackColor: Colors.transparent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? Colors.white : borderStrong,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.primary : surfaceMuted,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.primary : borderStrong,
        ),
      ),
    );
  }
}
