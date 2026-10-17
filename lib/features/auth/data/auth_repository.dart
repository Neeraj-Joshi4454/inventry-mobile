import '../../../core/storage/token_storage.dart';
import 'auth_api.dart';
import 'models/auth_user.dart';

/// Combines [AuthApi] (network) with [TokenStorage] (persistence) into the
/// operations the app's auth flow actually needs. This is what
/// [AuthNotifier] talks to — it never calls [AuthApi] or [TokenStorage]
/// directly.
class AuthRepository {
  AuthRepository({required AuthApi authApi, required TokenStorage tokenStorage})
    : _authApi = authApi,
      _tokenStorage = tokenStorage;

  final AuthApi _authApi;
  final TokenStorage _tokenStorage;

  Future<bool> hasStoredSession() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    return refreshToken != null;
  }

  /// Logs in, persists both tokens, then fetches the canonical user profile
  /// — matching the required flow exactly: store access token, store
  /// refresh token, fetch `/auth/me`, return the authenticated user.
  Future<AuthUser> login({required String mobileNumber, required String password}) async {
    final tokens = await _authApi.login(mobileNumber: mobileNumber, password: password);
    await _tokenStorage.saveTokens(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken);
    return _authApi.fetchCurrentUser();
  }

  Future<AuthUser> fetchCurrentUser() => _authApi.fetchCurrentUser();

  /// User-initiated logout: revoke the session server-side, then clear
  /// local storage regardless of whether the revoke call succeeded (a
  /// failed revoke — e.g. the network drops mid-request — must never leave
  /// the app stuck showing itself as logged in).
  Future<void> logout() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    try {
      if (refreshToken != null) {
        await _authApi.logout(refreshToken);
      }
    } finally {
      await _tokenStorage.clear();
    }
  }

  /// Used when the interceptor detects an unrecoverable session (refresh
  /// failed) — the server-side session is already invalid, so there's
  /// nothing to revoke; just forget the local tokens.
  Future<void> clearLocalSession() => _tokenStorage.clear();
}
