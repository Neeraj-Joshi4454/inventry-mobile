import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../storage/token_storage.dart';

/// Attaches the access token to every request (except login/refresh, which
/// must never carry a stale/absent token), and transparently refreshes the
/// session exactly once on a 401 before retrying the original request.
///
/// Concurrent 401s share a single in-flight refresh (via [_refreshCompleter])
/// instead of each firing its own competing `/auth/refresh` call, which
/// would race the backend's refresh-token rotation and fail every request
/// after the first.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStorage, required this.refreshDio, required this.onSessionExpired});

  final TokenStorage tokenStorage;

  /// A separate Dio instance with no interceptors of its own, used only for
  /// the refresh call itself — routing it through the main client would
  /// recurse back into this interceptor.
  final Dio refreshDio;

  /// Invoked when refreshing fails (or there was never a refresh token to
  /// use) — the app must treat this as a hard logout.
  final void Function() onSessionExpired;

  /// Set by DioClient right after both it and this interceptor are
  /// constructed — needed to replay the original request via the *main*
  /// client (so later interceptors, e.g. logging, still apply on retry).
  Dio? dio;

  Completer<String?>? _refreshCompleter;

  static bool _isAuthEndpoint(String path) =>
      path.endsWith(ApiConstants.login) || path.endsWith(ApiConstants.refresh) || path.endsWith(ApiConstants.logout);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_isAuthEndpoint(options.path)) {
      final token = await tokenStorage.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final alreadyRetried = options.extra['retried'] == true;

    if (err.response?.statusCode != 401 || _isAuthEndpoint(options.path) || alreadyRetried) {
      handler.next(err);
      return;
    }

    try {
      final newAccessToken = await _refreshAccessToken();
      if (newAccessToken == null) {
        onSessionExpired();
        handler.next(err);
        return;
      }

      options.extra['retried'] = true;
      options.headers['Authorization'] = 'Bearer $newAccessToken';
      final response = await dio!.fetch<dynamic>(options);
      handler.resolve(response);
    } catch (_) {
      onSessionExpired();
      handler.next(err);
    }
  }

  Future<String?> _refreshAccessToken() {
    final inFlight = _refreshCompleter;
    if (inFlight != null) return inFlight.future;

    final completer = Completer<String?>();
    _refreshCompleter = completer;

    _performRefresh()
        .then(completer.complete)
        .catchError(completer.completeError)
        .whenComplete(() => _refreshCompleter = null);

    return completer.future;
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return null;

    final response = await refreshDio.post<Map<String, dynamic>>(
      ApiConstants.refresh,
      data: {'refreshToken': refreshToken},
    );

    final data = response.data?['data'] as Map<String, dynamic>?;
    final newAccessToken = data?['accessToken'] as String?;
    final newRefreshToken = data?['refreshToken'] as String?;
    if (newAccessToken == null || newRefreshToken == null) return null;

    await tokenStorage.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);
    return newAccessToken;
  }
}
