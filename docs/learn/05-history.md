# 05 — History, stats and streaks

## Exercise (done)

`currentStreak` in `lib/domain/streaks.dart` is implemented and covered by `test/domain/streaks_test.dart`. The rules
are in the comment above it, and `longestStreak` right below is a worked example of walking dates.

Hints that were given:
- Start at `dateOnly(today)`. If that day is not in `goalDays`, start from `previousDay(...)` instead
- Loop while the current day is in the set, count, step back
- `Set.contains` on `DateTime` compares the instant, so every value must be date-only (midnight local); that's what
  `dateOnly` is for
- Why `DateTime(y, m, d - 1)` and not `day.subtract(Duration(days: 1))`? On a daylight-saving day a "day" is 23 or
  25 hours, so subtracting 24h can land on the wrong date. The constructor normalises overflow (`d - 1 == 0` becomes the
  last day of the previous month)

## Concepts

### Notifier (state you can change)
`class SelectedDay extends Notifier<DateTime>` plus `NotifierProvider` is Riverpod's way to hold mutable state with
methods (`shift`, `select`). `build()` returns the initial value, `state = ...` publishes a change. Analogy: a tiny
view model / `BehaviorSubject` with intent methods. Providers that depend on it (`selectedDayEntriesProvider`) are
rebuilt and re-subscribe to a new `watchDay` stream automatically.

### Pure functions for numbers, widgets for pixels
`dailyTotals`, `daysMeetingGoal`, `earnedAchievements`, `buildStatsData` take values and return values. The screens only
format and draw. This is why the stats logic is covered by plain `test(...)`, with no widget tree.

### Dart 3 pattern destructuring
`for (final MapEntry(:key, :value) in map.entries) if (value >= goal) key` pulls fields out in the loop header. Together
with collection-`if`/`for` inside `{...}` and `[...]` it replaces most LINQ-style pipelines.

### Charts
`fl_chart` builds charts from plain data objects: `BarChartData(barGroups: [...], extraLinesData: ...)`. Titles
(axis labels) are callbacks returning widgets. Everything is immutable and rebuilt on change; animations are handled by
the widget.

### Dismissible and undo
`Dismissible` wraps a list item and calls `onDismissed` after the swipe. It must have a unique `key`, and the item must
disappear from the data on the next build, otherwise Flutter throws "A dismissed Dismissible widget is still part of the
tree". Because our delete is a soft delete, the stream drops it immediately, and Undo is `restore(id)`.

### Reusing a widget in several modes
`LogSheet` covers log-now, back-dated and edit by taking optional parameters (`day`, `existing`) and deriving behaviour
from them. Prefer this over three near-identical widgets, but split it once the branches outnumber the shared code.

## Known simplifications
- Goal days use today's goal for every past day, so changing the goal rewrites past streaks:
  [#5](https://github.com/ngallegos/hydratrack/issues/5).
- Stats look back 365 days. This is a design choice, not tracked work.

## Docs
- [Riverpod Notifier](https://riverpod.dev/docs/concepts2/providers)
- [Dart patterns](https://dart.dev/language/patterns)
- [fl_chart](https://pub.dev/packages/fl_chart)
- [Dismissible](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
- [DateTime](https://api.dart.dev/stable/dart-core/DateTime-class.html)
