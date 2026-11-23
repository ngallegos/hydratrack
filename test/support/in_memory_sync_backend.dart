import 'package:hydratrack/data/sync/sync_backend.dart';

class InMemorySyncBackend implements SyncBackend {
  final files = <String, String>{};

  @override
  Future<List<String>> listFileNames() async => files.keys.toList();

  @override
  Future<String?> read(String name) async => files[name];

  @override
  Future<void> write(String name, String contents) async =>
      files[name] = contents;
}
