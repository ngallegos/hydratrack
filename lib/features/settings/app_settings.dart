import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/goal.dart';
import '../avatar/avatar_shape.dart';

part 'app_settings.freezed.dart';

abstract final class SettingKeys {
  static const dailyGoalMl = 'dailyGoalMl';
  static const avatarShape = 'avatarShape';
  static const weightKg = 'weightKg';
  static const activityLevel = 'activityLevel';
  static const onboardingDone = 'onboardingDone';
}

const defaultDailyGoalMl = 2500;

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(defaultDailyGoalMl) int dailyGoalMl,
    @Default(AvatarShape.bottle) AvatarShape avatarShape,
    @Default(ActivityLevel.sedentary) ActivityLevel activity,
    @Default(false) bool onboardingDone,
    double? weightKg,
  }) = _AppSettings;

  factory AppSettings.fromMap(Map<String, String> map) => AppSettings(
    dailyGoalMl:
        int.tryParse(map[SettingKeys.dailyGoalMl] ?? '') ?? defaultDailyGoalMl,
    avatarShape:
        AvatarShape.values.asNameMap()[map[SettingKeys.avatarShape]] ??
        AvatarShape.bottle,
    activity:
        ActivityLevel.values.asNameMap()[map[SettingKeys.activityLevel]] ??
        ActivityLevel.sedentary,
    onboardingDone: map[SettingKeys.onboardingDone] == 'true',
    weightKg: double.tryParse(map[SettingKeys.weightKg] ?? ''),
  );
}

class SettingsActions {
  SettingsActions(this._repository);

  final SettingsRepository _repository;

  Future<void> setDailyGoalMl(int ml) =>
      _repository.set(SettingKeys.dailyGoalMl, '$ml');

  Future<void> setAvatarShape(AvatarShape shape) =>
      _repository.set(SettingKeys.avatarShape, shape.name);

  Future<void> completeOnboarding({
    required int dailyGoalMl,
    double? weightKg,
    ActivityLevel activity = ActivityLevel.sedentary,
  }) => _repository.setMany({
    SettingKeys.dailyGoalMl: '$dailyGoalMl',
    SettingKeys.activityLevel: activity.name,
    if (weightKg != null) SettingKeys.weightKg: '$weightKg',
    SettingKeys.onboardingDone: 'true',
  });
}
