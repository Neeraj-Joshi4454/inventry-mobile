import 'package:flutter/material.dart';

/// Text styles built on the platform default font (no extra font-loading
/// dependency) — weight and sizing are what carry the "clean, modern"
/// character rather than a custom typeface.
class AppTypography {
  AppTypography._();

  static TextTheme textTheme(Color primaryTextColor, Color secondaryTextColor) {
    return TextTheme(
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: primaryTextColor, letterSpacing: -0.5),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: primaryTextColor),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: primaryTextColor),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryTextColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryTextColor),
      bodyLarge: TextStyle(fontSize: 16, color: primaryTextColor, height: 1.4),
      bodyMedium: TextStyle(fontSize: 14, color: primaryTextColor, height: 1.4),
      bodySmall: TextStyle(fontSize: 12, color: secondaryTextColor, height: 1.3),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryTextColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryTextColor),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: secondaryTextColor, letterSpacing: 0.2),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: secondaryTextColor, letterSpacing: 0.3),
    );
  }

  static const TextStyle appBarTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.2);

  static TextStyle caption(Color color) => TextStyle(fontSize: 12, color: color);
}
