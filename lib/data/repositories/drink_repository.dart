import 'package:drift/drift.dart';

import '../../domain/drink.dart';
import '../db/app_database.dart';
import 'mappers.dart';

class DrinkRepository {
  DrinkRepository(
    this._db, {
    required this.deviceId,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final String deviceId;
  final DateTime Function() _now;

  Stream<List<Drink>> watchAll() {
    final query = _db.select(_db.drinks)
      ..where((d) => d.deleted.equals(false))
      ..orderBy([(d) => OrderingTerm.asc(d.name)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Stream<List<Drink>> watchStarred() {
    final query = _db.select(_db.drinks)
      ..where((d) => d.deleted.equals(false) & d.starred.equals(true))
      ..orderBy([(d) => OrderingTerm.asc(d.name)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<Drink?> findById(String id) async {
    final row = await (_db.select(
      _db.drinks,
    )..where((d) => d.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<void> upsert(Drink drink) {
    final stamped = drink.copyWith(updatedAt: _now(), deviceId: deviceId);
    return _db.into(_db.drinks).insertOnConflictUpdate(stamped.toCompanion());
  }

  Future<void> setStarred(String id, {required bool starred}) async {
    final existing = await findById(id);
    if (existing == null) return;
    await upsert(existing.copyWith(starred: starred));
  }

  Future<void> softDelete(String id) async {
    final existing = await findById(id);
    if (existing == null) return;
    await upsert(existing.copyWith(deleted: true));
  }

  Future<void> insertMissing(List<Drink> defaults) async {
    await _db.batch((batch) {
      batch.insertAll(_db.drinks, [
        for (final d in defaults) d.toCompanion(),
      ], mode: InsertMode.insertOrIgnore);
    });
  }
}
