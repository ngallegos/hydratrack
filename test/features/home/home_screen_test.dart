import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/providers.dart';
import 'package:hydratrack/data/repositories/log_repository.dart';
import 'package:hydratrack/domain/drink.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:hydratrack/features/home/home_screen.dart';
import 'package:hydratrack/features/home/starred_drink_chip.dart';
import 'package:material_ui/material_ui.dart';

final _now = DateTime.utc(2026, 11, 23);

DrinkCategory _category(String id, String name, int color, int order) =>
    DrinkCategory(
      id: id,
      name: name,
      colorValue: color,
      hydrationFactor: 1,
      sortOrder: order,
      updatedAt: _now,
      deviceId: 'test',
    );

final _water = _category('water', 'Water', 0xFF2196F3, 0);
final _coffee = _category('coffee', 'Coffee', 0xFF795548, 1);

final _glass = Drink(
  id: 'water-glass',
  categoryId: 'water',
  name: 'Glass of water',
  volumeMl: 250,
  starred: true,
  updatedAt: _now,
  deviceId: 'test',
);

class _FakeLogRepository extends Fake implements LogRepository {
  final added = <({String categoryId, int volumeMl})>[];
  final deleted = <String>[];

  @override
  Future<LogEntry> add({
    required String categoryId,
    required int volumeMl,
    DateTime? at,
  }) async {
    added.add((categoryId: categoryId, volumeMl: volumeMl));
    return LogEntry(
      id: 'entry-${added.length}',
      categoryId: categoryId,
      volumeMl: volumeMl,
      loggedAt: _now,
      updatedAt: _now,
      deviceId: 'test',
    );
  }

  @override
  Future<void> softDelete(String id) async => deleted.add(id);
}

Widget _host(
  _FakeLogRepository logs, {
  Map<String, double> hydration = const {},
  int goalMl = 2500,
}) => ProviderScope(
  overrides: [
    categoriesProvider.overrideWith((ref) => Stream.value([_water, _coffee])),
    starredDrinksProvider.overrideWith((ref) => Stream.value([_glass])),
    todayHydrationProvider.overrideWithValue(hydration),
    dailyGoalMlProvider.overrideWithValue(goalMl),
    logRepositoryProvider.overrideWithValue(logs),
  ],
  child: const MaterialApp(home: HomeScreen()),
);

// Animations begin on the first frame after they are scheduled, so pump once
// to start them and again to run them to completion. pumpAndSettle would never
// return because the avatar's wave animation repeats forever.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('shows progress toward the goal', (tester) async {
    await tester.pumpWidget(
      _host(_FakeLogRepository(), hydration: {'water': 1250}),
    );
    await _settle(tester);

    expect(find.text('1,250 ml / 2,500 ml'), findsOneWidget);
    expect(find.text('Goal reached'), findsNothing);
    expect(find.bySemanticsLabel('1,250 ml of 2,500 ml today'), findsOneWidget);
  });

  testWidgets('announces when the goal is reached', (tester) async {
    await tester.pumpWidget(
      _host(_FakeLogRepository(), hydration: {'water': 2600}),
    );
    await _settle(tester);

    expect(find.text('Goal reached'), findsOneWidget);
  });

  testWidgets('tapping a starred drink logs it and offers undo', (
    tester,
  ) async {
    final logs = _FakeLogRepository();
    await tester.pumpWidget(_host(logs));
    await _settle(tester);

    await tester.tap(find.byType(StarredDrinkChip));
    await _settle(tester);

    expect(logs.added.single, (categoryId: 'water', volumeMl: 250));
    expect(find.text('Logged 250 ml Water'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await _settle(tester);

    expect(logs.deleted, ['entry-1']);
  });

  testWidgets('manual log sheet logs the chosen category and volume', (
    tester,
  ) async {
    final logs = _FakeLogRepository();
    await tester.pumpWidget(_host(logs));
    await _settle(tester);

    await tester.tap(find.text('Log drink'));
    await _settle(tester);
    await tester.tap(find.byKey(const Key('category-coffee')));
    await _settle(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Log'));
    await _settle(tester);

    expect(logs.added.single, (categoryId: 'coffee', volumeMl: 250));
    expect(find.text('Logged 250 ml Coffee'), findsOneWidget);
    expect(find.text('Log a drink'), findsNothing);
  });
}
