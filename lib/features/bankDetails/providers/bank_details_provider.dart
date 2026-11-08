import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/tenant_storage_key.dart';
import '../../auth/providers/auth_provider.dart';
import '../../branding/data/branding_api.dart';
import '../../branding/providers/branding_providers.dart';
import '../data/bank_details.dart';
import '../data/bank_details_store.dart';

final bankDetailsStoreProvider = Provider<BankDetailsStore>((ref) => BankDetailsStore());

/// This business's bank details (null = not set). Saved on the server so
/// every phone sees them and they survive reinstalling the app; the copy
/// on this phone is used when offline.
class BankDetailsNotifier extends AsyncNotifier<BankDetails?> {
  BankDetailsStore get _store => ref.read(bankDetailsStoreProvider);

  @override
  Future<BankDetails?> build() async {
    ref.watch(authNotifierProvider); // reload when the account changes
    final key = tenantStorageKey(ref);
    final local = await _store.load(key);

    final BrandingInfo? info;
    try {
      info = await ref.watch(brandingInfoProvider.future);
    } catch (_) {
      return local; // offline — show the cached copy
    }
    if (info == null) return local;

    final server = info.bankDetails;
    if (server != null) {
      await _store.save(key, server);
      await _store.markSynced(key);
      return server;
    }
    if (local == null) return null;
    if (await _store.isSynced(key)) {
      // Removed on the server (maybe from another phone) since we cached it.
      await _store.remove(key);
      return null;
    }
    // Saved only on this phone by an older app version — upload it once.
    try {
      await ref.read(brandingApiProvider).saveBankDetails(local);
      await _store.markSynced(key);
    } catch (e) {
      debugPrint('Bank details upload failed: $e');
    }
    return local;
  }

  Future<void> save(BankDetails details) async {
    state = await AsyncValue.guard(() async {
      await ref.read(brandingApiProvider).saveBankDetails(details);
      final key = tenantStorageKey(ref);
      await _store.save(key, details);
      await _store.markSynced(key);
      return details;
    });
    if (!state.hasError) ref.invalidate(brandingInfoProvider);
  }

  /// Throws if the server delete fails, leaving the details in place.
  Future<void> remove() async {
    await ref.read(brandingApiProvider).deleteBankDetails();
    await _store.remove(tenantStorageKey(ref));
    state = const AsyncData(null);
    ref.invalidate(brandingInfoProvider);
  }
}

final bankDetailsProvider = AsyncNotifierProvider<BankDetailsNotifier, BankDetails?>(BankDetailsNotifier.new);
