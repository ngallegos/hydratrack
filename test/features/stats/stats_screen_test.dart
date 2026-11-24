import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';
import 'package:hydratrack/domain/stats.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:hydratrack/features/stats/stats_providers.dart';
import 'package:hydratrack/features/stats/stats_screen.dart';
import 'package:material_ui/material_ui.dart';

final _today = DateTime(2026, 11, 23);

final _stats = StatsData(
  dailyTotals: {DateTime(2026, 11, 22): 2500, DateTime(2026, 11, 23): 1500},
  goalMl: 2500,
  currentStreak: 2,
  longestStreak: 5,
  achievements: {Achievement.firstDrink, Achievement.goalReached},
);

Widget _host(StatsData? stats) => ProviderScope(
  overrides: [
    statsDataProvider.overrideWithValue(stats),
    todayProvider.overrideWith((ref) => Stream.value(_today)),
  ],
  child: const MaterialApp(home: StatsScreen()),
);

Icon _achievementIcon(WidgetTester tester, Achievement a) =>
    tester.widget<Icon>(
      find.descendant(
        of: find.byKey(Key('achievement-${a.name}')),
        matching: find.byType(Icon),
      ),
    );

void main() {
  testWidgets('shows a progress indicator while loading', (tester) async {
    await tester.pumpWidget(_host(null));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('summarises the week and draws a chart', (tester) async {
    await tester.pumpWidget(_host(_stats));
    await tester.pumpAndSettle();

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.text('571 ml'), findsOneWidget);
    expect(find.text('1 / 7 days'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('switching to month widens the window', (tester) async {
    await tester.pumpWidget(_host(_stats));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Month'));
    await tester.pumpAndSettle();

    expect(find.text('1 / 30 days'), findsOneWidget);
    expect(find.text('133 ml'), findsOneWidget);
  });

  testWidgets('earned achievements are unlocked, others locked', (
    tester,
  ) async {
    await tester.pumpWidget(_host(_stats));
    await tester.pumpAndSettle();

    expect(
      _achievementIcon(tester, Achievement.goalReached).icon,
      Icons.emoji_events,
    );
    expect(
      _achievementIcon(tester, Achievement.streak7).icon,
      Icons.lock_outline,
    );
  });

  // Depends on the currentStreak exercise (lib/domain/streaks.dart).
  test('buildStatsData combines totals, goal days and streaks', () {
    final category = DrinkCategory(
      id: 'water',
      name: 'Water',
      colorValue: 0,
      hydrationFactor: 1,
      sortOrder: 0,
      updatedAt: DateTime.utc(2026),
      deviceId: 't',
    );
    LogEntry entry(int day, int ml) => LogEntry(
      id: 'e$day',
      categoryId: 'water',
      volumeMl: ml,
      loggedAt: DateTime(2026, 11, day, 10),
      updatedAt: DateTime.utc(2026),
      deviceId: 't',
    );

    final stats = buildStatsData(
      entries: [entry(21, 2500), entry(22, 3000), entry(23, 500)],
      categoriesById: {'water': category},
      goalMl: 2500,
      today: _today,
    );

    expect(stats.dailyTotals[DateTime(2026, 11, 22)], 3000);
    expect(stats.currentStreak, 2);
    expect(stats.longestStreak, 2);
    expect(stats.achievements, {
      Achievement.firstDrink,
      Achievement.goalReached,
    });
  });
}
