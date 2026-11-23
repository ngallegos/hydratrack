import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import 'app_settings.dart';

final appSettingsProvider = StreamProvider<AppSettings>(
  (ref) =>
      ref.watch(settingsRepositoryProvider).watchAll().map(AppSettings.fromMap),
);

final settingsActionsProvider = Provider(
  (ref) => SettingsActions(ref.watch(settingsRepositoryProvider)),
);
