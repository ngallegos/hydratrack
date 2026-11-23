import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/db/app_database.dart';
import 'package:hydratrack/data/repositories/settings_repository.dart';
import 'package:hydratrack/domain/goal.dart';
import 'package:hydratrack/domain/reminder_settings.dart';
import 'package:hydratrack/features/avatar/avatar_shape.dart';
import 'package:hydratrack/features/settings/app_settings.dart';

void main() {
  group('AppSettings.fromMap', () {
    test('uses defaults for an empty map', () {
      final settings = AppSettings.fromMap(const {});

      expect(settings.dailyGoalMl, 2500);
      expect(settings.avatarShape, AvatarShape.bottle);
      expect(settings.activity, ActivityLevel.sedentary);
      expect(settings.onboardingDone, isFalse);
      expect(settings.weightKg, isNull);
    });

    test('parses stored values', () {
      final settings = AppSettings.fromMap(const {
        SettingKeys.dailyGoalMl: '3100',
        SettingKeys.avatarShape: 'cactus',
        SettingKeys.activityLevel: 'veryActive',
        SettingKeys.weightKg: '72.5',
        SettingKeys.onboardingDone: 'true',
      });

      expect(settings.dailyGoalMl, 3100);
      expect(settings.avatarShape, AvatarShape.cactus);
      expect(settings.activity, ActivityLevel.veryActive);
      expect(settings.weightKg, 72.5);
      expect(settings.onboardingDone, isTrue);
    });

    test('falls back to default reminders for corrupt JSON', () {
      final settings = AppSettings.fromMap(const {
        SettingKeys.reminders: '{nope',
      });

      expect(settings.reminders, const ReminderSettings());
    });

    test('sync defaults to off with no folder', () {
      final settings = AppSettings.fromMap(const {});

      expect(settings.syncMode, SyncMode.off);
      expect(settings.syncFolderPath, isNull);
      expect(settings.lastSyncAt, isNull);
    });

    test('falls back to defaults for corrupt values', () {
      final settings = AppSettings.fromMap(const {
        SettingKeys.dailyGoalMl: 'lots',
        SettingKeys.avatarShape: 'unicorn',
        SettingKeys.weightKg: 'heavy',
      });

      expect(settings.dailyGoalMl, 2500);
      expect(settings.avatarShape, AvatarShape.bottle);
      expect(settings.weightKg, isNull);
    });
  });

  group('SettingsActions', () {
    late AppDatabase db;
    late SettingsRepository repository;
    late SettingsActions actions;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = SettingsRepository(db);
      actions = SettingsActions(repository);
    });

    tearDown(() => db.close());

    Future<AppSettings> current() async =>
        AppSettings.fromMap(await repository.watchAll().first);

    test('setDailyGoalMl and setAvatarShape persist', () async {
      await actions.setDailyGoalMl(3000);
      await actions.setAvatarShape(AvatarShape.fish);

      final settings = await current();
      expect(settings.dailyGoalMl, 3000);
      expect(settings.avatarShape, AvatarShape.fish);
    });

    test('sync settings round-trip through storage', () async {
      final at = DateTime.utc(2026, 11, 23, 12, 30);

      await actions.setSyncFolder('/storage/Sync/hydratrack');
      await actions.recordSync(at);

      final settings = await current();
      expect(settings.syncMode, SyncMode.folder);
      expect(settings.syncFolderPath, '/storage/Sync/hydratrack');
      expect(settings.lastSyncAt, at);

      await actions.setSyncMode(SyncMode.off);
      expect((await current()).syncMode, SyncMode.off);
    });

    test('setReminders round-trips through storage', () async {
      const reminders = ReminderSettings(
        enabled: true,
        startMinute: 7 * 60 + 30,
        endMinute: 21 * 60,
        intervalMinutes: 60,
        weekdays: {DateTime.monday, DateTime.friday},
      );

      await actions.setReminders(reminders);

      expect((await current()).reminders, reminders);
    });

    test('completeOnboarding stores the profile and marks it done', () async {
      await actions.completeOnboarding(
        dailyGoalMl: 2700,
        weightKg: 70,
        activity: ActivityLevel.light,
      );

      final settings = await current();
      expect(settings.dailyGoalMl, 2700);
      expect(settings.weightKg, 70);
      expect(settings.activity, ActivityLevel.light);
      expect(settings.onboardingDone, isTrue);
    });
  });
}
