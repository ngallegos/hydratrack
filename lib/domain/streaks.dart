DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

DateTime previousDay(DateTime day) =>
    DateTime(day.year, day.month, day.day - 1);

// EXERCISE: current streak of consecutive days that met the goal.
//
// [goalDays] holds date-only (midnight, local) days on which the goal was met.
// [today] may include a time; use dateOnly(today).
//
//  - count back from today while each day is in goalDays
//  - if today is not (yet) in goalDays, the streak is still alive: start
//    counting from yesterday instead, because today isn't over
//  - a gap of one missed day ends the streak
//  - use previousDay() to step back (it is safe across daylight-saving changes)
//
// See test/domain/streaks_test.dart.
int currentStreak({required Set<DateTime> goalDays, required DateTime today}) {
  throw UnimplementedError('Exercise: implement currentStreak');
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
