import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/streaks.dart';

Set<DateTime> _days(List<int> dayOfNovember) => {
  for (final d in dayOfNovember) DateTime(2026, 11, d),
};

void main() {
  final today = DateTime(2026, 11, 23, 15, 30);

  group('currentStreak', () {
    test('is 0 with no goal days', () {
      expect(currentStreak(goalDays: {}, today: today), 0);
    });

    test('counts consecutive days ending today', () {
      expect(currentStreak(goalDays: _days([21, 22, 23]), today: today), 3);
    });

    test('stays alive when only today is missing', () {
      expect(currentStreak(goalDays: _days([20, 21, 22]), today: today), 3);
    });

    test('ends at a gap', () {
      expect(
        currentStreak(goalDays: _days([18, 19, 21, 22, 23]), today: today),
        3,
      );
    });

    test('is 0 when yesterday and today are both missing', () {
      expect(currentStreak(goalDays: _days([19, 20, 21]), today: today), 0);
    });

    test('crosses a month boundary', () {
      final goalDays = {
        DateTime(2026, 10, 30),
        DateTime(2026, 10, 31),
        DateTime(2026, 11),
      };

      expect(
        currentStreak(goalDays: goalDays, today: DateTime(2026, 11, 1)),
        3,
      );
    });

    test('ignores days after today', () {
      expect(currentStreak(goalDays: _days([22, 23, 24, 25]), today: today), 2);
    });
  });

  group('longestStreak', () {
    test('is 0 for no days', () {
      expect(longestStreak({}), 0);
    });

    test('finds the longest run regardless of order', () {
      expect(longestStreak(_days([9, 3, 4, 5, 6, 8, 10, 11])), 4);
    });

    test('handles a single day', () {
      expect(longestStreak(_days([5])), 1);
    });
  });
}
