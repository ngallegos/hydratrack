import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/directory_backend.dart';

void main() {
  late Directory root;
  late DirectoryBackend backend;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('hydratrack_sync_test');
    backend = DirectoryBackend(Directory('${root.path}/shared'));
  });

  tearDown(() => root.delete(recursive: true));

  test('lists nothing for a directory that does not exist yet', () async {
    expect(await backend.listFileNames(), isEmpty);
  });

  test('write creates the directory and read returns the contents', () async {
    await backend.write('hydratrack-a.json', '{"x":1}');

    expect(await backend.read('hydratrack-a.json'), '{"x":1}');
  });

  test('write replaces earlier contents and leaves no temp file', () async {
    await backend.write('hydratrack-a.json', 'old');
    await backend.write('hydratrack-a.json', 'new');

    expect(await backend.read('hydratrack-a.json'), 'new');
    expect(await backend.listFileNames(), ['hydratrack-a.json']);
    final all = Directory('${root.path}/shared').listSync().map((e) => e.path);
    expect(all.where((p) => p.endsWith('.tmp')), isEmpty);
  });

  test('read returns null for a missing file', () async {
    await backend.write('hydratrack-a.json', 'x');

    expect(await backend.read('hydratrack-b.json'), isNull);
  });

  test('lists only files, by name', () async {
    await backend.write('hydratrack-a.json', 'x');
    await backend.write('hydratrack-b.json', 'y');
    await Directory('${root.path}/shared/subdir').create();

    expect(
      await backend.listFileNames(),
      unorderedEquals(['hydratrack-a.json', 'hydratrack-b.json']),
    );
  });
}
