import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/branding/data/branding_api.dart';
import '../../features/branding/providers/branding_providers.dart';
import 'local_image_store.dart';
import 'tenant_storage_key.dart';

/// The current business's image in a given folder (null = not set). Shared
/// by the UPI QR and the business logo.
///
/// The server is the source of truth, so the image is the same on every
/// phone and survives reinstalling the app; the on-device file is a cache
/// that's used as-is when offline. [folder] doubles as the server's image
/// kind ('upi_qr' / 'business_logo').
class LocalImageNotifier extends FamilyAsyncNotifier<File?, String> {
  LocalImageStore get _store => LocalImageStore(folder: arg);

  String get _tenantKey => tenantStorageKey(ref);

  @override
  Future<File?> build(String folder) async {
    // Re-read when the signed-in account changes.
    ref.watch(authNotifierProvider);
    final key = _tenantKey;
    final local = await _store.load(key);

    final BrandingInfo? info;
    try {
      info = await ref.watch(brandingInfoProvider.future);
    } catch (_) {
      return local; // offline — show the cached copy
    }
    if (info == null) return local;

    final serverStamp = info.imageUpdatedAt[folder];
    if (serverStamp == null) {
      if (local == null) return null;
      if (await _store.isSynced(key)) {
        // Removed on the server (maybe from another phone) since we cached it.
        await _store.remove(key);
        return null;
      }
      // Saved only on this phone by an older app version — upload it once.
      try {
        final updatedAt = await _upload(local);
        await _store.markSynced(key);
        return _store.save(key, local, stamp: updatedAt);
      } catch (e) {
        debugPrint('Image upload ($folder) failed: $e');
        return local;
      }
    }

    if (local != null && _store.stampOf(key, local)?.millisecondsSinceEpoch == serverStamp.millisecondsSinceEpoch) {
      await _store.markSynced(key);
      return local;
    }
    try {
      final bytes = await ref.read(brandingApiProvider).downloadImage(folder);
      final saved = await _store.saveBytes(key, bytes, ext: _extensionOf(bytes), stamp: serverStamp);
      await _store.markSynced(key);
      return saved;
    } catch (e) {
      debugPrint('Image download ($folder) failed: $e');
      return local;
    }
  }

  Future<void> save(File picked) async {
    state = const AsyncLoading<File?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final updatedAt = await _upload(picked);
      final key = _tenantKey;
      await _store.markSynced(key);
      return _store.save(key, picked, stamp: updatedAt);
    });
    if (!state.hasError) ref.invalidate(brandingInfoProvider);
  }

  /// Throws if the server delete fails, leaving the image in place.
  Future<void> remove() async {
    await ref.read(brandingApiProvider).deleteImage(arg);
    await _store.remove(_tenantKey);
    state = const AsyncData(null);
    ref.invalidate(brandingInfoProvider);
  }

  Future<DateTime> _upload(File file) async {
    final bytes = await file.readAsBytes();
    return ref.read(brandingApiProvider).uploadImage(arg, bytes, _contentTypeOf(file.path));
  }

  static String _contentTypeOf(String path) => switch (path.split('.').last.toLowerCase()) {
    'png' => 'image/png',
    'webp' => 'image/webp',
    'gif' => 'image/gif',
    _ => 'image/jpeg',
  };

  /// File extension from the image's magic bytes (the download carries no
  /// filename).
  static String _extensionOf(Uint8List bytes) {
    if (bytes.length > 3 && bytes[0] == 0x89 && bytes[1] == 0x50) return 'png';
    if (bytes.length > 3 && bytes[0] == 0x47 && bytes[1] == 0x49) return 'gif';
    if (bytes.length > 11 && bytes[8] == 0x57 && bytes[9] == 0x45) return 'webp';
    return 'jpg';
  }
}

final localImageProvider = AsyncNotifierProvider.family<LocalImageNotifier, File?, String>(LocalImageNotifier.new);

/// The UPI QR customers scan on New Sale.
final upiQrProvider = localImageProvider('upi_qr');

/// The business logo printed on invoices.
final businessLogoProvider = localImageProvider('business_logo');
