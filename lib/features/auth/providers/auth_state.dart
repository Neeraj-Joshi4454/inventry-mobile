import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/auth_user.dart';

part 'auth_state.freezed.dart';

/// The five explicit auth states the app cares about. Modeled as a sealed
/// union (rather than e.g. AsyncValue) because "unauthenticated" is a
/// distinct, first-class outcome here — not just "absence of data".
@freezed
sealed class AuthState with _$AuthState {
  /// App just started; session restoration hasn't run yet.
  const factory AuthState.initial() = AuthInitial;

  /// Session restoration in progress, or a login/logout request in flight.
  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.authenticated(AuthUser user) = AuthAuthenticated;

  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  /// A login attempt failed with a user-facing [message]. Distinct from
  /// [AuthUnauthenticated] so the login screen knows to show an error
  /// rather than just quietly sitting on the login form.
  const factory AuthState.error(String message) = AuthError;
}
