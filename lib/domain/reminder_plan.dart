import 'reminder_settings.dart';
import 'reminders.dart';

typedef SlotGenerator = List<DateTime> Function(ReminderSettings, DateTime);

/// Upcoming reminder times: today's remaining slots (unless the goal is
/// already met) plus following days, so reminders keep firing even if the
/// app isn't opened for a day or two.
List<DateTime> planReminders({
  required ReminderSettings settings,
  required DateTime now,
  required bool goalReachedToday,
  int horizonDays = 2,
  SlotGenerator slotsFor = reminderSlots,
}) {
  if (!settings.enabled) return const [];

  return [
    for (var offset = 0; offset < horizonDays; offset++)
      if (offset > 0 || !goalReachedToday)
        for (final slot in slotsFor(
          settings,
          DateTime(now.year, now.month, now.day + offset),
        ))
          if (slot.isAfter(now)) slot,
  ];
}
