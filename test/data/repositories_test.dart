import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/db/app_database.dart';
import 'package:hydratrack/data/repositories/category_repository.dart';
import 'package:hydratrack/data/repositories/drink_repository.dart';
import 'package:hydratrack/data/repositories/log_repository.dart';
import 'package:hydratrack/data/seed.dart';

void main() {
  late AppDatabase db;
  late CategoryRepository categories;
  late DrinkRepository drinks;
  late LogRepository logs;
  var clockNow = DateTime(2026, 11, 23, 9);

  setUp(() async {
    clockNow = DateTime(2026, 11, 23, 9);
    db = AppDatabase(NativeDatabase.memory());
    categories = CategoryRepository(db, deviceId: 'dev', clock: () => clockNow);
    drinks = DrinkRepository(db, deviceId: 'dev', clock: () => clockNow);
    logs = LogRepository(db, deviceId: 'dev', clock: () => clockNow);
    await seedDefaults(categories, drinks);
  });

  tearDown(() => db.close());

  group('seed', () {
    test('creates default categories ordered by sortOrder', () async {
      final all = await categories.watchAll().first;

      expect(all.map((c) => c.id).first, 'water');
      expect(all.length, defaultCategories.length);
    });

    test('is idempotent and does not overwrite user edits', () async {
      final water = (await categories.findById('water'))!;
      await categories.upsert(water.copyWith(name: 'H2O'));

      await seedDefaults(categories, drinks);

      expect((await categories.findById('water'))!.name, 'H2O');
      expect(
        (await categories.watchAll().first).length,
        defaultCategories.length,
      );
    });

    test('stars the default quick drinks', () async {
      final starred = await drinks.watchStarred().first;

      expect(
        starred.map((d) => d.id),
        containsAll(['water-glass', 'coffee-mug']),
      );
      expect(starred.any((d) => d.id == 'tea-cup'), isFalse);
    });
  });

  group('CategoryRepository', () {
    test('upsert stamps updatedAt and deviceId', () async {
      clockNow = DateTime(2026, 12, 1);
      final water = (await categories.findById('water'))!;

      await categories.upsert(water.copyWith(hydrationFactor: 0.95));

      final saved = (await categories.findById('water'))!;
      expect(saved.hydrationFactor, 0.95);
      expect(saved.updatedAt, clockNow);
      expect(saved.deviceId, 'dev');
    });

    test('softDelete hides the category but keeps the tombstone', () async {
      await categories.softDelete('wine');

      final visible = await categories.watchAll().first;
      expect(visible.any((c) => c.id == 'wine'), isFalse);
      expect((await categories.findById('wine'))!.deleted, isTrue);
    });
  });

  group('DrinkRepository', () {
    test('setStarred toggles quick-log membership', () async {
      await drinks.setStarred('tea-cup', starred: true);
      await drinks.setStarred('water-glass', starred: false);

      final ids = (await drinks.watchStarred().first).map((d) => d.id);
      expect(ids, contains('tea-cup'));
      expect(ids, isNot(contains('water-glass')));
    });

    test('softDelete removes drink from lists', () async {
      await drinks.softDelete('tea-cup');

      expect(
        (await drinks.watchAll().first).any((d) => d.id == 'tea-cup'),
        isFalse,
      );
    });
  });

  group('LogRepository', () {
    test('add then watchDay returns entries for that local day only', () async {
      await logs.add(categoryId: 'water', volumeMl: 250);
      await logs.add(
        categoryId: 'coffee',
        volumeMl: 240,
        at: DateTime(2026, 11, 22, 23, 59),
      );
      await logs.add(
        categoryId: 'water',
        volumeMl: 500,
        at: DateTime(2026, 11, 24),
      );

      final today = await logs.watchDay(DateTime(2026, 11, 23)).first;

      expect(today.length, 1);
      expect(today.single.volumeMl, 250);
      expect(today.single.deviceId, 'dev');
    });

    test('watchSince returns live entries from the start day onward', () async {
      await logs.add(
        categoryId: 'water',
        volumeMl: 100,
        at: DateTime(2026, 11, 1),
      );
      await logs.add(
        categoryId: 'water',
        volumeMl: 200,
        at: DateTime(2026, 11, 20),
      );
      final deleted = await logs.add(
        categoryId: 'water',
        volumeMl: 300,
        at: DateTime(2026, 11, 21),
      );
      await logs.softDelete(deleted.id);

      final entries = await logs.watchSince(DateTime(2026, 11, 10)).first;

      expect(entries.map((e) => e.volumeMl), [200]);
    });

    test('softDelete supports undo via restore', () async {
      final entry = await logs.add(categoryId: 'water', volumeMl: 250);

      await logs.softDelete(entry.id);
      expect(await logs.watchDay(clockNow).first, isEmpty);

      await logs.restore(entry.id);
      expect((await logs.watchDay(clockNow).first).single.id, entry.id);
    });

    test('update bumps updatedAt for last-write-wins sync', () async {
      final entry = await logs.add(categoryId: 'water', volumeMl: 250);
      clockNow = DateTime(2026, 11, 23, 10);

      await logs.update(entry.copyWith(volumeMl: 300));

      final saved = (await logs.watchDay(clockNow).first).single;
      expect(saved.volumeMl, 300);
      expect(saved.updatedAt, clockNow);
    });

    test('watchDay emits when entries are added', () async {
      final emissions = <int>[];
      final sub = logs
          .watchDay(clockNow)
          .listen((e) => emissions.add(e.length));

      await pumpEventQueue();
      await logs.add(categoryId: 'water', volumeMl: 250);
      await pumpEventQueue();
      await sub.cancel();

      expect(emissions, [0, 1]);
    });
  });
}
