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
