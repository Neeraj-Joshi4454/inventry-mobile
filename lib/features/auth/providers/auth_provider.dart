import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_api.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

/// The app's single configured Dio instance. `onSessionExpired` is a
/// closure that reads `authNotifierProvider` *lazily* — only when a refresh
/// attempt actually fails, long after both providers have finished their
/// own construction — so this does not create a build-time circular
/// dependency between dioProvider and authNotifierProvider, even though
/// authNotifierProvider transitively depends on dioProvider.
final dioProvider = Provider<Dio>((ref) {
  final client = DioClient(
    tokenStorage: ref.watch(tokenStorageProvider),
    onSessionExpired: () => ref.read(authNotifierProvider.notifier).forceLogout(),
  );
  return client.dio;
});

final authApiProvider = Provider<AuthApi>((ref) => AuthApi(ref.watch(dioProvider)));

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(authApi: ref.watch(authApiProvider), tokenStorage: ref.watch(tokenStorageProvider)),
);

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // build() must return synchronously; kick off session restoration as a
    // fire-and-forget task that reports its outcome via `state =`.
    Future.microtask(_restoreSession);
    return const AuthState.initial();
  }

  /// App-startup flow: 1) check for a stored session, 2) if present, try
  /// `/auth/me` — the Dio auth interceptor transparently refreshes the
  /// access token first if it's expired, so this alone covers "restore" and
  /// "refresh if needed" — 3) if that still fails, the session truly is
  /// invalid, so fall back to the login screen.
  Future<void> _restoreSession() async {
    state = const AuthState.loading();
    final repo = ref.read(authRepositoryProvider);

    // Deliberately broad: secure storage itself failing (corrupted
    // keystore, plugin unavailable, etc.) must fall back to "please log
    // in" rather than leaving the app stuck on the splash screen forever.
    try {
      final hasSession = await repo.hasStoredSession();
      if (!hasSession) {
        state = const AuthState.unauthenticated();
        return;
      }
      final user = await repo.fetchCurrentUser();
      state = AuthState.authenticated(user);
    } catch (_) {
      await repo.clearLocalSession().catchError((_) {});
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({required String mobileNumber, required String password}) async {
    state = const AuthState.loading();
    try {
      final user = await ref.read(authRepositoryProvider).login(mobileNumber: mobileNumber, password: password);
      state = AuthState.authenticated(user);
    } on ApiException catch (e) {
      state = AuthState.error(e.message);
    } catch (_) {
      state = const AuthState.error('Something went wrong. Please try again.');
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Best-effort revoke — even if it fails (e.g. no network), the user
      // must still end up logged out locally.
    }
    state = const AuthState.unauthenticated();
  }

  /// Invoked by the Dio interceptor when a token refresh fails — the
  /// session is unrecoverable server-side, so drop straight to
  /// unauthenticated without attempting another network call.
  void forceLogout() {
    if (state case AuthUnauthenticated()) return;
    unawaited(ref.read(authRepositoryProvider).clearLocalSession());
    state = const AuthState.unauthenticated();
  }
}
