import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/features/avatar/avatar_band.dart';

DrinkCategory _category(String id, int color, int order) => DrinkCategory(
  id: id,
  name: id,
  colorValue: color,
  hydrationFactor: 1,
  sortOrder: order,
  updatedAt: DateTime.utc(2026),
  deviceId: 'test',
);

void main() {
  final water = _category('water', 0xFF2196F3, 0);
  final coffee = _category('coffee', 0xFF795548, 1);

  group('computeAvatarBands', () {
    test('stacks bands in sort order as fractions of the goal', () {
      final bands = computeAvatarBands(
        hydrationByCategory: {'coffee': 500, 'water': 1000},
        categories: [coffee, water],
        goalMl: 2000,
      );

      expect(bands.map((b) => b.categoryId), ['water', 'coffee']);
      expect(bands[0].start, 0);
      expect(bands[0].end, 0.5);
      expect(bands[1].start, 0.5);
      expect(bands[1].end, 0.75);
      expect(bands[1].colorValue, 0xFF795548);
    });

    test('clips overflow at the top of the avatar', () {
      final bands = computeAvatarBands(
        hydrationByCategory: {'water': 1500, 'coffee': 1000},
        categories: [water, coffee],
        goalMl: 2000,
      );

      expect(bands.last.end, 1);
      expect(bands.last.start, 0.75);
    });

    test('drops a band that starts beyond the goal', () {
      final bands = computeAvatarBands(
        hydrationByCategory: {'water': 2000, 'coffee': 500},
        categories: [water, coffee],
        goalMl: 2000,
      );

      expect(bands.map((b) => b.categoryId), ['water']);
    });

    test('ignores empty categories and non-positive goals', () {
      expect(
        computeAvatarBands(
          hydrationByCategory: {'water': 0},
          categories: [water],
          goalMl: 2000,
        ),
        isEmpty,
      );
      expect(
        computeAvatarBands(
          hydrationByCategory: {'water': 500},
          categories: [water],
          goalMl: 0,
        ),
        isEmpty,
      );
    });
  });

  group('lerpAvatarBands', () {
    const waterBand = AvatarBand(
      categoryId: 'water',
      colorValue: 1,
      start: 0,
      end: 0.4,
    );
    const grownWater = AvatarBand(
      categoryId: 'water',
      colorValue: 1,
      start: 0,
      end: 0.8,
    );
    const coffeeBand = AvatarBand(
      categoryId: 'coffee',
      colorValue: 2,
      start: 0.8,
      end: 1,
    );

    test('interpolates matching bands', () {
      final result = lerpAvatarBands([waterBand], [grownWater], 0.5);

      expect(result.single.end, closeTo(0.6, 0.0001));
    });

    test('new band grows from zero height at its start', () {
      final result = lerpAvatarBands([grownWater], [grownWater, coffeeBand], 0);

      final coffee = result.singleWhere((b) => b.categoryId == 'coffee');
      expect(coffee.start, 0.8);
      expect(coffee.end, 0.8);
    });

    test('removed band shrinks to zero height', () {
      final result = lerpAvatarBands([grownWater, coffeeBand], [grownWater], 1);

      final coffee = result.singleWhere((b) => b.categoryId == 'coffee');
      expect(coffee.end, coffee.start);
    });

    test('t=0 and t=1 reproduce the endpoints', () {
      expect(lerpAvatarBands([waterBand], [grownWater], 0).single.end, 0.4);
      expect(lerpAvatarBands([waterBand], [grownWater], 1).single.end, 0.8);
    });
  });
}
