import 'reminder_settings.dart';

// EXERCISE: generate the reminder times for one day.
//
// Returns the local DateTimes on [day] (only its year/month/day matter) at
// which a reminder should fire, in ascending order:
//  - first at settings.startMinute, then every settings.intervalMinutes,
//    up to and including settings.endMinute (minutes after midnight)
//  - empty when reminders are disabled
//  - empty when day's weekday (DateTime.monday..sunday) is not in
//    settings.weekdays
//  - empty when intervalMinutes <= 0 or endMinute < startMinute
//
// Build each time with the DateTime(year, month, day, hour, minute)
// constructor rather than adding Durations, so daylight-saving changes
// don't shift reminders off their wall-clock time.
//
// See test/domain/reminders_test.dart.
List<DateTime> reminderSlots(ReminderSettings settings, DateTime day) {
  throw UnimplementedError('Exercise: implement reminderSlots');
}
