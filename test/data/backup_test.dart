import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/backup.dart';
import 'package:hydratrack/data/sync/sync_snapshot.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';

final _stamp = DateTime.utc(2026);

DrinkCategory _category(String id, String name, double factor) => DrinkCategory(
  id: id,
  name: name,
  colorValue: 0,
  hydrationFactor: factor,
  sortOrder: 0,
  updatedAt: _stamp,
  deviceId: 't',
);

LogEntry _entry(String category, int ml, DateTime at, {bool deleted = false}) =>
    LogEntry(
      id: '$category$ml${at.hour}',
      categoryId: category,
      volumeMl: ml,
      loggedAt: at,
      updatedAt: _stamp,
      deviceId: 't',
      deleted: deleted,
    );

void main() {
  group('backup JSON', () {
    test('round-trips a snapshot', () {
      final snapshot = SyncSnapshot(
        deviceId: 'd',
        generatedAt: _stamp,
        categories: [_category('water', 'Water', 1)],
        entries: [_entry('water', 250, DateTime.utc(2026, 11, 23, 9))],
      );

      expect(parseBackup(backupToJson(snapshot)), snapshot);
    });

    test('rejects text that is not a backup', () {
      for (final text in ['', 'hello', '[1,2]', '{"deviceId": 5}']) {
        expect(
          () => parseBackup(text),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              'This file is not a HydraTrack backup',
            ),
          ),
          reason: text,
        );
      }
    });
  });

  group('entriesToCsv', () {
    final categories = {
      'water': _category('water', 'Water', 1),
      'coffee': _category('coffee', 'Coffee, black "dark"', 0.8),
    };

    test('writes a header and one sorted row per live entry', () {
      final csv = entriesToCsv([
        _entry('coffee', 200, DateTime(2026, 11, 23, 14, 5)),
        _entry('water', 500, DateTime(2026, 11, 23, 8, 30)),
        _entry('water', 100, DateTime(2026, 11, 23, 9), deleted: true),
      ], categories);

      expect(csv.split('\n'), [
        'date,time,category,volume_ml,effective_ml',
        '2026-11-23,08:30,Water,500,500.0',
        '2026-11-23,14:05,"Coffee, black ""dark""",200,160.0',
        '',
      ]);
    });

    test('falls back to the category id when the category is unknown', () {
      final csv = entriesToCsv([
        _entry('mystery', 300, DateTime(2026, 1, 2, 3, 4)),
      ], categories);

      expect(csv.split('\n')[1], '2026-01-02,03:04,mystery,300,');
    });

    test('is just the header for no entries', () {
      expect(
        entriesToCsv([], categories),
        'date,time,category,volume_ml,effective_ml\n',
      );
    });
  });
}
