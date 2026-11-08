import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../storage/token_storage.dart';

/// Attaches the access token to every request (except login/refresh, which
/// must never carry a stale/absent token), and transparently refreshes the
/// session exactly once on a 401 before retrying the original request.
///
/// Only a refresh the server actually rejects ends the session. A refresh
/// that merely couldn't complete — no signal, a timeout while the server
/// wakes up, a rate limit, a server error — fails just the one request and
/// keeps the user signed in, so the next request tries again.
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

  /// Invoked when the server rejects the refresh token (or there was never
  /// one to use) — the app must treat this as a hard logout.
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

    final String? newAccessToken;
    try {
      // Another request may already have refreshed while this one was in
      // flight with the old token — reuse that rather than rotate again.
      final stored = await tokenStorage.getAccessToken();
      final sentWith = options.headers['Authorization'];
      newAccessToken = stored != null && sentWith != 'Bearer $stored' ? stored : await _refreshAccessToken();
    } on DioException catch (refreshError) {
      if (_isRejected(refreshError)) onSessionExpired();
      // Otherwise the refresh never got a verdict — report this request's
      // failure as that (e.g. "Unable to connect"), but stay signed in.
      handler.next(_isRejected(refreshError) ? err : refreshError);
      return;
    } catch (_) {
      handler.next(err); // e.g. secure storage hiccup — not a server verdict
      return;
    }
    if (newAccessToken == null) {
      onSessionExpired();
      handler.next(err);
      return;
    }

    options.extra['retried'] = true;
    options.headers['Authorization'] = 'Bearer $newAccessToken';
    try {
      handler.resolve(await dio!.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      // The session is fine (it was just refreshed) — this is the request's
      // own outcome, e.g. a validation error or no signal.
      handler.next(retryError);
    }
  }

  /// The server looked at the refresh token and said no — revoked, expired,
  /// or the account was deactivated.
  static bool _isRejected(DioException e) {
    final status = e.response?.statusCode;
    return status == 401 || status == 403;
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
      // Long enough to ride out the server waking from sleep — giving up
      // early would discard a refresh the server may still complete.
      options: Options(receiveTimeout: ApiConstants.wakeUpTimeout, sendTimeout: ApiConstants.wakeUpTimeout),
    );

    final data = response.data?['data'] as Map<String, dynamic>?;
    final newAccessToken = data?['accessToken'] as String?;
    final newRefreshToken = data?['refreshToken'] as String?;
    if (newAccessToken == null || newRefreshToken == null) return null;

    await tokenStorage.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);
    return newAccessToken;
  }
}
