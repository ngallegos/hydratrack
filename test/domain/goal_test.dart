import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/goal.dart';

void main() {
  group('suggestedDailyGoalMl', () {
    test('uses 35 ml per kg for a sedentary person', () {
      expect(
        suggestedDailyGoalMl(weightKg: 70, activity: ActivityLevel.sedentary),
        2450,
      );
    });

    test('scales by activity level and rounds to the nearest 50 ml', () {
      expect(
        suggestedDailyGoalMl(weightKg: 70, activity: ActivityLevel.light),
        2700,
      );
      expect(
        suggestedDailyGoalMl(weightKg: 70, activity: ActivityLevel.moderate),
        2950,
      );
      expect(
        suggestedDailyGoalMl(weightKg: 70, activity: ActivityLevel.veryActive),
        3200,
      );
    });

    test('clamps very low and very high results', () {
      expect(
        suggestedDailyGoalMl(weightKg: 20, activity: ActivityLevel.sedentary),
        minGoalMl,
      );
      expect(
        suggestedDailyGoalMl(weightKg: 200, activity: ActivityLevel.veryActive),
        maxGoalMl,
      );
    });

    test('rejects non-positive weight', () {
      expect(
        () => suggestedDailyGoalMl(
          weightKg: 0,
          activity: ActivityLevel.sedentary,
        ),
        throwsArgumentError,
      );
      expect(
        () => suggestedDailyGoalMl(
          weightKg: -5,
          activity: ActivityLevel.sedentary,
        ),
        throwsArgumentError,
      );
    });
  });
}
