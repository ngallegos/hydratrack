import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/db/app_database.dart';
import 'package:hydratrack/data/repositories/category_repository.dart';
import 'package:hydratrack/data/repositories/log_repository.dart';
import 'package:hydratrack/data/sync/last_write_wins.dart';
import 'package:hydratrack/data/sync/sync_service.dart';
import 'package:hydratrack/data/sync/sync_store.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';

import '../../support/in_memory_sync_backend.dart';

// Independent of the remoteWins exercise so these tests stand on their own.
bool _referenceWins({
  required DateTime remoteUpdatedAt,
  required String remoteDeviceId,
  required DateTime localUpdatedAt,
  required String localDeviceId,
}) {
  final byTime = remoteUpdatedAt.compareTo(localUpdatedAt);
  if (byTime != 0) return byTime > 0;
  return remoteDeviceId.compareTo(localDeviceId) > 0;
}

class _Device {
  _Device(this.id, InMemorySyncBackend backend, {RemoteWins? wins})
    : db = AppDatabase(NativeDatabase.memory()) {
    categories = CategoryRepository(db, deviceId: id, clock: () => now);
    logs = LogRepository(db, deviceId: id, clock: () => now);
    service = SyncService(
      store: SyncStore(db, remoteWinsOver: wins ?? _referenceWins),
      backend: backend,
      deviceId: id,
      clock: () => now,
    );
  }

  final String id;
  final AppDatabase db;
  var now = DateTime.utc(2026, 11, 23, 9);
  late final CategoryRepository categories;
  late final LogRepository logs;
  late final SyncService service;

  Future<List<LogEntry>> entries() async => [
    for (final r in await db.select(db.logEntries).get())
      LogEntry(
        id: r.id,
        categoryId: r.categoryId,
        volumeMl: r.volumeMl,
        loggedAt: r.loggedAt,
        updatedAt: r.updatedAt,
        deviceId: r.deviceId,
        deleted: r.deleted,
      ),
  ];

  Future<void> addCategory(String id, String name) => categories.upsert(
    DrinkCategory(
      id: id,
      name: name,
      colorValue: 0xFF2196F3,
      hydrationFactor: 1,
      sortOrder: 0,
      updatedAt: now,
      deviceId: this.id,
    ),
  );

  Future<void> close() => db.close();
}

