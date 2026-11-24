import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/providers.dart';
import '../../domain/drink_category.dart';
import '../../domain/log_entry.dart';
import '../home/home_providers.dart';
import 'log_actions.dart';
import '../settings/settings_providers.dart';

/// Logs a drink now. Pass [day] to back-date a new entry to that day, or
/// [existing] to edit an entry; both show a time picker.
Future<void> showLogSheet(
  BuildContext context, {
  DateTime? day,
  LogEntry? existing,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => LogSheet(day: day, existing: existing),
);

class LogSheet extends ConsumerStatefulWidget {
  const LogSheet({this.day, this.existing, super.key});

  final DateTime? day;
  final LogEntry? existing;

  @override
  ConsumerState<LogSheet> createState() => _LogSheetState();
}

class _LogSheetState extends ConsumerState<LogSheet> {
  late String? _categoryId = widget.existing?.categoryId;
  late int _volumeMl = widget.existing?.volumeMl ?? 250;
  late TimeOfDay _time = TimeOfDay.fromDateTime(
    widget.existing?.loggedAt ?? DateTime.now(),
  );

  bool get _showsTime => widget.day != null || widget.existing != null;

  DateTime get _loggedDay {
    final base = widget.existing?.loggedAt ?? widget.day ?? DateTime.now();
    return DateTime(base.year, base.month, base.day);
  }

  DateTime get _loggedAt =>
      _loggedDay.copyWith(hour: _time.hour, minute: _time.minute);

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).value ?? const [];
    final unit = ref.watch(volumeUnitProvider);
    final spec = unit.volumeSlider;
    final selected = _selectedCategory(categories);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.existing == null ? 'Log a drink' : 'Edit entry',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in categories)
                ChoiceChip(
                  key: Key('category-${category.id}'),
                  label: Text(category.name),
                  avatar: CircleAvatar(
                    backgroundColor: Color(category.colorValue),
                  ),
                  selected: category.id == selected?.id,
                  onSelected: (_) => setState(() => _categoryId = category.id),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            unit.format(_volumeMl),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Slider(
            value: unit.fromMl(_volumeMl).clamp(spec.min, spec.max),
            min: spec.min,
            max: spec.max,
            divisions: spec.divisions,
            label: unit.format(_volumeMl),
            onChanged: (v) => setState(() => _volumeMl = unit.toMl(v)),
          ),
          if (_showsTime)
            ListTile(
              key: const Key('time-tile'),
              leading: const Icon(Icons.schedule),
              title: Text(_time.format(context)),
              onTap: _pickTime,
            ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: selected == null ? null : () => _submit(selected),
            child: Text(widget.existing == null ? 'Log' : 'Save'),
          ),
        ],
      ),
    );
  }

  DrinkCategory? _selectedCategory(List<DrinkCategory> categories) {
    if (categories.isEmpty) return null;
    return categories.firstWhere(
      (c) => c.id == _categoryId,
      orElse: () => categories.first,
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _submit(DrinkCategory category) async {
    final navigator = Navigator.of(context);
    final existing = widget.existing;
    if (existing != null) {
      await ref
          .read(logRepositoryProvider)
          .update(
            existing.copyWith(
              categoryId: category.id,
              volumeMl: _volumeMl,
              loggedAt: _loggedAt,
            ),
          );
    } else {
      await logDrink(
        context,
        ref,
        categoryId: category.id,
        categoryName: category.name,
        volumeMl: _volumeMl,
        at: _showsTime ? _loggedAt : null,
      );
    }
    navigator.pop();
  }
}
