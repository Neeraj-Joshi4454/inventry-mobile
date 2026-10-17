import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Keeps a business image (UPI QR, logo, ...) on the device only — in the
/// app's private documents directory under [folder], never uploaded
/// anywhere. One image per business (tenant) per folder, so switching
/// accounts on a shared phone never shows another business's image.
///
/// Each save writes a new timestamped file and deletes the old one, so the
/// path changes on replace and Flutter's image cache can't show a stale QR.
class LocalImageStore {
  const LocalImageStore({required this.folder, this.baseDirectory});

  /// Subfolder for this kind of image, e.g. 'upi_qr' or 'business_logo'.
  final String folder;

  /// Override for tests; defaults to the app's private documents directory.
  final Future<Directory> Function()? baseDirectory;

  Future<Directory> _dir() async {
    final docs = await (baseDirectory ?? getApplicationDocumentsDirectory)();
    final dir = Directory('${docs.path}/$folder');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  String _prefix(String tenantKey) => 'qr_${tenantKey.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_')}_';

  Future<List<File>> _filesFor(String tenantKey) async {
    final dir = await _dir();
    final prefix = _prefix(tenantKey);
    return dir.listSync().whereType<File>().where((f) => f.uri.pathSegments.last.startsWith(prefix)).toList();
  }

  /// The saved image for this business, or null if none has been uploaded.
  Future<File?> load(String tenantKey) async {
    final files = await _filesFor(tenantKey);
    if (files.isEmpty) return null;
    files.sort((a, b) => b.path.compareTo(a.path)); // newest timestamp first
    return files.first;
  }

  /// Copies [source] (a picked image) into app storage, replacing any
  /// previous image for this business.
  Future<File> save(String tenantKey, File source) async {
    final dir = await _dir();
    final ext = source.path.contains('.') ? source.path.split('.').last.toLowerCase() : 'jpg';
    final stamp = DateTime.now().millisecondsSinceEpoch.toString().padLeft(16, '0');
    final previous = await _filesFor(tenantKey);
    final saved = await source.copy('${dir.path}/${_prefix(tenantKey)}$stamp.$ext');
    for (final old in previous) {
      if (await old.exists()) await old.delete();
    }
    return saved;
  }

  Future<void> remove(String tenantKey) async {
    for (final file in await _filesFor(tenantKey)) {
      if (await file.exists()) await file.delete();
    }
  }
}
