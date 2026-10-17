/// Keys used with [FlutterSecureStorage]. Centralized so a typo can't
/// silently create a second, orphaned storage slot.
class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'inventry_access_token';
  static const String refreshToken = 'inventry_refresh_token';
}
