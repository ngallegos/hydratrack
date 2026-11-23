import 'drive_files.dart';
import 'sync_backend.dart';

class DriveNotSignedIn implements Exception {
  const DriveNotSignedIn();

  @override
  String toString() => 'Not signed in to Google Drive';
}

/// Snapshot files in the app's private Drive folder. [resolve] returns the
/// signed-in Drive client, or null when the user is signed out.
class DriveBackend implements SyncBackend {
  DriveBackend(this._resolve);

  final Future<DriveFiles?> Function() _resolve;

  Future<DriveFiles> _files() async =>
      await _resolve() ?? (throw const DriveNotSignedIn());

  @override
  Future<List<String>> listFileNames() async =>
      (await (await _files()).list()).keys.toList();

  @override
  Future<String?> read(String name) async {
    final files = await _files();
    final id = (await files.list())[name];
    return id == null ? null : files.download(id);
  }

  @override
  Future<void> write(String name, String contents) async {
    final files = await _files();
    final id = (await files.list())[name];
    if (id == null) {
      await files.create(name, contents);
    } else {
      await files.update(id, contents);
    }
  }
}
