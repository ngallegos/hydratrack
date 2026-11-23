abstract interface class ReminderScheduler {
  /// Asks the OS/browser for notification permission. Call from a user action.
  Future<bool> requestPermission();

  /// Cancels everything scheduled earlier and schedules [times] instead.
  Future<void> replaceAll(List<DateTime> times);
}

class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<void> replaceAll(List<DateTime> times) async {}
}

const reminderTitle = 'Time to hydrate';
const reminderBody = 'Tap to log a drink.';
