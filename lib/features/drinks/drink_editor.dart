import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

import '../../data/providers.dart';
import '../../domain/drink.dart';
import '../home/home_providers.dart';
import '../settings/settings_providers.dart';

Future<void> showDrinkEditor(BuildContext context, {Drink? existing}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DrinkEditor(existing: existing),
    );

class DrinkEditor extends ConsumerStatefulWidget {
  const DrinkEditor({this.existing, super.key});

  final Drink? existing;

  @override
  ConsumerState<DrinkEditor> createState() => _DrinkEditorState();
}

class _DrinkEditorState extends ConsumerState<DrinkEditor> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late String? _categoryId = widget.existing?.categoryId;
  late int _volumeMl = widget.existing?.volumeMl ?? 250;
  late bool _starred = widget.existing?.starred ?? false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).value ?? const [];
    final unit = ref.watch(volumeUnitProvider);
    final spec = unit.volumeSlider;
    final categoryId = categories.any((c) => c.id == _categoryId)
        ? _categoryId
        : categories.firstOrNull?.id;
    final isEditing = widget.existing != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'Edit drink' : 'New drink',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
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
                    selected: category.id == categoryId,
                    onSelected: (_) =>
                        setState(() => _categoryId = category.id),
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
            SwitchListTile(
              title: const Text('Quick-log from home'),
              value: _starred,
              onChanged: (v) => setState(() => _starred = v),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _name.text.trim().isEmpty || categoryId == null
                  ? null
                  : () => _save(categoryId),
              child: const Text('Save'),
            ),
            if (isEditing)
              TextButton(onPressed: _delete, child: const Text('Delete')),
          ],
        ),
      ),
    );
  }

  Future<void> _save(String categoryId) async {
    final navigator = Navigator.of(context);
    final base =
        widget.existing ??
        Drink(
          id: const Uuid().v4(),
          categoryId: categoryId,
          name: '',
          volumeMl: 0,
          updatedAt: DateTime.now(),
          deviceId: '',
        );
    await ref
        .read(drinkRepositoryProvider)
        .upsert(
          base.copyWith(
            name: _name.text.trim(),
            categoryId: categoryId,
            volumeMl: _volumeMl,
            starred: _starred,
          ),
        );
    navigator.pop();
  }

  Future<void> _delete() async {
    final navigator = Navigator.of(context);
    await ref.read(drinkRepositoryProvider).softDelete(widget.existing!.id);
    navigator.pop();
  }
}
