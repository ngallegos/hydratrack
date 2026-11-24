import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/reminders/notification_access_text.dart';
import 'package:hydratrack/features/reminders/reminder_providers.dart';

void main() {
  const problems = [
    NotificationAccessStatus.denied,
    NotificationAccessStatus.dismissed,
    NotificationAccessStatus.unsupported,
    NotificationAccessStatus.noResponse,
    NotificationAccessStatus.failed,
  ];

  test('has no message when nothing is wrong', () {
    for (final status in [
      NotificationAccessStatus.unknown,
      NotificationAccessStatus.granted,
    ]) {
      expect(
        accessMessage(NotificationAccessState(status), isWeb: true),
        isNull,
      );
      expect(
        accessMessage(NotificationAccessState(status), isWeb: false),
        isNull,
      );
    }
  });

  test('every problem says what happened and how to fix it', () {
    for (final status in problems) {
      for (final isWeb in [true, false]) {
        final message = accessMessage(
          NotificationAccessState(status, 'oops'),
          isWeb: isWeb,
        );

        expect(message, isNotNull, reason: '$status web=$isWeb');
        expect(message!.title, isNotEmpty);
        expect(message.fix.length, greaterThan(30));
      }
    }
  });

  test('web wording points at the address bar, app wording at Settings', () {
    const denied = NotificationAccessState(NotificationAccessStatus.denied);

    expect(accessMessage(denied, isWeb: true)!.fix, contains('address bar'));
    expect(accessMessage(denied, isWeb: false)!.fix, contains('Settings'));
  });

  test('an unexpected error includes its detail', () {
    const failed = NotificationAccessState(
      NotificationAccessStatus.failed,
      'JavaScriptError: Notification is not defined',
    );

    expect(
      accessMessage(failed, isWeb: true)!.fix,
      contains('Notification is not defined'),
    );
  });

  test('checking and problem flags', () {
    expect(
      const NotificationAccessState(NotificationAccessStatus.checking)
          .isChecking,
      isTrue,
    );
    for (final status in problems) {
      expect(NotificationAccessState(status).isProblem, isTrue);
    }
    expect(
      const NotificationAccessState(NotificationAccessStatus.granted).isProblem,
      isFalse,
    );
  });
}
