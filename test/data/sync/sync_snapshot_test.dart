import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/sync_snapshot.dart';
import 'package:hydratrack/domain/drink.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';

void main() {
  test('survives a JSON text round trip with nested records', () {
    final stamp = DateTime.utc(2026, 11, 23, 12);
    final snapshot = SyncSnapshot(
      deviceId: 'dev-1',
      generatedAt: stamp,
      categories: [
        DrinkCategory(
          id: 'water',
          name: 'Water',
          colorValue: 0xFF2196F3,
          hydrationFactor: 1,
          sortOrder: 0,
          updatedAt: stamp,
          deviceId: 'dev-1',
        ),
      ],
      drinks: [
        Drink(
          id: 'glass',
          categoryId: 'water',
          name: 'Glass',
          volumeMl: 250,
          starred: true,
          updatedAt: stamp,
          deviceId: 'dev-1',
        ),
      ],
      entries: [
        LogEntry(
          id: 'e1',
          categoryId: 'water',
          volumeMl: 250,
          loggedAt: stamp,
          updatedAt: stamp,
          deviceId: 'dev-1',
          deleted: true,
        ),
      ],
    );

    final text = jsonEncode(snapshot.toJson());
    final restored = SyncSnapshot.fromJson(
      jsonDecode(text) as Map<String, dynamic>,
    );

    expect(restored, snapshot);
  });

  test('missing lists default to empty', () {
    final restored = SyncSnapshot.fromJson({
      'deviceId': 'd',
      'generatedAt': '2026-11-23T12:00:00.000Z',
    });

    expect(restored.entries, isEmpty);
    expect(restored.categories, isEmpty);
  });
}