void main() {
  setUpAll(() {
    // Each simulated device has its own in-memory database, so the warning
    // about several AppDatabase instances sharing an executor doesn't apply.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  late InMemorySyncBackend backend;
  late _Device a;
  late _Device b;

  setUp(() {
    backend = InMemorySyncBackend();
    a = _Device('dev-a', backend);
    b = _Device('dev-b', backend);
  });

  tearDown(() async {
    await a.close();
    await b.close();
  });

  test('publishes the device state under its own file name', () async {
    await a.service.sync();

    expect(backend.files.keys, ['hydratrack-dev-a.json']);
  });

  test('an entry logged on one device appears on the other', () async {
    await a.addCategory('water', 'Water');
    final entry = await a.logs.add(categoryId: 'water', volumeMl: 250);
    await a.service.sync();

    final result = await b.service.sync();

    expect(result.recordsChanged, 2);
    expect((await b.entries()).single.id, entry.id);
  });

  test('syncing again with nothing new changes nothing', () async {
    await a.addCategory('water', 'Water');
    await a.logs.add(categoryId: 'water', volumeMl: 250);
    await a.service.sync();
    await b.service.sync();

    await a.service.sync();
    final second = await b.service.sync();

    expect(second.recordsChanged, 0);
  });

  test('a newer edit replaces the older copy', () async {
    await a.addCategory('water', 'Water');
    final entry = await a.logs.add(categoryId: 'water', volumeMl: 250);
    await a.service.sync();
    await b.service.sync();

    b.now = b.now.add(const Duration(minutes: 5));
    await b.logs.update(entry.copyWith(volumeMl: 400));
    await b.service.sync();
    await a.service.sync();

    expect((await a.entries()).single.volumeMl, 400);
  });

  test('an older remote edit does not overwrite a newer local one', () async {
    await a.addCategory('water', 'Water');
    final entry = await a.logs.add(categoryId: 'water', volumeMl: 250);
    await a.service.sync();
    await b.service.sync();

    b.now = b.now.add(const Duration(minutes: 1));
    await b.logs.update(entry.copyWith(volumeMl: 300));
    await b.service.sync();

    a.now = a.now.add(const Duration(minutes: 10));
    await a.logs.update(entry.copyWith(volumeMl: 500));
    await a.service.sync();

    expect((await a.entries()).single.volumeMl, 500);
    await b.service.sync();
    expect((await b.entries()).single.volumeMl, 500);
  });

  test('a delete propagates as a tombstone', () async {
    await a.addCategory('water', 'Water');
    final entry = await a.logs.add(categoryId: 'water', volumeMl: 250);
    await a.service.sync();
    await b.service.sync();

    b.now = b.now.add(const Duration(minutes: 1));
    await b.logs.softDelete(entry.id);
    await b.service.sync();
    await a.service.sync();

    expect((await a.entries()).single.deleted, isTrue);
  });

  test('concurrent changes to different records all survive', () async {
    await a.addCategory('water', 'Water');
    await a.service.sync();
    await b.service.sync();

    await a.logs.add(categoryId: 'water', volumeMl: 100);
    await b.logs.add(categoryId: 'water', volumeMl: 200);
    await a.service.sync();
    await b.service.sync();
    await a.service.sync();

    final aVolumes = (await a.entries()).map((e) => e.volumeMl).toSet();
    final bVolumes = (await b.entries()).map((e) => e.volumeMl).toSet();
    expect(aVolumes, {100, 200});
    expect(bVolumes, {100, 200});
  });

  test('three devices converge', () async {
    final c = _Device('dev-c', backend);
    addTearDown(c.close);
    await a.addCategory('water', 'Water');
    await a.logs.add(categoryId: 'water', volumeMl: 100);
    await a.service.sync();
    await b.service.sync();
    await b.logs.add(categoryId: 'water', volumeMl: 200);
    await b.service.sync();
    await c.service.sync();
    await c.logs.add(categoryId: 'water', volumeMl: 300);
    await c.service.sync();
    await a.service.sync();
    await b.service.sync();

    for (final device in [a, b, c]) {
      expect((await device.entries()).map((e) => e.volumeMl).toSet(), {
        100,
        200,
        300,
      });
    }
  });

  test(
    'skips corrupt and unrelated files and reports the corrupt one',
    () async {
      backend.files['hydratrack-broken.json'] = '{not json';
      backend.files['hydratrack-wrongshape.json'] = '[1, 2, 3]';
      backend.files['notes.txt'] = 'hello';
      await a.addCategory('water', 'Water');

      final result = await a.service.sync();

      expect(
        result.skippedFiles,
        unorderedEquals([
          'hydratrack-broken.json',
          'hydratrack-wrongshape.json',
        ]),
      );
      expect(backend.files.keys, contains('hydratrack-dev-a.json'));
    },
  );

  // Uses the real remoteWins: fails until the exercise in
  // lib/data/sync/last_write_wins.dart is implemented.
  test('works end to end with the real last-write-wins rule', () async {
    final real = _Device('dev-real', backend, wins: remoteWins);
    addTearDown(real.close);
    await a.addCategory('water', 'Water');
    await a.service.sync();
    await real.service.sync();
    a.now = a.now.add(const Duration(minutes: 5));
    await a.addCategory('water', 'Still water');
    await a.service.sync();

    await real.service.sync();

    final row = await (real.db.select(real.db.drinkCategories)).getSingle();
    expect(row.name, 'Still water');
  });
}
