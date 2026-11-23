# 06 — Reminders and notifications

## Exercise

Implement `reminderSlots` in `lib/domain/reminders.dart`: the reminder times for one day. The rules are in the comment above
it. Run `flutter test test/domain/reminders_test.dart`.

Hints:
- Guard clauses first: disabled, weekday not in `settings.weekdays`, bad interval or window -> `return const []`
- A collection-for with a classic loop header builds the list:
  `[for (var m = start; m <= end; m += step) DateTime(y, mo, d, m ~/ 60, m % 60)]`
- `~/` is integer division, `%` the remainder, so `minutes -> hour, minute`
- `day.weekday` is 1 (Monday) to 7 (Sunday), matching `DateTime.monday ... DateTime.sunday`

Until it is done, reminders can be switched on but nothing is scheduled (the planner calls it only when enabled; the app
itself still runs).

## Concepts

### Hide plugins behind a small interface
`ReminderScheduler` has two methods. Android, web and tests each implement it. The rest of the app (planner, providers,
UI) never imports `flutter_local_notifications`. Analogy: an `INotificationService` registered in DI.
`abstract interface class` means "can be implemented but not extended".

### Plan, then apply
`planReminders` is pure: settings + now + "goal reached?" in, list of `DateTime` out. A provider recomputes it when
inputs change and `ref.listen(..., fireImmediately: true)` applies it to the scheduler. Keeping decisions pure and side
effects at the edge is what makes both halves testable (the planner takes the slot generator as a parameter so its tests
don't need your exercise).

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

## Not done yet
- A "log my starred drink" button on the notification. It needs a background isolate that opens the same database. Planned
  as a follow-up after sync.
- None of the Android code has run on a device yet; install the Android SDK (platform 37) and try `flutter run`.

## Docs
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [Android notification permission](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [Android alarms](https://developer.android.com/develop/background-work/services/alarms)
- [fake_async / testing timers](https://pub.dev/packages/fake_async)
