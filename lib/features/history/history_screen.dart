import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../data/providers.dart';
import '../../domain/log_entry.dart';
import '../../domain/stats.dart';
import '../../domain/streaks.dart';
import '../home/home_providers.dart';
import '../log/log_sheet.dart';
import 'history_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(selectedDayProvider);
    final entries = ref.watch(selectedDayEntriesProvider).value ?? const [];
    final categoryList = ref.watch(categoriesProvider).value ?? const [];
    final categories = {for (final c in categoryList) c.id: c};
    final totalMl = dailyTotals(entries, categories)[day] ?? 0;
    final isToday = day == dateOnly(DateTime.now());
    final selectedDay = ref.read(selectedDayProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            tooltip: 'Previous day',
            icon: const Icon(Icons.chevron_left),
            onPressed: () => selectedDay.shift(-1),
          ),
          TextButton(
            onPressed: () => _pickDay(context, selectedDay, day),
            child: Text(
              isToday
                  ? 'Today'
                  : MaterialLocalizations.of(context).formatShortDate(day),
            ),
          ),
          IconButton(
            tooltip: 'Next day',
            icon: const Icon(Icons.chevron_right),
            onPressed: isToday ? null : () => selectedDay.shift(1),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              formatMl(totalMl.round()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('Nothing logged this day'))
                : ListView(
                    children: [
                      for (final entry in entries)
                        if (categories[entry.categoryId] case final category?)
                          Dismissible(
                            key: Key('entry-${entry.id}'),
                            direction: DismissDirection.endToStart,
                            background: const ColoredBox(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onDismissed: (_) => _delete(context, ref, entry),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(category.colorValue),
                              ),
                              title: Text(
                                '${formatMl(entry.volumeMl)} ${category.name}',
                              ),
                              subtitle: Text(
                                TimeOfDay.fromDateTime(entry.loggedAt)
                                    .format(context),
                              ),
                              onTap: () =>
                                  showLogSheet(context, existing: entry),
                            ),
                          ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showLogSheet(context, day: day),
        icon: const Icon(Icons.add),
        label: const Text('Add entry'),
      ),
    );
  }

  Future<void> _pickDay(
    BuildContext context,
    SelectedDay selectedDay,
    DateTime current,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) selectedDay.select(picked);
  }

  void _delete(BuildContext context, WidgetRef ref, LogEntry entry) {
    final repository = ref.read(logRepositoryProvider);
    repository.softDelete(entry.id);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted ${formatMl(entry.volumeMl)}'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => repository.restore(entry.id),
          ),
        ),
      );
  }
}
