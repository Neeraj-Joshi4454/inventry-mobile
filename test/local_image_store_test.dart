import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/core/storage/local_image_store.dart';

void main() {
  late Directory root;
  late LocalImageStore store;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('upi_qr_test');
    store = LocalImageStore(folder: 'upi_qr', baseDirectory: () async => root);
  });

  tearDown(() => root.delete(recursive: true));

  Future<File> image(String name, String content) => File('${root.path}/$name').writeAsString(content);

  test('save copies into app storage, replace swaps it, remove clears it', () async {
    expect(await store.load('t1'), isNull);

    final first = await store.save('t1', await image('a.png', 'first'));
    expect(await (await store.load('t1'))!.readAsString(), 'first');

    await Future<void>.delayed(const Duration(milliseconds: 2));
    final second = await store.save('t1', await image('b.jpg', 'second'));
    final loaded = (await store.load('t1'))!;
    expect(loaded.path, second.path);
    expect(loaded.path, isNot(first.path)); // new path, so no stale image cache
    expect(await first.exists(), isFalse); // old copy deleted
    expect(await loaded.readAsString(), 'second');

    await store.remove('t1');
    expect(await store.load('t1'), isNull);
  });

  test('each business keeps its own QR', () async {
    await store.save('tenantA', await image('a.png', 'A'));
    await store.save('tenantB', await image('b.png', 'B'));
    expect(await (await store.load('tenantA'))!.readAsString(), 'A');
    expect(await (await store.load('tenantB'))!.readAsString(), 'B');

    await store.remove('tenantA');
    expect(await store.load('tenantA'), isNull);
    expect(await (await store.load('tenantB'))!.readAsString(), 'B');
  });

  test('a server copy keeps the server timestamp, so the cache knows it is current', () async {
    final serverStamp = DateTime.utc(2026, 11, 8, 10, 30);
    final saved = await store.saveBytes('t1', Uint8List.fromList([1, 2, 3]), ext: 'png', stamp: serverStamp);
    expect(store.stampOf('t1', saved)!.millisecondsSinceEpoch, serverStamp.millisecondsSinceEpoch);
    expect(await (await store.load('t1'))!.readAsBytes(), [1, 2, 3]);
  });

  test('sync marker is per business and survives replacing the image', () async {
    expect(await store.isSynced('tenantA'), isFalse);
    await store.markSynced('tenantA');
    await store.save('tenantA', await image('a.png', 'A'));
    expect(await store.isSynced('tenantA'), isTrue);
    expect(await store.isSynced('tenantB'), isFalse);
    // The marker is never mistaken for the image itself.
    expect(await (await store.load('tenantA'))!.readAsString(), 'A');
  });
}
