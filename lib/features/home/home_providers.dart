import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/drink.dart';
import '../../domain/drink_category.dart';
import '../../domain/hydration.dart';
import '../../domain/log_entry.dart';
import '../avatar/avatar_shape.dart';
import '../settings/app_settings.dart';
import '../settings/settings_providers.dart';

DateTime _dayOf(DateTime t) => DateTime(t.year, t.month, t.day);

/// The current local day, re-emitted when midnight passes.
final todayProvider = StreamProvider<DateTime>((ref) async* {
  var current = _dayOf(DateTime.now());
  yield current;
  await for (final _ in Stream<void>.periodic(const Duration(minutes: 1))) {
    final next = _dayOf(DateTime.now());
    if (next != current) {
      current = next;
      yield current;
    }
  }
});

final categoriesProvider = StreamProvider<List<DrinkCategory>>(
  (ref) => ref.watch(categoryRepositoryProvider).watchAll(),
);

final starredDrinksProvider = StreamProvider<List<Drink>>(
  (ref) => ref.watch(drinkRepositoryProvider).watchStarred(),
);

final todayEntriesProvider = StreamProvider<List<LogEntry>>((ref) {
  final day = ref.watch(todayProvider).value;
  if (day == null) return const Stream.empty();
  return ref.watch(logRepositoryProvider).watchDay(day);
});

final dailyGoalMlProvider = Provider<int>(
  (ref) =>
      ref.watch(appSettingsProvider.select((s) => s.value?.dailyGoalMl)) ??
      defaultDailyGoalMl,
);

final avatarShapeProvider = Provider<AvatarShape>(
  (ref) =>
      ref.watch(appSettingsProvider.select((s) => s.value?.avatarShape)) ??
      AvatarShape.bottle,
);

/// Effective hydration (ml, after hydration factors) per category for today.
final todayHydrationProvider = Provider<Map<String, double>>((ref) {
  final entries = ref.watch(todayEntriesProvider).value;
  final categories = ref.watch(categoriesProvider).value;
  if (entries == null || categories == null) return const {};
  return hydrationByCategory(entries, {for (final c in categories) c.id: c});
});
