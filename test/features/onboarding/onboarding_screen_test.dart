import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydratrack/domain/goal.dart';
import 'package:hydratrack/domain/volume_unit.dart';
import 'package:hydratrack/features/onboarding/onboarding_screen.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:material_ui/material_ui.dart';

typedef _Onboarding = ({
  int dailyGoalMl,
  double? weightKg,
  ActivityLevel activity,
});

class _FakeSettingsActions extends Fake implements SettingsActions {
  final completed = <_Onboarding>[];
  final units = <VolumeUnit>[];

  @override
  Future<void> setVolumeUnit(VolumeUnit unit) async => units.add(unit);

  @override
  Future<void> completeOnboarding({
    required int dailyGoalMl,
    double? weightKg,
    ActivityLevel activity = ActivityLevel.sedentary,
  }) async => completed.add((
    dailyGoalMl: dailyGoalMl,
    weightKg: weightKg,
    activity: activity,
  ));
}

Widget _host(_FakeSettingsActions actions) {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/', builder: (_, _) => const Text('home')),
    ],
  );
  return ProviderScope(
    overrides: [settingsActionsProvider.overrideWithValue(actions)],
    child: MaterialApp.router(routerConfig: router),
  );
}

/// The form is taller than the test screen and lists build lazily, so scroll
/// to the widget before tapping it.
Future<void> _tapText(WidgetTester tester, String text) async {
  await tester.scrollUntilVisible(
    find.text(text),
    100,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(find.text(text));
  await tester.pump();
  await tester.tap(find.text(text));
}

void main() {
  testWidgets('skip saves the default goal and goes home', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await _tapText(tester, 'Skip, use the default');
    await tester.pumpAndSettle();

    expect(actions.completed.single, (
      dailyGoalMl: 2500,
      weightKg: null,
      activity: ActivityLevel.sedentary,
    ));
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('start saves weight, activity and goal', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '70');
    await tester.tap(find.byKey(const Key('activity-light')));
    await tester.pump();
    await _tapText(tester, 'Start');
    await tester.pumpAndSettle();

    expect(actions.completed.single, (
      dailyGoalMl: 2500,
      weightKg: 70.0,
      activity: ActivityLevel.light,
    ));
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('suggest is disabled until a weight is entered', (tester) async {
    await tester.pumpWidget(_host(_FakeSettingsActions()));
    await tester.pumpAndSettle();

    OutlinedButton button() => tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Suggest my goal'),
    );
    expect(button().onPressed, isNull);

    await tester.enterText(find.byType(TextField), '70');
    await tester.pump();

    expect(button().onPressed, isNotNull);
  });

  testWidgets('offers a unit choice', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.text('fl oz'));

    expect(actions.units, [VolumeUnit.flOz]);
  });

  // Fails until the suggestedDailyGoalMl exercise (lib/domain/goal.dart) is done.
  testWidgets('suggest fills the goal from weight and activity', (
    tester,
  ) async {
    await tester.pumpWidget(_host(_FakeSettingsActions()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '70');
    await tester.pump();
    await _tapText(tester, 'Suggest my goal');
    await tester.pump();

    expect(find.text('2,450 ml'), findsOneWidget);
  });
}
