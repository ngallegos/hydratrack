/// The few Drive operations sync needs, scoped to the app's hidden
/// appDataFolder. Exists so DriveBackend can be tested without Google.
abstract interface class DriveFiles {
  /// File name -> Drive file id.
  Future<Map<String, String>> list();

  Future<String> download(String id);

  Future<void> create(String name, String contents);

  Future<void> update(String id, String contents);
}
