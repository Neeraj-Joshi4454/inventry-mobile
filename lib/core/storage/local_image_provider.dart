import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import 'local_image_store.dart';
import 'tenant_storage_key.dart';

/// The current business's locally stored image in a given folder
/// (null = not set). Shared by the UPI QR and the business logo.
class LocalImageNotifier extends FamilyAsyncNotifier<File?, String> {
  LocalImageStore get _store => LocalImageStore(folder: arg);

  String get _tenantKey => tenantStorageKey(ref);

  @override
  Future<File?> build(String folder) {
    // Re-read when the signed-in account changes.
    ref.watch(authNotifierProvider);
    return _store.load(_tenantKey);
  }

  Future<void> save(File picked) async {
    state = const AsyncLoading<File?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _store.save(_tenantKey, picked));
  }

  Future<void> remove() async {
    await _store.remove(_tenantKey);
    state = const AsyncData(null);
  }
}

final localImageProvider = AsyncNotifierProvider.family<LocalImageNotifier, File?, String>(LocalImageNotifier.new);

/// The UPI QR customers scan on New Sale.
final upiQrProvider = localImageProvider('upi_qr');

/// The business logo printed on invoices.
final businessLogoProvider = localImageProvider('business_logo');
