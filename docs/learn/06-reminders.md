# 06 — Reminders and notifications

## Exercise (done)

`reminderSlots` in `lib/domain/reminders.dart` (the reminder times for one day) is implemented and covered by
`test/domain/reminders_test.dart`. The rules are in the comment above it.

Hints that were given:
- Guard clauses first: disabled, weekday not in `settings.weekdays`, bad interval or window -> `return const []`
- A collection-for with a classic loop header builds the list:
  `[for (var m = start; m <= end; m += step) DateTime(y, mo, d, m ~/ 60, m % 60)]`
- `~/` is integer division, `%` the remainder, so `minutes -> hour, minute`
- `day.weekday` is 1 (Monday) to 7 (Sunday), matching `DateTime.monday ... DateTime.sunday`

## Concepts

### Hide plugins behind a small interface
`ReminderScheduler` has two methods. Android, web and tests each implement it. The rest of the app (planner, providers,
UI) never imports `flutter_local_notifications`. Analogy: an `INotificationService` registered in DI.
`abstract interface class` means "can be implemented but not extended".

### Plan, then apply
`planReminders` is pure: settings + now + "goal reached?" in, list of `DateTime` out. A provider recomputes it when
inputs change and `ref.listen(..., fireImmediately: true)` applies it to the scheduler. Keeping decisions pure and side
effects at the edge is what makes both halves testable (the planner takes the slot generator as a parameter so its tests
don't depend on `reminderSlots`).

### Platform differences
- **Android**: `zonedSchedule` hands each reminder to the OS (AlarmManager) so it fires with the app closed. Requires
  Gradle desugaring, `compileSdk` 37, manifest receivers, and runtime notification permission on Android 13+.
  We use *inexact* alarms: they can drift a few minutes but need no exact-alarm permission.
- **Web**: browsers can't schedule notifications. The web scheduler uses `Timer`s while the page is open. Permission can
  only be requested from a user gesture, which is why enabling is tied to the switch tap.
- Time zones: `timezone` converts to `TZDateTime`; `flutter_timezone` reads the device zone because Dart can't.

### Testing time
`testWidgets` runs in a fake-time zone: `tester.pump(Duration(minutes: 30))` advances `Timer`s without waiting.
Inject a `clock` function (`DateTime Function()`) instead of calling `DateTime.now()` directly in logic.

### Defensive startup
`createReminderScheduler` catches plugin failures and returns a no-op, so a notification problem can never stop the app from
launching. Optional features should degrade, not crash.

## Tracked follow-ups
- A "log my starred drink" button on the notification. It needs a background isolate that opens the same database:
  [#9](https://github.com/ngallegos/hydratrack/issues/9).
- None of the Android code has run on a device yet: [#4](https://github.com/ngallegos/hydratrack/issues/4).

## Docs
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [Android notification permission](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [Android alarms](https://developer.android.com/develop/background-work/services/alarms)
- [fake_async / testing timers](https://pub.dev/packages/fake_async)
