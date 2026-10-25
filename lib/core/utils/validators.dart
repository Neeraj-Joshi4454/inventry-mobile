/// Lightweight, UI-side validation only — the backend remains authoritative
/// (it normalizes and re-validates the mobile number, and enforces the real
/// password policy). This just catches obviously-empty/malformed input
/// before making a network call.
class Validators {
  Validators._();

  static final RegExp _mobilePattern = RegExp(r'^[6-9]\d{9}$');

  static String? mobileNumber(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Enter your mobile number';
    final digitsOnly = trimmed.replaceAll(RegExp(r'\D'), '');
    final normalized = digitsOnly.length == 12 && digitsOnly.startsWith('91') ? digitsOnly.substring(2) : digitsOnly;
    if (!_mobilePattern.hasMatch(normalized)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Enter your password';
    return null;
  }

  /// For choosing a password (registration) — mirrors the backend's
  /// minimum length; the backend still rejects common weak passwords.
  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) return 'Choose a password';
    if (value.length < 8) return 'Use at least 8 characters';
    return null;
  }
}
