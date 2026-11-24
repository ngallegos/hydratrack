import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

import '../../data/providers.dart';
import '../../domain/drink_category.dart';
import '../home/home_providers.dart';

const categoryPalette = [
  0xFF2196F3,
  0xFF4DD0E1,
  0xFF26A69A,
  0xFF8BC34A,
  0xFFFFC107,
  0xFFFF9800,
  0xFFE53935,
  0xFFEC407A,
  0xFF8E24AA,
  0xFF5C6BC0,
  0xFF795548,
  0xFF90A4AE,
];

Future<void> showCategoryEditor(
  BuildContext context, {
  DrinkCategory? existing,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => CategoryEditor(existing: existing),
);

class CategoryEditor extends ConsumerStatefulWidget {
  const CategoryEditor({this.existing, super.key});

  final DrinkCategory? existing;

  @override
  ConsumerState<CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends ConsumerState<CategoryEditor> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late int _color = widget.existing?.colorValue ?? categoryPalette.first;
  late double _percent = ((widget.existing?.hydrationFactor ?? 1) * 100)
      .roundToDouble();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
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
            isEditing ? 'Edit category' : 'New category',
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
              for (final value in categoryPalette)
                GestureDetector(
                  key: Key('color-$value'),
                  onTap: () => setState(() => _color = value),
                  child: CircleAvatar(
                    backgroundColor: Color(value),
                    child: value == _color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Hydration: ${_percent.round()}%'),
          Slider(
            value: _percent,
            max: 100,
            divisions: 20,
            label: '${_percent.round()}%',
            onChanged: (v) => setState(() => _percent = v),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _name.text.trim().isEmpty ? null : _save,
            child: const Text('Save'),
          ),
          if (isEditing)
            TextButton(onPressed: _delete, child: const Text('Delete')),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final navigator = Navigator.of(context);
    final repository = ref.read(categoryRepositoryProvider);
    final existing = widget.existing;
    final base =
        existing ??
        DrinkCategory(
          id: const Uuid().v4(),
          name: '',
          colorValue: _color,
          hydrationFactor: 1,
          sortOrder: ref.read(categoriesProvider).value?.length ?? 0,
          updatedAt: DateTime.now(),
          deviceId: '',
        );
    await repository.upsert(
      base.copyWith(
        name: _name.text.trim(),
        colorValue: _color,
        hydrationFactor: _percent / 100,
      ),
    );
    navigator.pop();
  }

  Future<void> _delete() async {
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${widget.existing!.name}?'),
        content: const Text(
          'Past entries in this category will stop counting toward your totals.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(categoryRepositoryProvider).softDelete(widget.existing!.id);
    navigator.pop();
  }
}
