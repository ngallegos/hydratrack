import 'package:drift/drift.dart';

import '../../domain/drink_category.dart';
import '../db/app_database.dart';
import 'mappers.dart';

class CategoryRepository {
  CategoryRepository(
    this._db, {
    required this.deviceId,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final String deviceId;
  final DateTime Function() _now;

  Stream<List<DrinkCategory>> watchAll() {
    final query = _db.select(_db.drinkCategories)
      ..where((c) => c.deleted.equals(false))
      ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<DrinkCategory?> findById(String id) async {
    final row = await (_db.select(
      _db.drinkCategories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<void> upsert(DrinkCategory category) {
    final stamped = category.copyWith(updatedAt: _now(), deviceId: deviceId);
    return _db
        .into(_db.drinkCategories)
        .insertOnConflictUpdate(stamped.toCompanion());
  }

  Future<void> softDelete(String id) async {
    final existing = await findById(id);
    if (existing == null) return;
    await upsert(existing.copyWith(deleted: true));
  }

  Future<void> insertMissing(List<DrinkCategory> defaults) async {
    await _db.batch((batch) {
      batch.insertAll(_db.drinkCategories, [
        for (final c in defaults) c.toCompanion(),
      ], mode: InsertMode.insertOrIgnore);
    });
  }
}
