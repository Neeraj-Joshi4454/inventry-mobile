import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bank_details.dart';

/// Keeps bank details on this device only, in the platform's encrypted
/// secure storage (Keychain / Android Keystore) — never sent to a server.
/// One entry per business.
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
}
