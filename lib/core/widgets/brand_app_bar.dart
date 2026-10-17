import 'package:flutter/material.dart';

import '../constants/brand.dart';
import '../theme/app_tokens.dart';

/// The app bar for every screen: the Stock Yard mark and name sit above the
/// page title, so the brand is always visible without losing which screen
/// you're on. Drop-in for [AppBar] for the parameters screens use.
class BrandAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandAppBar({super.key, required this.title, this.actions});

  /// The page title — usually a [Text].
  final Widget title;
  final List<Widget>? actions;

  static const double _height = 64;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.appBarTheme.titleTextStyle ?? theme.textTheme.titleLarge;

    return AppBar(
      toolbarHeight: _height,
      actions: actions,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Image.asset(
              Brand.logoMarkAsset,
              width: 34,
              height: 34,
              filterQuality: FilterQuality.medium,
              semanticLabel: '${Brand.appName} logo',
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Brand.appName.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    letterSpacing: 1.1,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 1),
                DefaultTextStyle.merge(
                  style: titleStyle?.copyWith(fontSize: 18, height: 1.2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  child: title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full Stock Yard logo tile for sign-in / splash.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: Image.asset(Brand.logoAsset, width: size, height: size, semanticLabel: '${Brand.appName} logo'),
    );
  }
}
