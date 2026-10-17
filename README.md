# Inventry Mobile

Flutter mobile app for the Inventry multi-tenant inventory SaaS — business
users (Owner, Manager, Store Keeper, Sales Person, Accountant). Talks to
the existing Node.js/Express backend (`../backend`) — no backend logic is
duplicated here.

## Tech stack

Flutter · Dart · Riverpod (`flutter_riverpod`) · Dio · GoRouter ·
Flutter Secure Storage · Freezed + json_serializable (code-generated models)

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates *.freezed.dart / *.g.dart
flutter run
```

The backend must be running (see `../backend/README.md`) with a Super Admin
bootstrapped and at least one business created, so there's an account to
log in with.

### Pointing at the backend

The API base URL defaults per platform (`lib/core/constants/api_constants.dart`):
- Android emulator → `http://10.0.2.2:4000/api/v1` (the documented alias for
  the host machine's `localhost` from inside the emulator's network namespace)
- iOS simulator / macOS / web → `http://localhost:4000/api/v1`

Override for a physical device or a different environment:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:4000/api/v1
```

## Verify

```bash
flutter analyze   # must pass with zero issues
flutter test
```

## Architecture

```
lib/
  core/
    constants/   API endpoints/base URL, secure-storage key names
    network/     DioClient (base config + interceptors), AuthInterceptor
                 (attaches the access token; on 401, refreshes once and
                 retries — concurrent 401s share one in-flight refresh
                 instead of racing), ApiException + mapDioException
                 (translates every Dio failure into a user-safe message)
    storage/     TokenStorage — FlutterSecureStorage wrapper
    theme/       AppColors, AppTypography, AppTheme (light + dark)
    widgets/     AppButton, AppTextField, LoadingIndicator, ErrorView,
                 EmptyState, SplashScreen
    utils/       Validators (UI-side only — backend remains authoritative)
    router/      GoRouter setup + auth-aware redirect logic
  features/
    auth/
      data/
        models/          AuthUser, AuthTenant, AuthTokens (Freezed)
        auth_api.dart    raw Dio calls — no state, no storage
        auth_repository.dart   combines AuthApi + TokenStorage into the
                                operations AuthNotifier needs
      providers/
        auth_state.dart    sealed AuthState union: initial/loading/
                           authenticated/unauthenticated/error
        auth_provider.dart AuthNotifier + all the Riverpod wiring
      screens/
        login_screen.dart
    dashboard/
      screens/
        dashboard_screen.dart   placeholder landing screen
```

`products/`, `inventory/`, `purchases/`, `sales/`, `customers/`,
`suppliers/`, `reports/`, `settings/` feature folders are **not** created
yet — they're explicitly out of scope for this phase (see "What's not
built" below). Adding empty placeholder folders for them now would just be
dead scaffolding; each will be created when its feature is actually built,
following the same `data/providers/screens` shape as `auth/`.

## Authentication flow

1. **Login** (`POST /auth/login`) → store both access and refresh tokens in
   `flutter_secure_storage` (Keychain on iOS, encrypted Keystore-backed
   storage on Android) → fetch `GET /auth/me` → store the resulting
   `AuthUser` in `AuthState.authenticated` → GoRouter's redirect logic
   sends the user to `/dashboard`.
2. **Every authenticated request** goes through `AuthInterceptor`, which
   attaches `Authorization: Bearer <accessToken>` automatically (except to
   `/auth/login`/`/auth/refresh`/`/auth/logout`, which must never carry a
   stale or absent token).
3. **On a 401**, the interceptor transparently calls `/auth/refresh` once
   (via a separate, interceptor-free Dio instance, so a 401 on the refresh
   call itself can't recurse), saves the rotated token pair, and retries
   the original request with the new access token. Concurrent 401s across
   multiple in-flight requests share one refresh call rather than each
   firing their own (which would race the backend's refresh-token
   rotation and fail every request after the first).
4. **If refresh fails** (session truly expired/revoked), the interceptor
   calls back into `AuthNotifier.forceLogout()` — tokens are cleared and
   the app state flips to `unauthenticated`, which GoRouter's
   `refreshListenable` picks up immediately and redirects to `/login`,
   with no user action required.
5. **App startup**: `AuthNotifier` checks for a stored refresh token; if
   none, straight to `unauthenticated`. If one exists, it calls
   `GET /auth/me` directly — if the stored access token is stale, step 3's
   interceptor logic transparently refreshes and retries it, so "restore
   session" and "refresh if needed" are the same code path, not two.
6. **Logout** (`POST /auth/logout`) revokes the session server-side (best
   effort — even if that call fails, e.g. no network, local tokens are
   still cleared so the user never gets stuck "logged in" with no way out),
   then clears secure storage and flips state to `unauthenticated`.

## Error handling

`mapDioException` (`core/network/api_exception.dart`) is the single place
that turns a Dio failure into a message a screen can show. The backend
already returns clean, safe messages in its `{ success: false, message,
errors }` envelope for expected failures (invalid credentials, inactive/
suspended account, rate limiting) — those are used directly. Everything
else (dropped connection, timeout, a malformed response, an actual 500)
gets a generic, friendly fallback. No screen in this app ever renders a raw
`DioException` or stack trace.

## What's not built (by design, this phase)

Per the brief: only the Flutter foundation, API layer, authentication,
login, routing, and a basic dashboard placeholder. Products, Inventory,
Sales, Purchases, Customers, Suppliers, Reports, and Settings are not
implemented — `DashboardScreen` is a placeholder landing screen with a
working logout button, not a real dashboard.
