import 'package:flutter/widgets.dart';

/// Spacing scale (4pt grid). Screens use these instead of ad-hoc numbers so
/// padding stays consistent from screen to screen.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Standard horizontal page gutter.
  static const EdgeInsets page = EdgeInsets.symmetric(horizontal: lg);

  /// Bottom padding for scrolling lists on a screen with a FAB, so the last
  /// row can scroll clear of it.
  static const double fabClearance = 96;
}

class AppRadius {
  AppRadius._();

  static const double sm = 6;
  static const double md = 10;
  static const double lg = 12;
  static const double xl = 16;
}

class AppSizes {
  AppSizes._();

  static const double buttonHeight = 48;
  static const double buttonHeightCompact = 40;
  static const double inputHeight = 48;
  static const double chipHeight = 34;
  static const double iconSm = 18;
  static const double icon = 22;
  static const double listLeading = 40;
}
