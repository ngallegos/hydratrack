import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'data/db/app_database.dart';
import 'data/providers.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/drink_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/seed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase.persistent();
  final deviceId = await SettingsRepository(db).loadOrCreateDeviceId();
  await seedDefaults(
    CategoryRepository(db, deviceId: deviceId),
    DrinkRepository(db, deviceId: deviceId),
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        deviceIdProvider.overrideWithValue(deviceId),
      ],
      child: const HydraTrackApp(),
    ),
  );
}

class HydraTrackApp extends StatelessWidget {
  const HydraTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HydraTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const Scaffold(body: Center(child: Text('HydraTrack'))),
    );
  }
}
