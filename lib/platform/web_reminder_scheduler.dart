import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'reminder_scheduler.dart';

/// Web: browsers cannot schedule notifications, so this fires them from
/// in-page timers. Reminders only appear while the tab/PWA is open.
class WebReminderScheduler implements ReminderScheduler {
  WebReminderScheduler({
    required this._show,
    required this._requestPermission,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final Future<void> Function(int id) _show;
  final Future<bool> Function() _requestPermission;
  final DateTime Function() _now;
  final _timers = <Timer>[];

  static Future<WebReminderScheduler> create() async {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: const InitializationSettings(web: WebInitializationSettings()),
    );
    final web = plugin
        .resolvePlatformSpecificImplementation<
          WebFlutterLocalNotificationsPlugin
        >();
    return WebReminderScheduler(
      requestPermission: () async =>
          await web?.requestNotificationsPermission() ?? false,
      show: (id) => plugin.show(
        id: id,
        title: reminderTitle,
        body: reminderBody,
        notificationDetails: const NotificationDetails(
          web: WebNotificationDetails(),
        ),
      ),
    );
  }

  @override
  Future<bool> requestPermission() => _requestPermission();

  @override
  Future<void> replaceAll(List<DateTime> times) async {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();

    final now = _now();
    for (final (index, time) in times.indexed) {
      final delay = time.difference(now);
      if (delay.isNegative) continue;
      _timers.add(
        Timer(delay, () {
          // Showing fails if permission is missing; that must not surface as
          // an unhandled error from a timer callback.
          unawaited(
            _show(index + 1).catchError((Object error) {
              debugPrint('Could not show reminder: $error');
            }),
          );
        }),
      );
    }
  }
}
