import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db/app_database.dart';
import 'repositories/category_repository.dart';
import 'repositories/drink_repository.dart';
import 'repositories/log_repository.dart';
import 'repositories/settings_repository.dart';

// Overridden in main() once the database is open and the device id is known.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

final deviceIdProvider = Provider<String>(
  (ref) => throw UnimplementedError('deviceIdProvider must be overridden'),
);

final settingsRepositoryProvider = Provider(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepository(
    ref.watch(databaseProvider),
    deviceId: ref.watch(deviceIdProvider),
  ),
);

final drinkRepositoryProvider = Provider(
  (ref) => DrinkRepository(
    ref.watch(databaseProvider),
    deviceId: ref.watch(deviceIdProvider),
  ),
);

final logRepositoryProvider = Provider(
  (ref) => LogRepository(
    ref.watch(databaseProvider),
    deviceId: ref.watch(deviceIdProvider),
  ),
);
