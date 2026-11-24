import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/reminder_settings.dart';
import 'package:hydratrack/features/reminders/reminder_providers.dart';
import 'package:hydratrack/features/reminders/reminders_screen.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/platform/reminder_scheduler.dart';
import 'package:material_ui/material_ui.dart';

class _FakeSettingsActions extends Fake implements SettingsActions {
  final saved = <ReminderSettings>[];

  @override
  Future<void> setReminders(ReminderSettings reminders) async =>
      saved.add(reminders);
}

class _FakeScheduler implements ReminderScheduler {
  _FakeScheduler({this.grants = true, this.throws = false});

  bool grants;
  final bool throws;
  var permissionRequests = 0;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    if (throws) throw StateError('Notification API missing');
    return grants;
  }

  @override
  Future<void> replaceAll(List<DateTime> times) async {}
}

class _BlockedAccess extends NotificationAccessController {
  @override
  NotificationAccess build() => NotificationAccess.unavailable;
}

Widget _host(
  _FakeSettingsActions actions,
  _FakeScheduler scheduler, {
  ReminderSettings reminders = const ReminderSettings(),
  bool startBlocked = false,
}) => ProviderScope(
  overrides: [
    appSettingsProvider.overrideWith(
      (ref) => Stream.value(AppSettings(reminders: reminders)),
    ),
    settingsActionsProvider.overrideWithValue(actions),
    reminderSchedulerProvider.overrideWithValue(scheduler),
    if (startBlocked)
      notificationAccessProvider.overrideWith(_BlockedAccess.new),
  ],
  child: const MaterialApp(home: RemindersScreen()),
);

void main() {
  testWidgets('enabling asks for permission and saves', (tester) async {
    final actions = _FakeSettingsActions();
    final scheduler = _FakeScheduler();
    await tester.pumpWidget(_host(actions, scheduler));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(scheduler.permissionRequests, 1);
    expect(actions.saved.single.enabled, isTrue);
  });

  NotificationAccess accessOf(WidgetTester tester) =>
      ProviderScope.containerOf(tester.element(find.byType(RemindersScreen)))
          .read(notificationAccessProvider);

  testWidgets('the switch still turns on when permission is denied', (
    tester,
  ) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions, _FakeScheduler(grants: false)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(actions.saved.single.enabled, isTrue);
    expect(accessOf(tester), NotificationAccess.unavailable);
  });

  testWidgets('the switch still turns on when the platform throws', (
    tester,
  ) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions, _FakeScheduler(throws: true)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(actions.saved.single.enabled, isTrue);
    expect(accessOf(tester), NotificationAccess.unavailable);
    expect(tester.takeException(), isNull);
  });

  testWidgets('granted permission is recorded', (tester) async {
    await tester.pumpWidget(_host(_FakeSettingsActions(), _FakeScheduler()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(accessOf(tester), NotificationAccess.granted);
  });

  testWidgets('explains a blocked permission and lets the user retry', (
    tester,
  ) async {
    final scheduler = _FakeScheduler();
    await tester.pumpWidget(
      _host(
        _FakeSettingsActions(),
        scheduler,
        reminders: const ReminderSettings(enabled: true),
        startBlocked: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('notifications-blocked')), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(scheduler.permissionRequests, 1);
    expect(find.byKey(const Key('notifications-blocked')), findsNothing);
  });

  testWidgets('no warning while reminders are off', (tester) async {
    await tester.pumpWidget(
      _host(_FakeSettingsActions(), _FakeScheduler(), startBlocked: true),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('notifications-blocked')), findsNothing);
  });

  testWidgets('disabling does not ask for permission', (tester) async {
    final actions = _FakeSettingsActions();
    final scheduler = _FakeScheduler();
    await tester.pumpWidget(
      _host(
        actions,
        scheduler,
        reminders: const ReminderSettings(enabled: true),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(scheduler.permissionRequests, 0);
    expect(actions.saved.single.enabled, isFalse);
  });

  testWidgets('controls are inert while reminders are off', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions, _FakeScheduler()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('interval-30')));
    await tester.pump();

    expect(actions.saved, isEmpty);
  });

  testWidgets('changes the interval and toggles weekdays', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(
      _host(
        actions,
        _FakeScheduler(),
        reminders: const ReminderSettings(enabled: true),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('interval-30')));
    await tester.pump();
    await tester.tap(find.byKey(Key('weekday-${DateTime.saturday}')));
    await tester.pump();

    expect(actions.saved[0].intervalMinutes, 30);
    expect(actions.saved[1].weekdays, isNot(contains(DateTime.saturday)));
    expect(actions.saved[1].weekdays, hasLength(6));
  });
}
