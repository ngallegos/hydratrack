import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../domain/drink_category.dart';
import '../home/home_providers.dart';
import 'log_actions.dart';

Future<void> showLogSheet(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => const LogSheet(),
);

class LogSheet extends ConsumerStatefulWidget {
  const LogSheet({super.key});

  @override
  ConsumerState<LogSheet> createState() => _LogSheetState();
}

class _LogSheetState extends ConsumerState<LogSheet> {
  String? _categoryId;
  double _volumeMl = 250;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).value ?? const [];
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
          Text('Log a drink', style: Theme.of(context).textTheme.titleLarge),
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
            formatMl(_volumeMl.round()),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _volumeMl,
            min: 50,
            max: 1000,
            divisions: 19,
            label: formatMl(_volumeMl.round()),
            onChanged: (v) => setState(() => _volumeMl = v),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: selected == null ? null : () => _submit(selected),
            child: const Text('Log'),
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

  Future<void> _submit(DrinkCategory category) async {
    final navigator = Navigator.of(context);
    await logDrink(
      context,
      ref,
      categoryId: category.id,
      categoryName: category.name,
      volumeMl: _volumeMl.round(),
    );
    navigator.pop();
  }
}
