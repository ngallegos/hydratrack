import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:hydratrack/main.dart';

void main() {
  testWidgets('app shows the home screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          categoriesProvider.overrideWith((ref) => Stream.value([])),
          starredDrinksProvider.overrideWith((ref) => Stream.value([])),
          todayHydrationProvider.overrideWithValue(const {}),
        ],
        child: const HydraTrackApp(),
      ),
    );
    await tester.pump();

    expect(find.text('HydraTrack'), findsOneWidget);
    expect(find.text('0 ml / 2,500 ml'), findsOneWidget);
  });
}
