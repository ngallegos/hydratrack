import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/reminders/reminder_providers.dart';
import 'package:hydratrack/platform/reminder_scheduler.dart';

class _RecordingScheduler implements ReminderScheduler {
  final plans = <List<DateTime>>[];

  @override
  Future<PermissionResult> requestPermission() async =>
      PermissionResult.granted;

  @override
  Future<void> replaceAll(List<DateTime> times) async => plans.add(times);
}

void main() {
  test(
    'pushes the current plan to the scheduler and every change after',
    () async {
      final scheduler = _RecordingScheduler();
      var plan = [DateTime(2026, 11, 23, 14)];
      final container = ProviderContainer(
        overrides: [
          reminderSchedulerProvider.overrideWithValue(scheduler),
          reminderPlanProvider.overrideWith((ref) => plan),
        ],
      );
      addTearDown(container.dispose);

      container.read(reminderSyncProvider);
      expect(scheduler.plans, [
        [DateTime(2026, 11, 23, 14)],
      ]);

      plan = [DateTime(2026, 11, 23, 16)];
      container.invalidate(reminderPlanProvider);
      container.read(reminderSyncProvider);
      await Future<void>.delayed(Duration.zero);

      expect(scheduler.plans.last, [DateTime(2026, 11, 23, 16)]);
    },
  );
}
