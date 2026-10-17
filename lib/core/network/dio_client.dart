import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';
import 'interceptors/auth_interceptor.dart';

/// Builds the app's single configured [Dio] instance. UI code and
/// repositories never construct their own Dio — everything goes through
/// this so base URL, timeouts, auth, and error behavior stay in one place.
class DioClient {
  DioClient({required TokenStorage tokenStorage, required void Function() onSessionExpired}) {
    final baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      contentType: 'application/json',
    );

    // Bare instance for the refresh call only — must not carry the
    // AuthInterceptor, or a 401 on the refresh request itself would recurse.
    _refreshDio = Dio(baseOptions);

    final authInterceptor = AuthInterceptor(
      tokenStorage: tokenStorage,
      refreshDio: _refreshDio,
      onSessionExpired: onSessionExpired,
    );

    dio = Dio(baseOptions);
    dio.interceptors.add(authInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));
    }

    // The interceptor replays a failed request through the main client
    // (so any later interceptors still apply on retry) — wire that back-
    // reference up now that `dio` exists.
    authInterceptor.dio = dio;
  }

  late final Dio dio;
  late final Dio _refreshDio;
}
