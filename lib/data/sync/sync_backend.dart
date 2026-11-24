/// Where snapshot files live: a Drive folder, a directory on disk, ...
/// Implementations only move text; merging is done by SyncService.
abstract interface class SyncBackend {
  Future<List<String>> listFileNames();

  Future<String?> read(String name);

  Future<void> write(String name, String contents);
}
