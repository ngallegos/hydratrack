import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/reminder_plan.dart';
import 'package:hydratrack/domain/reminder_settings.dart';

List<DateTime> _slotsAt10And14(ReminderSettings settings, DateTime day) => [
  DateTime(day.year, day.month, day.day, 10),
  DateTime(day.year, day.month, day.day, 14),
];

void main() {
  const enabled = ReminderSettings(enabled: true);
  final noon = DateTime(2026, 11, 23, 12);

  List<DateTime> plan({
    ReminderSettings settings = enabled,
    bool goalReached = false,
    int horizonDays = 2,
  }) => planReminders(
    settings: settings,
    now: noon,
    goalReachedToday: goalReached,
    horizonDays: horizonDays,
    slotsFor: _slotsAt10And14,
  );

  test('includes only remaining slots today, then tomorrow in full', () {
    expect(plan(), [
      DateTime(2026, 11, 23, 14),
      DateTime(2026, 11, 24, 10),
      DateTime(2026, 11, 24, 14),
    ]);
  });

  test('skips the rest of today once the goal is reached', () {
    expect(plan(goalReached: true), [
      DateTime(2026, 11, 24, 10),
      DateTime(2026, 11, 24, 14),
    ]);
  });

  test('is empty when reminders are disabled, without generating slots', () {
    final result = planReminders(
      settings: const ReminderSettings(),
      now: noon,
      goalReachedToday: false,
      slotsFor: (_, _) => throw StateError('should not be called'),
    );

    expect(result, isEmpty);
  });

  test('horizon controls how many days are planned', () {
    expect(plan(horizonDays: 1), [DateTime(2026, 11, 23, 14)]);
    expect(plan(horizonDays: 3), hasLength(5));
  });

  test('rolls over month boundaries', () {
    final result = planReminders(
      settings: enabled,
      now: DateTime(2026, 11, 30, 15),
      goalReachedToday: false,
      slotsFor: _slotsAt10And14,
    );

    expect(result.first, DateTime(2026, 12, 1, 10));
  });
}
