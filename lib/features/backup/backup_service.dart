import '../../data/backup.dart';
import '../../data/sync/sync_store.dart';
import '../../domain/drink_category.dart';
import '../../platform/file_transfer.dart';

enum ExportResult { saved, cancelled }

class BackupService {
  BackupService({
    required this.store,
    required this.transfer,
    required this.deviceId,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final SyncStore store;
  final FileTransfer transfer;
  final String deviceId;
  final DateTime Function() _now;

  String _stamp() {
    final t = _now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${t.year}${two(t.month)}${two(t.day)}';
  }

  Future<ExportResult> exportBackup() async {
    final snapshot = await store.snapshot(deviceId: deviceId, now: _now());
    final saved = await transfer.saveText(
      fileName: 'hydratrack-backup-${_stamp()}.json',
      text: backupToJson(snapshot),
      mimeType: 'application/json',
    );
    return saved ? ExportResult.saved : ExportResult.cancelled;
  }

  Future<ExportResult> exportCsv() async {
    final snapshot = await store.snapshot(deviceId: deviceId, now: _now());
    final categories = <String, DrinkCategory>{
      for (final c in snapshot.categories) c.id: c,
    };
    final saved = await transfer.saveText(
      fileName: 'hydratrack-entries-${_stamp()}.csv',
      text: entriesToCsv(snapshot.entries, categories),
      mimeType: 'text/csv',
    );
    return saved ? ExportResult.saved : ExportResult.cancelled;
  }

  /// Merges a backup into the local data. Returns how many records were
  /// added or updated, or null if the user cancelled. Throws
  /// [FormatException] if the file isn't a HydraTrack backup.
  Future<int?> importBackup() async {
    final text = await transfer.pickText(extensions: const ['json']);
    if (text == null) return null;
    return store.apply(parseBackup(text));
  }
}
