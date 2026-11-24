import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/goal.dart';
import '../../domain/reminder_settings.dart';
import '../../domain/volume_unit.dart';
import '../avatar/avatar_shape.dart';

part 'app_settings.freezed.dart';

abstract final class SettingKeys {
  static const dailyGoalMl = 'dailyGoalMl';
  static const avatarShape = 'avatarShape';
  static const weightKg = 'weightKg';
  static const activityLevel = 'activityLevel';
  static const onboardingDone = 'onboardingDone';
  static const reminders = 'reminders';
  static const volumeUnit = 'volumeUnit';
  static const syncMode = 'syncMode';
  static const syncFolderPath = 'syncFolderPath';
  static const lastSyncAt = 'lastSyncAt';
}

const defaultDailyGoalMl = 2500;

enum SyncMode { off, folder, drive }

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(defaultDailyGoalMl) int dailyGoalMl,
    @Default(AvatarShape.bottle) AvatarShape avatarShape,
    @Default(ActivityLevel.sedentary) ActivityLevel activity,
    @Default(false) bool onboardingDone,
    @Default(ReminderSettings()) ReminderSettings reminders,
    @Default(VolumeUnit.ml) VolumeUnit volumeUnit,
    @Default(SyncMode.off) SyncMode syncMode,
    String? syncFolderPath,
    DateTime? lastSyncAt,
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
    reminders: _parseReminders(map[SettingKeys.reminders]),
    volumeUnit:
        VolumeUnit.values.asNameMap()[map[SettingKeys.volumeUnit]] ??
        VolumeUnit.ml,
    syncMode:
        SyncMode.values.asNameMap()[map[SettingKeys.syncMode]] ?? SyncMode.off,
    syncFolderPath: map[SettingKeys.syncFolderPath],
    lastSyncAt: DateTime.tryParse(map[SettingKeys.lastSyncAt] ?? ''),
    weightKg: double.tryParse(map[SettingKeys.weightKg] ?? ''),
  );
}

ReminderSettings _parseReminders(String? raw) {
  if (raw == null) return const ReminderSettings();
  try {
    return ReminderSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  } on Object {
    return const ReminderSettings();
  }
}

class SettingsActions {
  SettingsActions(this._repository);

  final SettingsRepository _repository;

  Future<void> setDailyGoalMl(int ml) =>
      _repository.set(SettingKeys.dailyGoalMl, '$ml');

  Future<void> setAvatarShape(AvatarShape shape) =>
      _repository.set(SettingKeys.avatarShape, shape.name);

  Future<void> setReminders(ReminderSettings reminders) =>
      _repository.set(SettingKeys.reminders, jsonEncode(reminders.toJson()));

  Future<void> setVolumeUnit(VolumeUnit unit) =>
      _repository.set(SettingKeys.volumeUnit, unit.name);

  Future<void> setSyncFolder(String path) => _repository.setMany({
    SettingKeys.syncMode: SyncMode.folder.name,
    SettingKeys.syncFolderPath: path,
  });

  Future<void> setSyncMode(SyncMode mode) =>
      _repository.set(SettingKeys.syncMode, mode.name);

  Future<void> recordSync(DateTime at) =>
      _repository.set(SettingKeys.lastSyncAt, at.toUtc().toIso8601String());

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
