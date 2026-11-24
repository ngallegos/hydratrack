import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/drive_backend.dart';
import 'package:hydratrack/data/sync/drive_files.dart';

class _FakeDriveFiles implements DriveFiles {
  final contents = <String, String>{};
  final names = <String, String>{};
  final calls = <String>[];
  var _nextId = 1;

  @override
  Future<Map<String, String>> list() async => Map.of(names);

  @override
  Future<String> download(String id) async => contents[id]!;

  @override
  Future<void> create(String name, String text) async {
    calls.add('create $name');
    final id = 'id${_nextId++}';
    names[name] = id;
    contents[id] = text;
  }

  @override
  Future<void> update(String id, String text) async {
    calls.add('update $id');
    contents[id] = text;
  }
}

void main() {
  late _FakeDriveFiles files;
  late DriveBackend backend;

  setUp(() {
    files = _FakeDriveFiles();
    backend = DriveBackend(() async => files);
  });

  test('first write creates the file, later writes update it', () async {
    await backend.write('hydratrack-a.json', 'one');
    await backend.write('hydratrack-a.json', 'two');

    expect(files.calls, ['create hydratrack-a.json', 'update id1']);
    expect(await backend.read('hydratrack-a.json'), 'two');
  });

  test('lists file names', () async {
    await backend.write('hydratrack-a.json', 'x');
    await backend.write('hydratrack-b.json', 'y');

    expect(
      await backend.listFileNames(),
      unorderedEquals(['hydratrack-a.json', 'hydratrack-b.json']),
    );
  });

  test('read returns null for a file that does not exist', () async {
    expect(await backend.read('hydratrack-missing.json'), isNull);
  });

  test('fails with a clear exception when signed out', () async {
    final signedOut = DriveBackend(() async => null);

    await expectLater(
      signedOut.listFileNames(),
      throwsA(isA<DriveNotSignedIn>()),
    );
    await expectLater(signedOut.read('x'), throwsA(isA<DriveNotSignedIn>()));
    await expectLater(
      signedOut.write('x', 'y'),
      throwsA(isA<DriveNotSignedIn>()),
    );
  });

  test('DriveNotSignedIn is an Exception so sync reports it', () {
    expect(const DriveNotSignedIn(), isA<Exception>());
    expect(const DriveNotSignedIn().toString(), contains('Google Drive'));
  });
}
