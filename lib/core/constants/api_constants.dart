import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Central place for API configuration. The base URL is overridable at
/// build/run time via `--dart-define=API_BASE_URL=...` (e.g. for a staging
/// server or a physical device on the same network) — never hard-code a
/// single URL that only works from one environment.
class ApiConstants {
  ApiConstants._();

  static const String _override = String.fromEnvironment('API_BASE_URL');

  /// Sensible per-platform dev defaults:
  /// - Android emulator can't reach the host machine via `localhost` (it has
  ///   its own network namespace) — `10.0.2.2` is the documented alias for
  ///   the host loopback interface.
  /// - iOS simulator, macOS, and web all share the host's network stack, so
  ///   `localhost` works directly.
  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:4000/api/v1';
    }
    return 'http://localhost:4000/api/v1';
  }

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Auth endpoints
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
}
