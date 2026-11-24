import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/log_entry.dart';
import '../../domain/streaks.dart';

class SelectedDay extends Notifier<DateTime> {
  @override
  DateTime build() => dateOnly(DateTime.now());

  void select(DateTime day) => state = dateOnly(day);

  void shift(int days) =>
      state = DateTime(state.year, state.month, state.day + days);
}

final selectedDayProvider = NotifierProvider<SelectedDay, DateTime>(
  SelectedDay.new,
);

final selectedDayEntriesProvider = StreamProvider<List<LogEntry>>(
  (ref) =>
      ref.watch(logRepositoryProvider).watchDay(ref.watch(selectedDayProvider)),
);
