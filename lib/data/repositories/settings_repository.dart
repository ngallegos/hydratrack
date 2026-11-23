import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  static const deviceIdKey = 'deviceId';

  final AppDatabase _db;

  Future<String?> get(String key) async {
    final row = await (_db.select(
      _db.settings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Stream<Map<String, String>> watchAll() => _db
      .select(_db.settings)
      .watch()
      .map((rows) => {for (final row in rows) row.key: row.value});

  Future<void> setMany(Map<String, String> values) => _db.batch((batch) {
    batch.insertAllOnConflictUpdate(_db.settings, [
      for (final entry in values.entries)
        SettingsCompanion.insert(key: entry.key, value: entry.value),
    ]);
  });

  Future<void> set(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));

  Future<String> loadOrCreateDeviceId() async {
    final existing = await get(deviceIdKey);
    if (existing != null) return existing;
    final created = const Uuid().v4();
    await set(deviceIdKey, created);
    return created;
  }
}
