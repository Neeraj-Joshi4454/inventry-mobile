import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
abstract class AuthTenant with _$AuthTenant {
  const factory AuthTenant({required String id, required String name}) = _AuthTenant;

  factory AuthTenant.fromJson(Map<String, dynamic> json) => _$AuthTenantFromJson(json);
}

/// Mirrors the backend's `GET /auth/me` response exactly
/// (backend/src/modules/auth/auth.service.ts::getMe). This is the single
/// canonical user shape used app-wide — the `user` object embedded in the
/// login response is intentionally not modeled separately, since the login
/// flow always calls `/auth/me` immediately afterward.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String name,
    required String mobileNumber,
    required String role,
    AuthTenant? tenant,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
}
