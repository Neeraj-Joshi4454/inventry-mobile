import 'package:flutter/material.dart';
import 'brand_app_bar.dart';
import 'loading_indicator.dart';

/// Shown only while startup session-restoration is in flight — never a
/// real destination a user can navigate back to (see app_router.dart).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [const BrandLogo(size: 112), const SizedBox(height: 32), const LoadingIndicator()],
        ),
      ),
    );
  }
}
