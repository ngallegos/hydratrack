import '../db/app_database.dart';
import '../repositories/mappers.dart';
import 'last_write_wins.dart';
import 'sync_snapshot.dart';

typedef RemoteWins = bool Function({
  required DateTime remoteUpdatedAt,
  required String remoteDeviceId,
  required DateTime localUpdatedAt,
  required String localDeviceId,
});

/// Reads and writes whole-database snapshots, bypassing the repositories so
/// remote records keep their original updatedAt and deviceId.
class SyncStore {
  SyncStore(this._db, {RemoteWins remoteWinsOver = remoteWins})
    : _remoteWins = remoteWinsOver;

  final AppDatabase _db;
  final RemoteWins _remoteWins;

  Future<SyncSnapshot> snapshot({
    required String deviceId,
    required DateTime now,
  }) async {
    final categories = await _db.select(_db.drinkCategories).get();
    final drinks = await _db.select(_db.drinks).get();
    final entries = await _db.select(_db.logEntries).get();
    return SyncSnapshot(
      deviceId: deviceId,
      generatedAt: now,
      categories: [for (final r in categories) r.toDomain()],
      drinks: [for (final r in drinks) r.toDomain()],
      entries: [for (final r in entries) r.toDomain()],
    );
  }

  /// Keeps the newer version of every record. Returns how many local rows
  /// were inserted or replaced.
  Future<int> apply(SyncSnapshot remote) => _db.transaction(() async {
    var changed = 0;

    final localCategories = {
      for (final r in await _db.select(_db.drinkCategories).get()) r.id: r,
    };
    for (final record in remote.categories) {
      final local = localCategories[record.id];
      if (local == null ||
          _remoteWins(
            remoteUpdatedAt: record.updatedAt,
            remoteDeviceId: record.deviceId,
            localUpdatedAt: local.updatedAt,
            localDeviceId: local.deviceId,
          )) {
        await _db
            .into(_db.drinkCategories)
            .insertOnConflictUpdate(record.toCompanion());
        changed++;
      }
    }

    final localDrinks = {
      for (final r in await _db.select(_db.drinks).get()) r.id: r,
    };
    for (final record in remote.drinks) {
      final local = localDrinks[record.id];
      if (local == null ||
          _remoteWins(
            remoteUpdatedAt: record.updatedAt,
            remoteDeviceId: record.deviceId,
            localUpdatedAt: local.updatedAt,
            localDeviceId: local.deviceId,
          )) {
        await _db.into(_db.drinks).insertOnConflictUpdate(record.toCompanion());
        changed++;
      }
    }

    final localEntries = {
      for (final r in await _db.select(_db.logEntries).get()) r.id: r,
    };
    for (final record in remote.entries) {
      final local = localEntries[record.id];
      if (local == null ||
          _remoteWins(
            remoteUpdatedAt: record.updatedAt,
            remoteDeviceId: record.deviceId,
            localUpdatedAt: local.updatedAt,
            localDeviceId: local.deviceId,
          )) {
        await _db
            .into(_db.logEntries)
            .insertOnConflictUpdate(record.toCompanion());
        changed++;
      }
    }

    return changed;
  });
}
