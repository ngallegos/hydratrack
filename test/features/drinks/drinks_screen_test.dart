import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/providers.dart';
import 'package:hydratrack/data/repositories/drink_repository.dart';
import 'package:hydratrack/domain/drink.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/features/drinks/drinks_providers.dart';
import 'package:hydratrack/features/drinks/drinks_screen.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:material_ui/material_ui.dart';

final _now = DateTime.utc(2026, 11, 23);

DrinkCategory _category(String id, String name, int order) => DrinkCategory(
  id: id,
  name: name,
  colorValue: 0xFF2196F3,
  hydrationFactor: 1,
  sortOrder: order,
  updatedAt: _now,
  deviceId: 'test',
);

Drink _drink(String id, String categoryId, String name, int ml, bool starred) =>
    Drink(
      id: id,
      categoryId: categoryId,
      name: name,
      volumeMl: ml,
      starred: starred,
      updatedAt: _now,
      deviceId: 'test',
    );

class _FakeDrinkRepository extends Fake implements DrinkRepository {
  final upserted = <Drink>[];
  final starChanges = <(String, bool)>[];
  final deleted = <String>[];

  @override
  Future<void> upsert(Drink drink) async => upserted.add(drink);

  @override
  Future<void> setStarred(String id, {required bool starred}) async =>
      starChanges.add((id, starred));

  @override
  Future<void> softDelete(String id) async => deleted.add(id);
}

Widget _host(_FakeDrinkRepository repository) => ProviderScope(
  overrides: [
    categoriesProvider.overrideWith(
      (ref) => Stream.value([
        _category('water', 'Water', 0),
        _category('coffee', 'Coffee', 1),
      ]),
    ),
    allDrinksProvider.overrideWith(
      (ref) => Stream.value([
        _drink('glass', 'water', 'Glass of water', 250, true),
        _drink('mug', 'coffee', 'Mug of coffee', 240, false),
      ]),
    ),
    drinkRepositoryProvider.overrideWithValue(repository),
  ],
  child: const MaterialApp(home: DrinksScreen()),
);

void main() {
  testWidgets('lists drinks with category and volume', (tester) async {
    await tester.pumpWidget(_host(_FakeDrinkRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Glass of water'), findsOneWidget);
    expect(find.text('Water · 250 ml'), findsOneWidget);
    expect(find.text('Coffee · 240 ml'), findsOneWidget);
  });

  testWidgets('tapping a star toggles quick-log membership', (tester) async {
    final repository = _FakeDrinkRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('star-glass')));
    await tester.tap(find.byKey(const Key('star-mug')));

    expect(repository.starChanges, [('glass', false), ('mug', true)]);
  });

  testWidgets('adds a starred drink in the chosen category', (tester) async {
    final repository = _FakeDrinkRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add drink'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Flat white');
    await tester.tap(find.byKey(const Key('category-coffee')));
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = repository.upserted.single;
    expect(saved.name, 'Flat white');
    expect(saved.categoryId, 'coffee');
    expect(saved.volumeMl, 250);
    expect(saved.starred, isTrue);
  });

  testWidgets('edits and deletes an existing drink', (tester) async {
    final repository = _FakeDrinkRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('drink-mug')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Big mug');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(repository.upserted.single.id, 'mug');
    expect(repository.upserted.single.name, 'Big mug');
    expect(repository.upserted.single.categoryId, 'coffee');

    await tester.tap(find.byKey(const Key('drink-glass')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(repository.deleted, ['glass']);
  });
}
