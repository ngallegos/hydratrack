import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/db/app_database.dart';
import 'package:hydratrack/data/repositories/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(db);
  });

  tearDown(() => db.close());

  test('get returns null for a missing key', () async {
    expect(await settings.get('nope'), isNull);
  });

  test('set overwrites an existing value', () async {
    await settings.set('theme', 'dark');
    await settings.set('theme', 'light');

    expect(await settings.get('theme'), 'light');
  });

  test('loadOrCreateDeviceId is stable across calls', () async {
    final first = await settings.loadOrCreateDeviceId();
    final second = await settings.loadOrCreateDeviceId();

    expect(first, isNotEmpty);
    expect(second, first);
  });
}
