import 'reminder_providers.dart';

class AccessMessage {
  const AccessMessage(this.title, this.fix);

  final String title;
  final String fix;
}

/// What went wrong and how to fix it, worded for where the app is running.
AccessMessage? accessMessage(
  NotificationAccessState access, {
  required bool isWeb,
}) {
  switch (access.status) {
    case NotificationAccessStatus.unknown:
    case NotificationAccessStatus.granted:
      return null;
    case NotificationAccessStatus.checking:
      return AccessMessage(
        isWeb ? 'Waiting for your browser...' : 'Waiting for permission...',
        isWeb
            ? 'Choose Allow in the prompt. If none appears, look for a '
                  'notification or blocked icon at the right of the address '
                  'bar and allow notifications there.'
            : 'Choose Allow in the system prompt.',
      );
    case NotificationAccessStatus.denied:
      return isWeb
          ? const AccessMessage(
              'Notifications are blocked for this site',
              'Click the icon at the left of the address bar (a lock or '
                  'sliders), set Notifications to Allow, reload the page, then '
                  'turn reminders on again.',
            )
          : const AccessMessage(
              'Notifications are turned off for HydraTrack',
              'Open Settings, then Apps, HydraTrack, Notifications, allow '
                  'them, then come back and turn reminders on again.',
            );
    case NotificationAccessStatus.dismissed:
      return AccessMessage(
        'Notifications were not allowed',
        isWeb
            ? 'The permission prompt was closed without a choice. Turn '
                  'reminders on again and choose Allow. If no prompt appears, '
                  'look for a blocked icon at the right of the address bar.'
            : 'The permission prompt was closed without a choice. Turn '
                  'reminders on again and choose Allow.',
      );
    case NotificationAccessStatus.unsupported:
      return isWeb
          ? const AccessMessage(
              "This browser can't show notifications here",
              'Notifications need a secure address (https:// or '
                  'http://localhost) and a browser that supports them, such as '
                  'Chrome, Edge or Firefox. Private windows often block them '
                  'too.',
            )
          : const AccessMessage(
              "Notifications aren't available on this device",
              'This device or build cannot show notifications.',
            );
    case NotificationAccessStatus.noResponse:
      return AccessMessage(
        isWeb ? "The browser didn't answer" : "The system didn't answer",
        isWeb
            ? 'There was no response to the notification request after 30 '
                  'seconds. Look for a notification or blocked icon at the '
                  'right of the address bar, allow notifications, then try '
                  'again.'
            : 'There was no response to the notification request after 30 '
                  'seconds. Try again.',
      );
    case NotificationAccessStatus.failed:
      return AccessMessage(
        "Couldn't check notification permission",
        'Something went wrong (${access.detail ?? 'unknown error'}). '
            'Reloading the page and trying again usually helps.',
      );
  }
}
