import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/tenant_storage_key.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/bank_details.dart';
import '../data/bank_details_store.dart';

final bankDetailsStoreProvider = Provider<BankDetailsStore>((ref) => BankDetailsStore());

/// This business's bank details saved on this phone (null = not set).
class BankDetailsNotifier extends AsyncNotifier<BankDetails?> {
  @override
  Future<BankDetails?> build() {
    ref.watch(authNotifierProvider); // reload when the account changes
    return ref.read(bankDetailsStoreProvider).load(tenantStorageKey(ref));
  }

  Future<void> save(BankDetails details) async {
    state = await AsyncValue.guard(() async {
      await ref.read(bankDetailsStoreProvider).save(tenantStorageKey(ref), details);
      return details;
    });
  }

  Future<void> remove() async {
    await ref.read(bankDetailsStoreProvider).remove(tenantStorageKey(ref));
    state = const AsyncData(null);
  }
}

final bankDetailsProvider = AsyncNotifierProvider<BankDetailsNotifier, BankDetails?>(BankDetailsNotifier.new);
