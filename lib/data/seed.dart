import '../domain/drink.dart';
import '../domain/drink_category.dart';
import 'repositories/category_repository.dart';
import 'repositories/drink_repository.dart';

final _epoch = DateTime.utc(2026);
const _seedDevice = 'seed';

DrinkCategory _category(
  String id,
  String name,
  int colorValue,
  double factor,
  int order,
) => DrinkCategory(
  id: id,
  name: name,
  colorValue: colorValue,
  hydrationFactor: factor,
  sortOrder: order,
  updatedAt: _epoch,
  deviceId: _seedDevice,
);

Drink _drink(
  String id,
  String categoryId,
  String name,
  int ml, {
  bool starred = false,
}) => Drink(
  id: id,
  categoryId: categoryId,
  name: name,
  volumeMl: ml,
  starred: starred,
  updatedAt: _epoch,
  deviceId: _seedDevice,
);

// Stable ids so every device seeds identical rows and sync never duplicates them.
final defaultCategories = [
  _category('water', 'Water', 0xFF2196F3, 1, 0),
  _category('sparkling', 'Sparkling water', 0xFF4DD0E1, 1, 1),
  _category('milk', 'Milk', 0xFFECEFF1, 1, 2),
  _category('tea', 'Tea', 0xFF8BC34A, 0.9, 3),
  _category('juice', 'Juice', 0xFFFF9800, 0.9, 4),
  _category('soda', 'Soda', 0xFFE53935, 0.85, 5),
  _category('coffee', 'Coffee', 0xFF795548, 0.8, 6),
  _category('beer', 'Beer', 0xFFFFC107, 0.6, 7),
  _category('wine', 'Wine', 0xFF8E24AA, 0.4, 8),
];

final defaultDrinks = [
  _drink('water-glass', 'water', 'Glass of water', 250, starred: true),
  _drink('water-bottle', 'water', 'Water bottle', 500, starred: true),
  _drink('coffee-mug', 'coffee', 'Mug of coffee', 240, starred: true),
  _drink('tea-cup', 'tea', 'Cup of tea', 240),
  _drink('juice-glass', 'juice', 'Glass of juice', 200),
];

Future<void> seedDefaults(
  CategoryRepository categories,
  DrinkRepository drinks,
) async {
  await categories.insertMissing(defaultCategories);
  await drinks.insertMissing(defaultDrinks);
}
