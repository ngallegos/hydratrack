import 'dart:async';

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

enum NotificationAccessStatus {
  unknown,
  checking,
  granted,
  denied,
  dismissed,
  unsupported,
  noResponse,
  failed,
}

class NotificationAccessState {
  const NotificationAccessState(this.status, [this.detail]);

  final NotificationAccessStatus status;

  /// The underlying error, for [NotificationAccessStatus.failed].
  final String? detail;

  bool get isChecking => status == NotificationAccessStatus.checking;

  bool get isProblem => switch (status) {
    NotificationAccessStatus.denied ||
    NotificationAccessStatus.dismissed ||
    NotificationAccessStatus.unsupported ||
    NotificationAccessStatus.noResponse ||
    NotificationAccessStatus.failed => true,
    _ => false,
  };
}

/// How long to wait for the OS or browser to answer a permission request.
const notificationRequestTimeout = Duration(seconds: 30);

/// Whether the OS or browser lets us show notifications. Kept apart from the
/// reminders setting so every outcome of asking is visible, including the
/// request never being answered.
class NotificationAccessController extends Notifier<NotificationAccessState> {
  @override
  NotificationAccessState build() =>
      const NotificationAccessState(NotificationAccessStatus.unknown);

  void reset() =>
      state = const NotificationAccessState(NotificationAccessStatus.unknown);

  /// Returns true if notifications are allowed. Must be called from a user
  /// action: browsers ignore other requests.
  Future<bool> request() async {
    state = const NotificationAccessState(NotificationAccessStatus.checking);
    try {
      final result = await ref
          .read(reminderSchedulerProvider)
          .requestPermission()
          .timeout(notificationRequestTimeout);
      final status = switch (result) {
        PermissionResult.granted => NotificationAccessStatus.granted,
        PermissionResult.denied => NotificationAccessStatus.denied,
        PermissionResult.dismissed => NotificationAccessStatus.dismissed,
        PermissionResult.unsupported => NotificationAccessStatus.unsupported,
      };
      state = NotificationAccessState(status);
      return status == NotificationAccessStatus.granted;
    } on TimeoutException {
      state = const NotificationAccessState(
        NotificationAccessStatus.noResponse,
      );
    } on Object catch (error, stack) {
      // Platform plugins can throw non-Exception errors (for example
      // JavaScript errors in browsers without the Notification API).
      debugPrint('Notification permission request failed: $error\n$stack');
      state = NotificationAccessState(
        NotificationAccessStatus.failed,
        '$error',
      );
    }
    return false;
  }
}

final notificationAccessProvider =
    NotifierProvider<NotificationAccessController, NotificationAccessState>(
      NotificationAccessController.new,
    );
