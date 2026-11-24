import 'dart:convert';

import 'package:googleapis/drive/v3.dart' as drive;

import 'drive_files.dart';

/// [DriveFiles] over the real Drive v3 API, restricted to appDataFolder
/// (the `drive.appdata` scope), which only this app can see.
class GoogleDriveFiles implements DriveFiles {
  GoogleDriveFiles(this._api);

  final drive.DriveApi _api;

  static const scopes = [drive.DriveApi.driveAppdataScope];
  static const _space = 'appDataFolder';

  @override
  Future<Map<String, String>> list() async {
    final ids = <String, String>{};
    String? pageToken;
    do {
      final page = await _api.files.list(
        spaces: _space,
        $fields: 'nextPageToken, files(id, name)',
        pageSize: 100,
        pageToken: pageToken,
      );
      for (final file in page.files ?? const <drive.File>[]) {
        final id = file.id;
        final name = file.name;
        if (id != null && name != null) ids[name] = id;
      }
      pageToken = page.nextPageToken;
    } while (pageToken != null);
    return ids;
  }

  @override
  Future<String> download(String id) async {
    final media = await _api.files.get(
      id,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    return utf8.decodeStream(media.stream);
  }

  @override
  Future<void> create(String name, String contents) async {
    await _api.files.create(
      drive.File(name: name, parents: [_space]),
      uploadMedia: _media(contents),
    );
  }

  @override
  Future<void> update(String id, String contents) async {
    await _api.files.update(drive.File(), id, uploadMedia: _media(contents));
  }

  drive.Media _media(String contents) {
    final bytes = utf8.encode(contents);
    return drive.Media(Stream.value(bytes), bytes.length);
  }
}
