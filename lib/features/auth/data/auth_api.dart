import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import 'models/auth_tokens.dart';
import 'models/auth_user.dart';

/// Raw HTTP calls for the auth endpoints. No token storage, no app state —
/// just request/response, with Dio errors translated into [ApiException]
/// at this boundary so nothing above here ever touches a raw [DioException].
class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<AuthTokens> login({required String mobileNumber, required String password}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.login,
        data: {'mobileNumber': mobileNumber, 'password': password},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      return AuthTokens.fromJson(data);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      return AuthTokens.fromJson(data);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<void>(ApiConstants.logout, data: {'refreshToken': refreshToken});
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<AuthUser> fetchCurrentUser() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiConstants.me);
      final data = response.data!['data'] as Map<String, dynamic>;
      return AuthUser.fromJson(data);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
