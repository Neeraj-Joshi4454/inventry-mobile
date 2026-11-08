import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bank_details.dart';

/// On-device copy of the bank details, in the platform's encrypted secure
/// storage (Keychain / Android Keystore). The server holds the real copy
/// (see bank_details_provider.dart); this is the offline cache. One entry
/// per business.
class BankDetailsStore {
  BankDetailsStore({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  String _key(String tenantKey) => 'bank_details_$tenantKey';

  Future<BankDetails?> load(String tenantKey) async {
    final raw = await _storage.read(key: _key(tenantKey));
    if (raw == null) return null;
    try {
      return BankDetails.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on FormatException {
      return null;
    }
  }

  Future<void> save(String tenantKey, BankDetails details) =>
      _storage.write(key: _key(tenantKey), value: jsonEncode(details.toJson()));

  Future<void> remove(String tenantKey) => _storage.delete(key: _key(tenantKey));

  String _syncedKey(String tenantKey) => 'bank_details_synced_$tenantKey';

  /// Whether this business's details have ever been in step with the
  /// server — see LocalImageStore.isSynced for why this matters.
  Future<bool> isSynced(String tenantKey) async => await _storage.read(key: _syncedKey(tenantKey)) != null;

  Future<void> markSynced(String tenantKey) => _storage.write(key: _syncedKey(tenantKey), value: '1');
}
