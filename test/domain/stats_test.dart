import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';
import 'package:hydratrack/domain/stats.dart';

final _stamp = DateTime.utc(2026);

DrinkCategory _category(String id, double factor, {bool deleted = false}) =>
    DrinkCategory(
      id: id,
      name: id,
      colorValue: 0,
      hydrationFactor: factor,
      sortOrder: 0,
      updatedAt: _stamp,
      deviceId: 't',
      deleted: deleted,
    );

LogEntry _entry(String category, int ml, DateTime at, {bool deleted = false}) =>
    LogEntry(
      id: '$category$ml${at.microsecondsSinceEpoch}',
      categoryId: category,
      volumeMl: ml,
      loggedAt: at,
      updatedAt: _stamp,
      deviceId: 't',
      deleted: deleted,
    );

void main() {
  final categories = {
    'water': _category('water', 1),
    'coffee': _category('coffee', 0.5),
    'gone': _category('gone', 1, deleted: true),
  };

  group('dailyTotals', () {
    test('sums effective hydration per local day', () {
      final totals = dailyTotals([
        _entry('water', 500, DateTime(2026, 11, 22, 8)),
        _entry('coffee', 200, DateTime(2026, 11, 22, 23, 59)),
        _entry('water', 300, DateTime(2026, 11, 23, 0, 1)),
      ], categories);

      expect(totals, {
        DateTime(2026, 11, 22): 600,
        DateTime(2026, 11, 23): 300,
      });
    });

    test('skips deleted entries and deleted or unknown categories', () {
      final at = DateTime(2026, 11, 22, 8);

      final totals = dailyTotals([
        _entry('water', 500, at, deleted: true),
        _entry('gone', 500, at),
        _entry('mystery', 500, at),
      ], categories);

      expect(totals, isEmpty);
    });
  });

  test('daysMeetingGoal includes days at or above the goal', () {
    final days = daysMeetingGoal({
      DateTime(2026, 11, 20): 1999,
      DateTime(2026, 11, 21): 2000,
      DateTime(2026, 11, 22): 3000,
    }, 2000);

    expect(days, {DateTime(2026, 11, 21), DateTime(2026, 11, 22)});
  });

  group('earnedAchievements', () {
    test('earns nothing with no activity', () {
      expect(
        earnedAchievements(
          entryCount: 0,
          goalDayCount: 0,
          longestStreakDays: 0,
        ),
        isEmpty,
      );
    });

    test('earns first drink and goal reached', () {
      expect(
        earnedAchievements(
          entryCount: 4,
          goalDayCount: 1,
          longestStreakDays: 1,
        ),
        {Achievement.firstDrink, Achievement.goalReached},
      );
    });

    test('streak achievements stack by threshold', () {
      final earned = earnedAchievements(
        entryCount: 100,
        goalDayCount: 8,
        longestStreakDays: 7,
      );

      expect(earned, containsAll([Achievement.streak3, Achievement.streak7]));
      expect(earned, isNot(contains(Achievement.streak30)));
    });
  });
}
