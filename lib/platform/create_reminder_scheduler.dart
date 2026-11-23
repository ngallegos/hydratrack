import 'package:flutter/foundation.dart';

import 'local_notification_scheduler.dart';
import 'reminder_scheduler.dart';
import 'web_reminder_scheduler.dart';

Future<ReminderScheduler> createReminderScheduler() async {
  try {
    if (kIsWeb) return await WebReminderScheduler.create();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await LocalNotificationScheduler.create();
    }
  } on Object catch (error, stack) {
    debugPrint('Reminders unavailable: $error\n$stack');
  }
  return const NoopReminderScheduler();
}
