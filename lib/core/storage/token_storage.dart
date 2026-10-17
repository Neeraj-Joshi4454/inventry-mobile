import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

/// Thin wrapper around [FlutterSecureStorage] for auth tokens. Unlike a
/// browser, a mobile device's secure storage (Keychain on iOS, AES-GCM/RSA-
/// OAEP-encrypted Keystore-backed storage on Android by default) isn't
/// exposed to arbitrary script injection the way `localStorage` is — so,
/// unlike a web client, it's reasonable to persist both the access and
/// refresh tokens here rather than keeping the access token memory-only.
class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<String?> getAccessToken() => _storage.read(key: StorageKeys.accessToken);

  Future<String?> getRefreshToken() => _storage.read(key: StorageKeys.refreshToken);

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: StorageKeys.accessToken, value: accessToken);
    await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) => _storage.write(key: StorageKeys.accessToken, value: accessToken);

  Future<void> clear() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
}
