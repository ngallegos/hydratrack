import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/main.dart';
import 'package:material_ui/material_ui.dart';

Widget _app({required bool onboardingDone}) => ProviderScope(
  overrides: [
    appSettingsProvider.overrideWith(
      (ref) => Stream.value(AppSettings(onboardingDone: onboardingDone)),
    ),
    categoriesProvider.overrideWith((ref) => Stream.value([])),
    starredDrinksProvider.overrideWith((ref) => Stream.value([])),
    todayHydrationProvider.overrideWithValue(const {}),
  ],
  child: const HydraTrackApp(),
);

void main() {
  testWidgets('shows the home screen once onboarding is done', (tester) async {
    await tester.pumpWidget(_app(onboardingDone: true));
    await tester.pump();
    await tester.pump();

    expect(find.text('HydraTrack'), findsOneWidget);
    expect(find.text('0 ml / 2,500 ml'), findsOneWidget);
  });

  testWidgets('first launch is redirected to onboarding', (tester) async {
    await tester.pumpWidget(_app(onboardingDone: false));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Welcome to HydraTrack'), findsOneWidget);
    expect(find.text('0 ml / 2,500 ml'), findsNothing);
  });
}
