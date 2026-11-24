import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';

void main() {
  final now = DateTime.utc(2026, 11, 23, 12);

  test('DrinkCategory survives a JSON round trip', () {
    final category = DrinkCategory(
      id: 'c1',
      name: 'Coffee',
      colorValue: 0xFF795548,
      hydrationFactor: 0.8,
      sortOrder: 2,
      updatedAt: now,
      deviceId: 'd1',
    );

    expect(DrinkCategory.fromJson(category.toJson()), category);
  });

  test('Drink survives a JSON round trip and defaults flags to false', () {
    final drink = Drink(
      id: 'k1',
      categoryId: 'c1',
      name: 'Morning mug',
      volumeMl: 350,
      updatedAt: now,
      deviceId: 'd1',
    );

    final restored = Drink.fromJson(drink.toJson());

    expect(restored, drink);
    expect(restored.starred, isFalse);
    expect(restored.deleted, isFalse);
  });

  test('LogEntry survives a JSON round trip', () {
    final entry = LogEntry(
      id: 'e1',
      categoryId: 'c1',
      volumeMl: 250,
      loggedAt: now,
      updatedAt: now,
      deviceId: 'd1',
      deleted: true,
    );

    expect(LogEntry.fromJson(entry.toJson()), entry);
  });
}
