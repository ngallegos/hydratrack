import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/reminder_settings.dart';
import 'package:hydratrack/domain/reminders.dart';

void main() {
  // Monday 23 Nov 2026
  final monday = DateTime(2026, 11, 23, 17, 45);

  ReminderSettings settings({
    bool enabled = true,
    int start = 8 * 60,
    int end = 22 * 60,
    int interval = 120,
    Set<int>? weekdays,
  }) => ReminderSettings(
    enabled: enabled,
    startMinute: start,
    endMinute: end,
    intervalMinutes: interval,
    weekdays: weekdays ?? const {1, 2, 3, 4, 5, 6, 7},
  );

  List<String> hhmm(List<DateTime> times) => [
    for (final t in times)
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}',
  ];

  group('reminderSlots', () {
    test('spaces reminders from start to end inclusive', () {
      expect(hhmm(reminderSlots(settings(), monday)), [
        '08:00',
        '10:00',
        '12:00',
        '14:00',
        '16:00',
        '18:00',
        '20:00',
        '22:00',
      ]);
    });

    test(
      'stops before the end when the interval does not divide the window',
      () {
        final slots = reminderSlots(settings(end: 21 * 60), monday);

        expect(hhmm(slots).last, '20:00');
        expect(slots, hasLength(7));
      },
    );

    test('supports non-hour intervals', () {
      final slots = reminderSlots(
        settings(start: 9 * 60, end: 11 * 60, interval: 45),
        monday,
      );

      expect(hhmm(slots), ['09:00', '09:45', '10:30']);
    });

    test('puts every slot on the requested date and ignores its time', () {
      final slots = reminderSlots(settings(), monday);

      expect(
        slots.every(
          (s) => DateTime(s.year, s.month, s.day) == DateTime(2026, 11, 23),
        ),
        isTrue,
      );
    });

    test('is empty when disabled', () {
      expect(reminderSlots(settings(enabled: false), monday), isEmpty);
    });

    test('is empty on weekdays that are not selected', () {
      final onlyTuesday = settings(weekdays: {DateTime.tuesday});

      expect(reminderSlots(onlyTuesday, monday), isEmpty);
      expect(reminderSlots(onlyTuesday, DateTime(2026, 11, 24)), isNotEmpty);
    });

    test('handles a single-slot window', () {
      expect(hhmm(reminderSlots(settings(start: 600, end: 600), monday)), [
        '10:00',
      ]);
    });

    test('is empty for invalid windows and intervals', () {
      expect(reminderSlots(settings(start: 600, end: 500), monday), isEmpty);
      expect(reminderSlots(settings(interval: 0), monday), isEmpty);
      expect(reminderSlots(settings(interval: -30), monday), isEmpty);
    });

    test('keeps wall-clock times across a daylight-saving change', () {
      // US clocks went forward on 8 Mar 2026
      final slots = reminderSlots(
        settings(start: 60, end: 4 * 60, interval: 60),
        DateTime(2026, 3, 8),
      );

      expect(slots.every((s) => s.minute == 0), isTrue);
      expect(slots.map((s) => s.day).toSet(), {8});
    });
  });
}
