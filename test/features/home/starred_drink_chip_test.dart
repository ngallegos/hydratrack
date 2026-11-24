import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/features/home/starred_drink_chip.dart';
import 'package:material_ui/material_ui.dart';

final _now = DateTime.utc(2026, 11, 23);

final _drink = Drink(
  id: 'water-glass',
  categoryId: 'water',
  name: 'Glass of water',
  volumeMl: 250,
  starred: true,
  updatedAt: _now,
  deviceId: 'test',
);

final _category = DrinkCategory(
  id: 'water',
  name: 'Water',
  colorValue: 0xFF2196F3,
  hydrationFactor: 1,
  sortOrder: 0,
  updatedAt: _now,
  deviceId: 'test',
);

Widget _host(VoidCallback onTap) => MaterialApp(
  home: Scaffold(
    body: StarredDrinkChip(drink: _drink, category: _category, onTap: onTap),
  ),
);

void main() {
  testWidgets('shows name and volume', (tester) async {
    await tester.pumpWidget(_host(() {}));

    expect(find.text('Glass of water · 250 ml'), findsOneWidget);
  });

  testWidgets('shows a dot in the category color', (tester) async {
    await tester.pumpWidget(_host(() {}));

    final dot = tester.widget<Container>(find.byKey(const Key('category-dot')));
    final decoration = dot.decoration! as BoxDecoration;
    expect(decoration.color, const Color(0xFF2196F3));
    expect(decoration.shape, BoxShape.circle);
  });

  testWidgets('calls onTap when pressed', (tester) async {
    var taps = 0;
    await tester.pumpWidget(_host(() => taps++));

    await tester.tap(find.byType(StarredDrinkChip));

    expect(taps, 1);
  });
}
