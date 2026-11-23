import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/hydration.dart';
import 'package:hydratrack/domain/log_entry.dart';

final _now = DateTime.utc(2026, 11, 23, 12);

DrinkCategory _category(String id, double factor, {bool deleted = false}) =>
    DrinkCategory(
      id: id,
      name: id,
      colorValue: 0xFF2196F3,
      hydrationFactor: factor,
      sortOrder: 0,
      updatedAt: _now,
      deviceId: 'test',
      deleted: deleted,
    );

LogEntry _entry(String categoryId, int ml, {bool deleted = false}) => LogEntry(
  id: '$categoryId-$ml',
  categoryId: categoryId,
  volumeMl: ml,
  loggedAt: _now,
  updatedAt: _now,
  deviceId: 'test',
  deleted: deleted,
);

void main() {
  final categories = {
    'water': _category('water', 1),
    'coffee': _category('coffee', 0.8),
    'gone': _category('gone', 1, deleted: true),
  };

  group('hydrationByCategory', () {
    test('applies the hydration factor and groups by category', () {
      final result = hydrationByCategory([
        _entry('water', 500),
        _entry('water', 250),
        _entry('coffee', 200),
      ], categories);

      expect(result['water'], 750);
      expect(result['coffee'], closeTo(160, 0.0001));
      expect(result.length, 2);
    });

    test('skips deleted entries', () {
      final result = hydrationByCategory([
        _entry('water', 500),
        _entry('water', 250, deleted: true),
      ], categories);

      expect(result['water'], 500);
    });

    test('skips unknown and deleted categories', () {
      final result = hydrationByCategory([
        _entry('mystery', 300),
        _entry('gone', 300),
      ], categories);

      expect(result, isEmpty);
    });

    test('returns empty map for no entries', () {
      expect(hydrationByCategory([], categories), isEmpty);
    });
  });

  test('totalHydrationMl sums all categories', () {
    expect(totalHydrationMl({'water': 500, 'coffee': 160}), 660);
  });
}
