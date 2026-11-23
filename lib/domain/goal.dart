enum ActivityLevel {
  sedentary(label: 'Sedentary', multiplier: 1.0),
  light(label: 'Lightly active', multiplier: 1.1),
  moderate(label: 'Moderately active', multiplier: 1.2),
  veryActive(label: 'Very active', multiplier: 1.3);

  const ActivityLevel({required this.label, required this.multiplier});

  final String label;
  final double multiplier;
}

const mlPerKg = 35;
const minGoalMl = 1000;
const maxGoalMl = 6000;
const goalStepMl = 50;

// EXERCISE: suggest a daily hydration goal.
//
// goal = weightKg * mlPerKg * activity.multiplier, then
//  - rounded to the nearest goalStepMl (50 ml)
//  - clamped to minGoalMl..maxGoalMl
//  - throws ArgumentError when weightKg is not positive
//
// See test/domain/goal_test.dart for worked examples.
int suggestedDailyGoalMl({
  required double weightKg,
  required ActivityLevel activity,
}) {
  throw UnimplementedError('Exercise: implement suggestedDailyGoalMl');
}
