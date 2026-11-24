import 'drink_category.dart';
import 'log_entry.dart';

double effectiveHydrationMl(LogEntry entry, DrinkCategory category) =>
    entry.volumeMl * category.hydrationFactor;

Map<String, double> hydrationByCategory(
  List<LogEntry> entries,
  Map<String, DrinkCategory> categoriesById,
) {
  final result = <String, double>{};

  for (final entry in entries) {
    if (entry.deleted) continue;

    // A map lookup returns `DrinkCategory?`. After the null check below, Dart
    // "promotes" the local variable `category` to non-null, so no `!` is needed.
    final category = categoriesById[entry.categoryId];
    if (category == null || category.deleted) continue;

    // Add to the running total for this category, starting from 0 if absent.
    result.update(
      entry.categoryId,
      (total) => total + effectiveHydrationMl(entry, category),
      ifAbsent: () => effectiveHydrationMl(entry, category),
    );
  }

  return result;
}

double totalHydrationMl(Map<String, double> byCategory) =>
    byCategory.values.fold(0, (sum, ml) => sum + ml);
