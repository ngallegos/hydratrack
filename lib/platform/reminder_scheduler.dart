enum PermissionResult {
  granted,

  /// The user (or an earlier choice) blocked notifications.
  denied,

  /// The prompt was closed without choosing.
  dismissed,

  /// This browser, device or address can't show notifications at all.
  unsupported,
}

abstract interface class ReminderScheduler {
  /// Asks the OS/browser for notification permission. Call from a user action.
  Future<PermissionResult> requestPermission();

  /// Cancels everything scheduled earlier and schedules [times] instead.
  Future<void> replaceAll(List<DateTime> times);
}

class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<PermissionResult> requestPermission() async =>
      PermissionResult.unsupported;

  @override
  Future<void> replaceAll(List<DateTime> times) async {}
}

const reminderTitle = 'Time to hydrate';
const reminderBody = 'Tap to log a drink.';
