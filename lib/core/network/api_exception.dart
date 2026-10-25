import 'package:dio/dio.dart';

enum ApiErrorType { network, timeout, unauthorized, forbidden, validation, notFound, rateLimited, server, unknown }

/// A sanitized, user-presentable error. UI code should only ever display
/// [message] — raw backend/Dio error text never reaches the widget tree.
class ApiException implements Exception {
  const ApiException({required this.message, required this.type, this.statusCode});

  final String message;
  final ApiErrorType type;
  final int? statusCode;

  @override
  String toString() => message;
}

/// Converts any [DioException] into a friendly [ApiException].
///
/// The backend already sends clean, safe-to-display messages in its error
/// envelope (`{ success: false, message, errors }`) for expected failures —
/// invalid credentials, inactive/suspended accounts, rate limiting, etc. —
/// so those are used directly. Anything else (network drop, timeout,
/// malformed response, an actual 500) gets a generic, friendly fallback
/// instead of leaking Dio/HTTP internals to the user.
ApiException mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const ApiException(
        message: 'The request timed out. Please check your connection and try again.',
        type: ApiErrorType.timeout,
      );
    case DioExceptionType.connectionError:
      return const ApiException(
        message: 'Unable to connect. Please check your internet connection.',
        type: ApiErrorType.network,
      );
    case DioExceptionType.cancel:
      return const ApiException(message: 'The request was cancelled.', type: ApiErrorType.unknown);
    case DioExceptionType.badResponse:
      return _mapBadResponse(error);
    case DioExceptionType.badCertificate:
      return const ApiException(message: 'Could not establish a secure connection.', type: ApiErrorType.network);
    case DioExceptionType.unknown:
      return const ApiException(message: 'Something went wrong. Please try again.', type: ApiErrorType.unknown);
  }
}

/// The backend's request validation answers a generic "Validation failed"
/// plus an `errors: [{ field, message }]` list naming what was actually
/// wrong — surface those messages so the user knows what to fix.
String? _fieldErrorsMessage(Object? data) {
  final errors = data is Map ? data['errors'] : null;
  if (errors is! List) return null;
  final messages = errors
      .map((e) => e is Map ? e['message'] : null)
      .whereType<String>()
      .where((m) => m.isNotEmpty)
      .toSet();
  return messages.isEmpty ? null : messages.join('\n');
}

ApiException _mapBadResponse(DioException error) {
  final statusCode = error.response?.statusCode;
  final data = error.response?.data;
  final backendMessage = data is Map ? data['message'] as String? : null;

  switch (statusCode) {
    case 400:
      return ApiException(
        message:
            _fieldErrorsMessage(data) ??
            backendMessage ??
            'That request was invalid. Please check the details and try again.',
        type: ApiErrorType.validation,
        statusCode: statusCode,
      );
    case 401:
      return ApiException(
        message: backendMessage ?? 'Your session has expired. Please log in again.',
        type: ApiErrorType.unauthorized,
        statusCode: statusCode,
      );
    case 403:
      return ApiException(
        message: backendMessage ?? "You don't have permission to do that.",
        type: ApiErrorType.forbidden,
        statusCode: statusCode,
      );
    case 404:
      return ApiException(
        message: backendMessage ?? 'We couldn\'t find what you were looking for.',
        type: ApiErrorType.notFound,
        statusCode: statusCode,
      );
    case 429:
      return ApiException(
        message: backendMessage ?? 'Too many attempts. Please wait a moment and try again.',
        type: ApiErrorType.rateLimited,
        statusCode: statusCode,
      );
    default:
      if (statusCode != null && statusCode >= 500) {
        return const ApiException(
          message: 'Something went wrong on our end. Please try again later.',
          type: ApiErrorType.server,
        );
      }
      return ApiException(
        message: backendMessage ?? 'Something went wrong. Please try again.',
        type: ApiErrorType.unknown,
        statusCode: statusCode,
      );
  }
}
