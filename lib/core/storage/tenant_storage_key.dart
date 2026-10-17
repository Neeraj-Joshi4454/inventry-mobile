import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/auth_state.dart';

/// Key that scopes on-device business data (UPI QR, logo, bank details) to
/// the signed-in business, so a shared phone never mixes two businesses.
String tenantStorageKey(Ref ref) {
  final auth = ref.read(authNotifierProvider);
  return switch (auth) {
    AuthAuthenticated(:final user) => user.tenant?.id ?? user.id,
    _ => 'anonymous',
  };
}
