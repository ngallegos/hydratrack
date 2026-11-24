import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/volume_unit.dart';
import 'package:hydratrack/features/avatar/avatar_shape.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/features/settings/settings_screen.dart';
import 'package:material_ui/material_ui.dart';

class _FakeSettingsActions extends Fake implements SettingsActions {
  final goals = <int>[];
  final shapes = <AvatarShape>[];
  final units = <VolumeUnit>[];

  @override
  Future<void> setDailyGoalMl(int ml) async => goals.add(ml);

  @override
  Future<void> setVolumeUnit(VolumeUnit unit) async => units.add(unit);

  @override
  Future<void> setAvatarShape(AvatarShape shape) async => shapes.add(shape);
}

Widget _host(
  _FakeSettingsActions actions, {
  int goalMl = 2500,
  VolumeUnit unit = VolumeUnit.ml,
}) => ProviderScope(
  overrides: [
    appSettingsProvider.overrideWith(
      (ref) => Stream.value(AppSettings(dailyGoalMl: goalMl, volumeUnit: unit)),
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

  testWidgets('choosing fluid ounces saves the unit', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.text('fl oz'));
    await tester.pumpAndSettle();

    expect(actions.units, [VolumeUnit.flOz]);
  });

  testWidgets('shows the goal in the chosen unit', (tester) async {
    await tester.pumpWidget(
      _host(_FakeSettingsActions(), goalMl: 2500, unit: VolumeUnit.flOz),
    );
    await tester.pumpAndSettle();

    expect(find.text('84.5 fl oz'), findsOneWidget);
  });

  testWidgets('the goal dialog works in ounces and saves millilitres', (
    tester,
  ) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions, unit: VolumeUnit.flOz));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daily goal'));
    await tester.pumpAndSettle();
    expect(find.text('84.5 fl oz'), findsWidgets);
    await tester.drag(find.byType(Slider), const Offset(60, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(actions.goals.single, greaterThan(2500));
  });
}
