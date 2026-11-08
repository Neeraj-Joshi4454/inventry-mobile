import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// On-device copy of a business image (UPI QR, logo, ...) in the app's
/// private documents directory under [folder]. The server holds the real
/// copy (see local_image_provider.dart); this is the offline cache. One
/// image per business (tenant) per folder, so switching accounts on a
/// shared phone never shows another business's image.
///
/// Each save writes a new timestamped file and deletes the old one, so the
/// path changes on replace and Flutter's image cache can't show a stale QR.
/// When the image came from the server, the timestamp is the server's
/// updatedAt, which is how the cache knows whether it's current.
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
  /// previous image for this business. [stamp] defaults to now.
  Future<File> save(String tenantKey, File source, {DateTime? stamp}) async {
    final ext = source.path.contains('.') ? source.path.split('.').last.toLowerCase() : 'jpg';
    return _replace(tenantKey, ext, stamp, (path) => source.copy(path));
  }

  /// Writes downloaded image [bytes], replacing any previous image.
  Future<File> saveBytes(String tenantKey, Uint8List bytes, {required String ext, required DateTime stamp}) =>
      _replace(tenantKey, ext, stamp, (path) => File(path).writeAsBytes(bytes, flush: true));

  Future<File> _replace(String tenantKey, String ext, DateTime? stamp, Future<File> Function(String path) write) async {
    final dir = await _dir();
    final millis = (stamp ?? DateTime.now()).millisecondsSinceEpoch.toString().padLeft(16, '0');
    final previous = await _filesFor(tenantKey);
    final saved = await write('${dir.path}/${_prefix(tenantKey)}$millis.$ext');
    for (final old in previous) {
      if (old.path != saved.path && await old.exists()) await old.delete();
    }
    return saved;
  }

  /// The timestamp a cached file was saved under (see [save]/[saveBytes]).
  DateTime? stampOf(String tenantKey, File file) {
    final name = file.uri.pathSegments.last;
    final prefix = _prefix(tenantKey);
    if (!name.startsWith(prefix)) return null;
    final millis = int.tryParse(name.substring(prefix.length).split('.').first);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  File _syncedMarker(Directory dir, String tenantKey) => File('${dir.path}/.synced_${_prefix(tenantKey)}');

  /// Whether this business's image has ever been in step with the server.
  /// Before that, a local image with nothing on the server is one saved by
  /// an older app version and gets uploaded; after it, it means the image
  /// was removed (possibly on another phone) and the local copy is dropped.
  Future<bool> isSynced(String tenantKey) async => _syncedMarker(await _dir(), tenantKey).exists();

  Future<void> markSynced(String tenantKey) async {
    final marker = _syncedMarker(await _dir(), tenantKey);
    if (!await marker.exists()) await marker.create();
  }

  Future<void> remove(String tenantKey) async {
    for (final file in await _filesFor(tenantKey)) {
      if (await file.exists()) await file.delete();
    }
  }
}
