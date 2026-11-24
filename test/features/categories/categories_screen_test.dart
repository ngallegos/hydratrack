import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/providers.dart';
import 'package:hydratrack/data/repositories/category_repository.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/features/categories/categories_screen.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:material_ui/material_ui.dart';

final _now = DateTime.utc(2026, 11, 23);

DrinkCategory _category(String id, String name, double factor, int order) =>
    DrinkCategory(
      id: id,
      name: name,
      colorValue: 0xFF2196F3,
      hydrationFactor: factor,
      sortOrder: order,
      updatedAt: _now,
      deviceId: 'test',
    );

class _FakeCategoryRepository extends Fake implements CategoryRepository {
  final upserted = <DrinkCategory>[];
  final deleted = <String>[];

  @override
  Future<void> upsert(DrinkCategory category) async => upserted.add(category);

  @override
  Future<void> softDelete(String id) async => deleted.add(id);
}

Widget _host(_FakeCategoryRepository repository) => ProviderScope(
  overrides: [
    categoriesProvider.overrideWith(
      (ref) => Stream.value([
        _category('water', 'Water', 1, 0),
        _category('coffee', 'Coffee', 0.8, 1),
      ]),
    ),
    categoryRepositoryProvider.overrideWithValue(repository),
  ],
  child: const MaterialApp(home: CategoriesScreen()),
);

void main() {
  testWidgets('lists categories with their hydration level', (tester) async {
    await tester.pumpWidget(_host(_FakeCategoryRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Water'), findsOneWidget);
    expect(find.text('100% hydration'), findsOneWidget);
    expect(find.text('80% hydration'), findsOneWidget);
  });

  testWidgets('adds a category after the existing ones', (tester) async {
    final repository = _FakeCategoryRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add category'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Save')),
      isA<FilledButton>().having((b) => b.onPressed, 'onPressed', isNull),
    );

    await tester.enterText(find.byType(TextField), '  Kombucha ');
    await tester.tap(find.byKey(const Key('color-${0xFF8E24AA}')));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = repository.upserted.single;
    expect(saved.name, 'Kombucha');
    expect(saved.colorValue, 0xFF8E24AA);
    expect(saved.hydrationFactor, 1);
    expect(saved.sortOrder, 2);
  });

  testWidgets('edits an existing category in place', (tester) async {
    final repository = _FakeCategoryRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('category-coffee')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Espresso');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = repository.upserted.single;
    expect(saved.id, 'coffee');
    expect(saved.name, 'Espresso');
    expect(saved.hydrationFactor, 0.8);
  });

  testWidgets('deleting asks for confirmation first', (tester) async {
    final repository = _FakeCategoryRepository();
    await tester.pumpWidget(_host(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('category-coffee')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repository.deleted, isEmpty);

    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(repository.deleted, ['coffee']);
  });
}
