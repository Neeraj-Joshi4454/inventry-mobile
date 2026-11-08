import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/auth_state.dart';
import '../data/branding_api.dart';

final brandingApiProvider = Provider<BrandingApi>((ref) => BrandingApi(ref.watch(dioProvider)));

/// The business's branding as saved on the server, or null when signed out.
/// Throws when offline — callers fall back to their on-device copy.
final brandingInfoProvider = FutureProvider<BrandingInfo?>((ref) async {
  final auth = ref.watch(authNotifierProvider);
  if (auth is! AuthAuthenticated) return null;
  return ref.watch(brandingApiProvider).getBranding();
});
