import 'dart:io';

import 'sync_backend.dart';

/// Snapshot files in a plain directory, e.g. one shared with Syncthing.
class DirectoryBackend implements SyncBackend {
  DirectoryBackend(this.directory);

  final Directory directory;

  @override
  Future<List<String>> listFileNames() async {
    if (!await directory.exists()) return const [];
    return [
      await for (final entity in directory.list())
        if (entity is File) entity.uri.pathSegments.last,
    ];
  }

  @override
  Future<String?> read(String name) async {
    final file = File('${directory.path}/$name');
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  /// Writes to a temporary name then renames, so a syncing peer never sees
  /// a half-written file.
  @override
  Future<void> write(String name, String contents) async {
    await directory.create(recursive: true);
    final temp = File('${directory.path}/.$name.tmp');
    await temp.writeAsString(contents, flush: true);
    await temp.rename('${directory.path}/$name');
  }
}
