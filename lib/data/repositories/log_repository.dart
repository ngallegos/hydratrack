import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/log_entry.dart';
import '../db/app_database.dart';
import 'mappers.dart';

class LogRepository {
  LogRepository(
    this._db, {
    required this.deviceId,
    DateTime Function()? clock,
    Uuid? uuid,
  }) : _now = clock ?? DateTime.now,
       _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final String deviceId;
  final DateTime Function() _now;
  final Uuid _uuid;

  Stream<List<LogEntry>> watchDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day + 1);
    final query = _db.select(_db.logEntries)
      ..where(
        (e) =>
            e.deleted.equals(false) &
            e.loggedAt.isBiggerOrEqualValue(start) &
            e.loggedAt.isSmallerThanValue(end),
      )
      ..orderBy([(e) => OrderingTerm.asc(e.loggedAt)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Stream<List<LogEntry>> watchSince(DateTime start) {
    final query = _db.select(_db.logEntries)
      ..where(
        (e) => e.deleted.equals(false) & e.loggedAt.isBiggerOrEqualValue(start),
      )
      ..orderBy([(e) => OrderingTerm.asc(e.loggedAt)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<LogEntry> add({
    required String categoryId,
    required int volumeMl,
    DateTime? at,
  }) async {
    final now = _now();
    final entry = LogEntry(
      id: _uuid.v4(),
      categoryId: categoryId,
      volumeMl: volumeMl,
      loggedAt: at ?? now,
      updatedAt: now,
      deviceId: deviceId,
    );
    await _db.into(_db.logEntries).insert(entry.toCompanion());
    return entry;
  }

  Future<void> update(LogEntry entry) {
    final stamped = entry.copyWith(updatedAt: _now(), deviceId: deviceId);
    return _db
        .into(_db.logEntries)
        .insertOnConflictUpdate(stamped.toCompanion());
  }

  Future<void> softDelete(String id) async {
    final row = await (_db.select(
      _db.logEntries,
    )..where((e) => e.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    await update(row.toDomain().copyWith(deleted: true));
  }

  Future<void> restore(String id) async {
    final row = await (_db.select(
      _db.logEntries,
    )..where((e) => e.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    await update(row.toDomain().copyWith(deleted: false));
  }
}
