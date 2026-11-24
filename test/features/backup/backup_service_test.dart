import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/backup.dart';
import 'package:hydratrack/data/db/app_database.dart';
import 'package:hydratrack/data/repositories/category_repository.dart';
import 'package:hydratrack/data/repositories/log_repository.dart';
import 'package:hydratrack/data/sync/sync_store.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/features/backup/backup_service.dart';
import 'package:hydratrack/platform/file_transfer.dart';

// Independent of the remoteWins exercise.
bool _referenceWins({
  required DateTime remoteUpdatedAt,
  required String remoteDeviceId,
  required DateTime localUpdatedAt,
  required String localDeviceId,
}) {
  final byTime = remoteUpdatedAt.compareTo(localUpdatedAt);
  return byTime != 0 ? byTime > 0 : remoteDeviceId.compareTo(localDeviceId) > 0;
}

class _FakeTransfer implements FileTransfer {
  _FakeTransfer({this.pickResult, this.cancelSave = false});

  String? pickResult;
  final bool cancelSave;
  final saved = <({String name, String text, String mime})>[];

  @override
  Future<bool> saveText({
    required String fileName,
    required String text,
    required String mimeType,
  }) async {
    if (cancelSave) return false;
    saved.add((name: fileName, text: text, mime: mimeType));
    return true;
  }

  @override
  Future<String?> pickText({required List<String> extensions}) async =>
      pickResult;
}

class _Device {
  _Device(String id, this.transfer)
    : db = AppDatabase(NativeDatabase.memory()) {
    DateTime clock() => DateTime(2026, 11, 23, 9);
    categories = CategoryRepository(db, deviceId: id, clock: clock);
    logs = LogRepository(db, deviceId: id, clock: clock);
    store = SyncStore(db, remoteWinsOver: _referenceWins);
    service = BackupService(
      store: store,
      transfer: transfer,
      deviceId: id,
      clock: clock,
    );
  }

  final AppDatabase db;
  final _FakeTransfer transfer;
  late final CategoryRepository categories;
  late final LogRepository logs;
  late final SyncStore store;
  late final BackupService service;

  Future<void> seed() async {
    await categories.upsert(
      DrinkCategory(
        id: 'water',
        name: 'Water',
        colorValue: 0,
        hydrationFactor: 1,
        sortOrder: 0,
        updatedAt: DateTime.utc(2026),
        deviceId: 'x',
      ),
    );
    await logs.add(categoryId: 'water', volumeMl: 250);
  }
}

void main() {
  setUpAll(() {
    // Each simulated device has its own in-memory database, so the warning
    // about several AppDatabase instances sharing an executor doesn't apply.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  late _FakeTransfer transfer;
  late _Device device;

  setUp(() {
    transfer = _FakeTransfer();
    device = _Device('dev-1', transfer);
  });

  tearDown(() => device.db.close());

  test('exports a dated, parseable JSON backup', () async {
    await device.seed();

    final result = await device.service.exportBackup();

    expect(result, ExportResult.saved);
    final file = transfer.saved.single;
    expect(file.name, 'hydratrack-backup-20261123.json');
    expect(file.mime, 'application/json');
    final snapshot = parseBackup(file.text);
    expect(snapshot.entries.single.volumeMl, 250);
    expect(snapshot.categories.single.name, 'Water');
  });

  test('exports entries as CSV', () async {
    await device.seed();

    await device.service.exportCsv();

    final file = transfer.saved.single;
    expect(file.name, 'hydratrack-entries-20261123.csv');
    expect(file.mime, 'text/csv');
    expect(file.text.split('\n')[1], '2026-11-23,09:00,Water,250,250.0');
  });

  test('reports a cancelled save', () async {
    final cancelled = _Device('dev-2', _FakeTransfer(cancelSave: true));
    addTearDown(cancelled.db.close);

    expect(await cancelled.service.exportBackup(), ExportResult.cancelled);
    expect(await cancelled.service.exportCsv(), ExportResult.cancelled);
  });

  test('a backup restores into an empty device', () async {
    await device.seed();
    await device.service.exportBackup();

    final other = _Device(
      'dev-2',
      _FakeTransfer(pickResult: transfer.saved.single.text),
    );
    addTearDown(other.db.close);
    final changed = await other.service.importBackup();

    expect(changed, 2);
    final restored = await other.store.snapshot(
      deviceId: 'dev-2',
      now: DateTime(2026),
    );
    expect(restored.entries.single.volumeMl, 250);
  });

  test(
    'importing the same backup twice changes nothing the second time',
    () async {
      await device.seed();
      await device.service.exportBackup();
      final other = _Device(
        'dev-2',
        _FakeTransfer(pickResult: transfer.saved.single.text),
      );
      addTearDown(other.db.close);

      await other.service.importBackup();

      expect(await other.service.importBackup(), 0);
    },
  );

  test('an older backup does not overwrite newer local edits', () async {
    await device.seed();
    await device.service.exportBackup();
    final backupText = transfer.saved.single.text;

    final snapshot = await device.store.snapshot(
      deviceId: 'dev-1',
      now: DateTime(2026),
    );
    final entry = snapshot.entries.single;
    final later = LogRepository(
      device.db,
      deviceId: 'dev-1',
      clock: () => DateTime(2026, 11, 24),
    );
    await later.update(entry.copyWith(volumeMl: 999));

    device.transfer.pickResult = backupText;
    await device.service.importBackup();

    final after = await device.store.snapshot(
      deviceId: 'dev-1',
      now: DateTime(2026),
    );
    expect(after.entries.single.volumeMl, 999);
  });

  test('rejects a file that is not a backup', () async {
    device.transfer.pickResult = jsonEncode({'hello': 'world'});

    await expectLater(device.service.importBackup(), throwsFormatException);
  });

  test('returns null when the picker is cancelled', () async {
    expect(await device.service.importBackup(), isNull);
  });
}
