import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_scheduler.dart';

/// Android: OS-scheduled notifications that fire even when the app is closed.
class LocalNotificationScheduler implements ReminderScheduler {
  LocalNotificationScheduler._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'hydration_reminders',
      'Hydration reminders',
      channelDescription: 'Reminders to drink throughout the day',
    ),
  );

  static Future<LocalNotificationScheduler> create() async {
    tz_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));

    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    return LocalNotificationScheduler._(plugin);
  }

  @override
  Future<PermissionResult> requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return PermissionResult.unsupported;
    final granted = await android.requestNotificationsPermission();
    return granted == true ? PermissionResult.granted : PermissionResult.denied;
  }

  @override
  Future<void> replaceAll(List<DateTime> times) async {
    await _plugin.cancelAll();
    for (final (index, time) in times.indexed) {
      await _plugin.zonedSchedule(
        id: index + 1,
        title: reminderTitle,
        body: reminderBody,
        scheduledDate: tz.TZDateTime.from(time, tz.local),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}
