import 'drink_category.dart';
import 'hydration.dart';
import 'log_entry.dart';
import 'streaks.dart';

/// Effective hydration (ml) per local day. Days without entries are absent.
Map<DateTime, double> dailyTotals(
  List<LogEntry> entries,
  Map<String, DrinkCategory> categoriesById,
) {
  final totals = <DateTime, double>{};
  for (final entry in entries) {
    if (entry.deleted) continue;
    final category = categoriesById[entry.categoryId];
    if (category == null || category.deleted) continue;
    final day = dateOnly(entry.loggedAt);
    totals.update(
      day,
      (ml) => ml + effectiveHydrationMl(entry, category),
      ifAbsent: () => effectiveHydrationMl(entry, category),
    );
  }
  return totals;
}

Set<DateTime> daysMeetingGoal(Map<DateTime, double> totals, int goalMl) => {
  for (final MapEntry(:key, :value) in totals.entries)
    if (value >= goalMl) key,
};

enum Achievement {
  firstDrink('First drink', 'Log your first drink'),
  goalReached('Goal reached', 'Hit your daily goal once'),
  streak3('3-day streak', 'Hit your goal 3 days in a row'),
  streak7('7-day streak', 'Hit your goal 7 days in a row'),
  streak30('30-day streak', 'Hit your goal 30 days in a row');

  const Achievement(this.title, this.description);

  final String title;
  final String description;
}

Set<Achievement> earnedAchievements({
  required int entryCount,
  required int goalDayCount,
  required int longestStreakDays,
}) => {
  if (entryCount > 0) Achievement.firstDrink,
  if (goalDayCount > 0) Achievement.goalReached,
  if (longestStreakDays >= 3) Achievement.streak3,
  if (longestStreakDays >= 7) Achievement.streak7,
  if (longestStreakDays >= 30) Achievement.streak30,
};
