import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/avatar/avatar_shape.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/features/settings/settings_screen.dart';
import 'package:material_ui/material_ui.dart';

class _FakeSettingsActions extends Fake implements SettingsActions {
  final goals = <int>[];
  final shapes = <AvatarShape>[];

  @override
  Future<void> setDailyGoalMl(int ml) async => goals.add(ml);

  @override
  Future<void> setAvatarShape(AvatarShape shape) async => shapes.add(shape);
}

Widget _host(_FakeSettingsActions actions, {int goalMl = 2500}) =>
    ProviderScope(
      overrides: [
        appSettingsProvider.overrideWith(
          (ref) => Stream.value(AppSettings(dailyGoalMl: goalMl)),
        ),
        settingsActionsProvider.overrideWithValue(actions),
      ],
      child: const MaterialApp(home: SettingsScreen()),
    );

void main() {
  testWidgets('shows the current goal', (tester) async {
    await tester.pumpWidget(_host(_FakeSettingsActions(), goalMl: 3000));
    await tester.pumpAndSettle();

    expect(find.text('3,000 ml'), findsOneWidget);
  });

  testWidgets('picking an avatar saves it', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('avatar-fish')));
    await tester.pumpAndSettle();

    expect(actions.shapes, [AvatarShape.fish]);
  });

  testWidgets('editing the goal saves the new value', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daily goal'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(Slider), const Offset(60, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(actions.goals, hasLength(1));
    expect(actions.goals.single, greaterThan(2500));
    expect(actions.goals.single % 50, 0);
  });

  testWidgets('cancelling the goal dialog saves nothing', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daily goal'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(actions.goals, isEmpty);
  });
}
