/// Central place for API configuration. The base URL is overridable at
/// build/run time via `--dart-define=API_BASE_URL=...` (e.g. for a local
/// backend: `http://10.0.2.2:4000/api/v1` on the Android emulator, or
/// `http://localhost:4000/api/v1` on iOS simulator / macOS / web).
class ApiConstants {
  ApiConstants._();

  static const String _override = String.fromEnvironment('API_BASE_URL');

  static const String _production =
      'https://inventry-backend-yy05.onrender.com/api/v1';

  static String get baseUrl =>
      _override.isNotEmpty ? _override : _production;

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Auth endpoints
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  /// Public: a new business asks to join; an admin approves it.
  static const String registrations = '/registrations';
}
