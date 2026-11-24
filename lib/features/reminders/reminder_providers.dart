import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/reminder_plan.dart';
import '../../domain/stats.dart';
import '../../platform/reminder_scheduler.dart';
import '../home/home_providers.dart';
import '../settings/settings_providers.dart';

// Overridden in main() with the platform implementation.
final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => const NoopReminderScheduler(),
);

final goalReachedTodayProvider = Provider<bool>((ref) {
  final today = ref.watch(todayProvider).value;
  final entries = ref.watch(todayEntriesProvider).value;
  final categories = ref.watch(categoriesProvider).value;
  if (today == null || entries == null || categories == null) return false;

  final totals = dailyTotals(entries, {for (final c in categories) c.id: c});
  return (totals[today] ?? 0) >= ref.watch(dailyGoalMlProvider);
});

final reminderPlanProvider = Provider<List<DateTime>>((ref) {
  final settings = ref.watch(
    appSettingsProvider.select((s) => s.value?.reminders),
  );
  if (settings == null) return const [];
  ref.watch(todayProvider);

  return planReminders(
    settings: settings,
    now: DateTime.now(),
    goalReachedToday: ref.watch(goalReachedTodayProvider),
  );
});

/// Keeps scheduled notifications in step with the plan. Watch it once, at
/// the app root, to keep it alive.
final reminderSyncProvider = Provider<void>((ref) {
  ref.listen(reminderPlanProvider, (_, plan) {
    ref.read(reminderSchedulerProvider).replaceAll(plan);
  }, fireImmediately: true);
});

enum NotificationAccess { unknown, granted, unavailable }

/// Whether the OS or browser lets us show notifications. Kept separate from
/// the reminders switch so the switch always works and a permission problem
/// is shown, not hidden.
class NotificationAccessController extends Notifier<NotificationAccess> {
  @override
  NotificationAccess build() => NotificationAccess.unknown;

  /// Must be called from a user action: browsers ignore other requests.
  Future<void> request() async {
    try {
      final granted = await ref
          .read(reminderSchedulerProvider)
          .requestPermission();
      state = granted
          ? NotificationAccess.granted
          : NotificationAccess.unavailable;
    } on Object catch (error, stack) {
      // Platform plugins can throw non-Exception errors (for example
      // JavaScript errors in browsers without the Notification API).
      debugPrint('Notification permission request failed: $error\n$stack');
      state = NotificationAccess.unavailable;
    }
  }
}

final notificationAccessProvider =
    NotifierProvider<NotificationAccessController, NotificationAccess>(
      NotificationAccessController.new,
    );
