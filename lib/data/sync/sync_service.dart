import 'dart:convert';

import 'sync_backend.dart';
import 'sync_snapshot.dart';
import 'sync_store.dart';

class SyncResult {
  const SyncResult({required this.recordsChanged, required this.skippedFiles});

  final int recordsChanged;
  final List<String> skippedFiles;
}

class SyncService {
  SyncService({
    required this.store,
    required this.backend,
    required this.deviceId,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final SyncStore store;
  final SyncBackend backend;
  final String deviceId;
  final DateTime Function() _now;

  static const _prefix = 'hydratrack-';
  static const _suffix = '.json';

  static String fileNameFor(String deviceId) => '$_prefix$deviceId$_suffix';

  static bool _isSnapshotFile(String name) =>
      name.startsWith(_prefix) && name.endsWith(_suffix);

  Future<SyncSnapshot?> _readSnapshot(String name) async {
    final text = await backend.read(name);
    if (text == null) return null;
    try {
      return SyncSnapshot.fromJson(jsonDecode(text) as Map<String, dynamic>);
    } on Exception {
      return null;
    } on TypeError {
      return null;
    }
  }

  /// Merges every other device's snapshot into the local database, then
  /// publishes this device's full state under its own file name.
  Future<SyncResult> sync() async {
    final ownName = fileNameFor(deviceId);
    var changed = 0;
    final skipped = <String>[];

    final names = await backend.listFileNames();
    for (final name in names.where(_isSnapshotFile)) {
      if (name == ownName) continue;
      final snapshot = await _readSnapshot(name);
      if (snapshot == null) {
        skipped.add(name);
        continue;
      }
      changed += await store.apply(snapshot);
    }

    final own = await store.snapshot(deviceId: deviceId, now: _now());
    await backend.write(ownName, jsonEncode(own.toJson()));

    return SyncResult(recordsChanged: changed, skippedFiles: skipped);
  }
}
