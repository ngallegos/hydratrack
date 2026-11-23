import 'drink_category.dart';
import 'log_entry.dart';

double effectiveHydrationMl(LogEntry entry, DrinkCategory category) =>
    entry.volumeMl * category.hydrationFactor;

// EXERCISE: effective hydration per category.
//
// Return a map of categoryId -> effective hydration in ml, where each entry
// contributes `volumeMl * category.hydrationFactor`.
//
// Rules (see test/domain/hydration_test.dart):
//  - skip entries that are deleted
//  - skip entries whose category is missing from [categoriesById]
//  - skip entries whose category is deleted
//  - categories with no entries are absent from the result
//
// effectiveHydrationMl (above) already does the volume * factor step.
Map<String, double> hydrationByCategory(
  List<LogEntry> entries,
  Map<String, DrinkCategory> categoriesById,
) {
  throw UnimplementedError('Exercise: implement hydrationByCategory');
}

double totalHydrationMl(Map<String, double> byCategory) =>
    byCategory.values.fold(0, (sum, ml) => sum + ml);
