import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/platform/reminder_scheduler.dart';
import 'package:hydratrack/platform/web_reminder_scheduler.dart';

void main() {
  final now = DateTime(2026, 11, 23, 9);
  final shown = <int>[];
  late WebReminderScheduler scheduler;

  setUp(() {
    shown.clear();
    scheduler = WebReminderScheduler(
      show: (id) async => shown.add(id),
      requestPermission: () async => PermissionResult.granted,
      clock: () => now,
    );
  });

  testWidgets('fires each reminder at its time', (tester) async {
    await scheduler.replaceAll([
      now.add(const Duration(minutes: 30)),
      now.add(const Duration(minutes: 90)),
    ]);

    await tester.pump(const Duration(minutes: 29));
    expect(shown, isEmpty);

    await tester.pump(const Duration(minutes: 2));
    expect(shown, [1]);

    await tester.pump(const Duration(hours: 1));
    expect(shown, [1, 2]);
  });

  testWidgets('skips times that have already passed', (tester) async {
    await scheduler.replaceAll([
      now.subtract(const Duration(minutes: 5)),
      now.add(const Duration(minutes: 10)),
    ]);

    await tester.pump(const Duration(minutes: 11));

    expect(shown, [2]);
  });

  testWidgets('replaceAll cancels earlier reminders', (tester) async {
    await scheduler.replaceAll([now.add(const Duration(minutes: 10))]);
    await scheduler.replaceAll([now.add(const Duration(minutes: 60))]);

    await tester.pump(const Duration(minutes: 30));
    expect(shown, isEmpty);

    await tester.pump(const Duration(minutes: 31));
    expect(shown, [1]);
  });

  testWidgets('an empty list clears everything', (tester) async {
    await scheduler.replaceAll([now.add(const Duration(minutes: 10))]);
    await scheduler.replaceAll([]);

    await tester.pump(const Duration(hours: 1));

    expect(shown, isEmpty);
  });

  testWidgets('a reminder that cannot be shown is not an unhandled error', (
    tester,
  ) async {
    final failing = WebReminderScheduler(
      show: (id) async => throw StateError('permission missing'),
      requestPermission: () async => PermissionResult.denied,
      clock: () => now,
    );
    await failing.replaceAll([now.add(const Duration(minutes: 5))]);

    await tester.pump(const Duration(minutes: 6));

    expect(tester.takeException(), isNull);
  });

  test('requestPermission delegates', () async {
    expect(await scheduler.requestPermission(), PermissionResult.granted);
  });
}
