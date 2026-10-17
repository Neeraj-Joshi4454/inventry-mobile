import 'package:flutter/material.dart';

/// Colour tokens. One professional blue carries brand and interaction;
/// everything else is neutral so status colours and data stay legible.
/// Status foregrounds are the darker, text-safe shades (≥4.5:1 on white);
/// the `*Soft` tints are their badge/alert backgrounds.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF087DB8);
  static const Color primaryDark = Color(0xFF066797); // pressed / emphasis
  static const Color primaryLight = Color(0xFF4FB0E3); // primary on dark surfaces
  static const Color primarySoft = Color(0xFFE6F2F9); // selected chip / nav indicator
  static const Color accent = Color(0xFF0EA5C6); // cyan — use sparingly

  static const Color secondary = Color(0xFF334155);

  // Status
  static const Color success = Color(0xFF15803D);
  static const Color successSoft = Color(0xFFEAF7EF);
  static const Color warning = Color(0xFFB45309);
  static const Color warningSoft = Color(0xFFFFF6E5);
  static const Color error = Color(0xFFC62828);
  static const Color errorSoft = Color(0xFFFDEDED);
  static const Color info = Color(0xFF087DB8);

  // Light theme neutrals
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceMuted = Color(0xFFF0F3F7); // skeletons, subtle fills
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderStrong = Color(0xFFCBD5E1);
  static const Color lightTextPrimary = Color(0xFF0F1B2D);
  static const Color lightTextSecondary = Color(0xFF5B6B80);

  // Dark theme neutrals
  static const Color darkBackground = Color(0xFF0E1621);
  static const Color darkSurface = Color(0xFF16202C);
  static const Color darkSurfaceMuted = Color(0xFF1D2936);
  static const Color darkBorder = Color(0xFF263241);
  static const Color darkBorderStrong = Color(0xFF3A4757);
  static const Color darkTextPrimary = Color(0xFFE8EEF5);
  static const Color darkTextSecondary = Color(0xFF9AA8B8);
}
