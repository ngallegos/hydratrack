import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/volume_unit.dart';
import 'app_settings.dart';

final appSettingsProvider = StreamProvider<AppSettings>(
  (ref) =>
      ref.watch(settingsRepositoryProvider).watchAll().map(AppSettings.fromMap),
);

final settingsActionsProvider = Provider(
  (ref) => SettingsActions(ref.watch(settingsRepositoryProvider)),
);

final volumeUnitProvider = Provider<VolumeUnit>(
  (ref) =>
      ref.watch(appSettingsProvider.select((s) => s.value?.volumeUnit)) ??
      VolumeUnit.ml,
);
