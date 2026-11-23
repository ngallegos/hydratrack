import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/providers.dart';
import '../../domain/drink_category.dart';
import '../../domain/log_entry.dart';
import '../../domain/stats.dart';
import '../../domain/streaks.dart';
import '../home/home_providers.dart';

part 'stats_providers.freezed.dart';

const statsWindowDays = 365;

@freezed
abstract class StatsData with _$StatsData {
  const factory StatsData({
    required Map<DateTime, double> dailyTotals,
    required int goalMl,
    required int currentStreak,
    required int longestStreak,
    required Set<Achievement> achievements,
  }) = _StatsData;
}

StatsData buildStatsData({
  required List<LogEntry> entries,
  required Map<String, DrinkCategory> categoriesById,
  required int goalMl,
  required DateTime today,
}) {
  final totals = dailyTotals(entries, categoriesById);
  final goalDays = daysMeetingGoal(totals, goalMl);
  final longest = longestStreak(goalDays);
  return StatsData(
    dailyTotals: totals,
    goalMl: goalMl,
    currentStreak: currentStreak(goalDays: goalDays, today: today),
    longestStreak: longest,
    achievements: earnedAchievements(
      entryCount: entries.length,
      goalDayCount: goalDays.length,
      longestStreakDays: longest,
    ),
  );
}

final statsEntriesProvider = StreamProvider<List<LogEntry>>((ref) {
  final today = ref.watch(todayProvider).value;
  if (today == null) return const Stream.empty();
  final start = DateTime(today.year, today.month, today.day - statsWindowDays);
  return ref.watch(logRepositoryProvider).watchSince(start);
});

final statsDataProvider = Provider<StatsData?>((ref) {
  final entries = ref.watch(statsEntriesProvider).value;
  final categories = ref.watch(categoriesProvider).value;
  final today = ref.watch(todayProvider).value;
  if (entries == null || categories == null || today == null) return null;
  return buildStatsData(
    entries: entries,
    categoriesById: {for (final c in categories) c.id: c},
    goalMl: ref.watch(dailyGoalMlProvider),
    today: today,
  );
});
