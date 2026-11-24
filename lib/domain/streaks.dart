DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

DateTime previousDay(DateTime day) =>
    DateTime(day.year, day.month, day.day - 1);

int currentStreak({required Set<DateTime> goalDays, required DateTime today}) {
  var day = dateOnly(today);
  if (!goalDays.contains(day)) day = previousDay(day);
  int streak = 0;

  while (goalDays.contains(day)) {
    streak++;
    day = previousDay(day);
  }

  return streak;
}

int longestStreak(Set<DateTime> goalDays) {
  final sorted = goalDays.map(dateOnly).toSet().toList()..sort();
  var longest = 0;
  var run = 0;
  DateTime? previous;
  for (final day in sorted) {
    run = previous != null && previousDay(day) == previous ? run + 1 : 1;
    if (run > longest) longest = run;
    previous = day;
  }
  return longest;
}
