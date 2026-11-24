import 'dart:async';

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
  _FakeScheduler({this.result = PermissionResult.granted});

  PermissionResult result;
  Completer<PermissionResult>? hang;
  Object? error;
  var permissionRequests = 0;

  @override
  Future<PermissionResult> requestPermission() async {
    permissionRequests++;
    if (error != null) throw error!;
    if (hang != null) return hang!.future;
    return result;
  }

  @override
  Future<void> replaceAll(List<DateTime> times) async {}
}

Widget _host(
  _FakeSettingsActions actions,
  _FakeScheduler scheduler, {
  ReminderSettings reminders = const ReminderSettings(),
}) => ProviderScope(
  overrides: [
    appSettingsProvider.overrideWith(
      (ref) => Stream.value(AppSettings(reminders: reminders)),
    ),
    settingsActionsProvider.overrideWithValue(actions),
    reminderSchedulerProvider.overrideWithValue(scheduler),
  ],
  child: const MaterialApp(home: RemindersScreen()),
);

NotificationAccessStatus _status(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(RemindersScreen)))
        .read(notificationAccessProvider)
        .status;

final _notice = find.byKey(const Key('notification-access-notice'));

Future<void> _toggle(WidgetTester tester) async {
  await tester.tap(find.byType(Switch));
  await tester.pumpAndSettle();
}

void main() {
  group('turning reminders on', () {
    testWidgets('asks for permission and saves when it is granted', (
      tester,
    ) async {
      final actions = _FakeSettingsActions();
      final scheduler = _FakeScheduler();
      await tester.pumpWidget(_host(actions, scheduler));
      await tester.pumpAndSettle();

      await _toggle(tester);

      expect(scheduler.permissionRequests, 1);
      expect(actions.saved.single.enabled, isTrue);
      expect(_notice, findsNothing);
    });

    for (final (result, title) in [
      (PermissionResult.denied, 'blocked'),
      (PermissionResult.dismissed, 'not allowed'),
      (PermissionResult.unsupported, 'show notifications here'),
    ]) {
      testWidgets('does not turn on and explains the fix when $title', (
        tester,
      ) async {
        final actions = _FakeSettingsActions();
        await tester.pumpWidget(_host(actions, _FakeScheduler(result: result)));
        await tester.pumpAndSettle();

        await _toggle(tester);

        expect(actions.saved, isEmpty);
        expect(_notice, findsOneWidget);
        expect(find.text('Try again'), findsOneWidget);
      });
    }

    testWidgets(
      'does not turn on and reports the error when the platform throws',
      (tester) async {
        final actions = _FakeSettingsActions();
        final scheduler = _FakeScheduler()
          ..error = StateError('no Notification');
        await tester.pumpWidget(_host(actions, scheduler));
        await tester.pumpAndSettle();

        await _toggle(tester);

        expect(actions.saved, isEmpty);
        expect(_status(tester), NotificationAccessStatus.failed);
        expect(find.textContaining('no Notification'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });

  group('when the browser never answers', () {
    testWidgets('shows that it is waiting, with the switch disabled', (
      tester,
    ) async {
      final actions = _FakeSettingsActions();
      final scheduler = _FakeScheduler()..hang = Completer();
      await tester.pumpWidget(_host(actions, scheduler));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(find.textContaining('Waiting for'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(
        tester.widget<SwitchListTile>(find.byType(SwitchListTile)).onChanged,
        isNull,
      );

      scheduler.hang!.complete(PermissionResult.granted);
      await tester.pumpAndSettle();
    });

    testWidgets('gives up after the timeout with an explanation', (
      tester,
    ) async {
      final actions = _FakeSettingsActions();
      final scheduler = _FakeScheduler()..hang = Completer();
      await tester.pumpWidget(_host(actions, scheduler));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pump();
      await tester.pump(
        notificationRequestTimeout + const Duration(seconds: 1),
      );

      expect(_status(tester), NotificationAccessStatus.noResponse);
      expect(actions.saved, isEmpty);
      expect(find.text("The system didn't answer"), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });
  });

  group('try again', () {
    testWidgets('turns reminders on once permission is fixed', (tester) async {
      final actions = _FakeSettingsActions();
      final scheduler = _FakeScheduler(result: PermissionResult.denied);
      await tester.pumpWidget(_host(actions, scheduler));
      await tester.pumpAndSettle();
      await _toggle(tester);
      expect(actions.saved, isEmpty);

      scheduler.result = PermissionResult.granted;
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(actions.saved.single.enabled, isTrue);
      expect(_notice, findsNothing);
    });

    testWidgets('keeps the explanation while it is still blocked', (
      tester,
    ) async {
      final actions = _FakeSettingsActions();
      await tester.pumpWidget(
        _host(actions, _FakeScheduler(result: PermissionResult.denied)),
      );
      await tester.pumpAndSettle();
      await _toggle(tester);

      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(actions.saved, isEmpty);
      expect(_notice, findsOneWidget);
    });
  });

  group('turning reminders off', () {
    testWidgets('does not ask for permission and saves', (tester) async {
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

      await _toggle(tester);

      expect(scheduler.permissionRequests, 0);
      expect(actions.saved.single.enabled, isFalse);
    });
  });

  group('other controls', () {
    testWidgets('are inert while reminders are off', (tester) async {
      final actions = _FakeSettingsActions();
      await tester.pumpWidget(_host(actions, _FakeScheduler()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('interval-30')));
      await tester.pump();

      expect(actions.saved, isEmpty);
    });

    testWidgets('change the interval and toggle weekdays', (tester) async {
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
  });
}
