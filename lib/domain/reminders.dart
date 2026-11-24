import 'reminder_settings.dart';

List<DateTime> reminderSlots(ReminderSettings settings, DateTime day) {
  if (!settings.enabled) return const [];
  if (!settings.weekdays.contains(day.weekday)) return const [];
  if (settings.intervalMinutes <= 0) return const [];
  if (settings.endMinute < settings.startMinute) return const [];

  return [
    for (
      var m = settings.startMinute;
      m <= settings.endMinute;
      m += settings.intervalMinutes
    )
      DateTime(day.year, day.month, day.day, m ~/ 60, m % 60),
  ];
}
