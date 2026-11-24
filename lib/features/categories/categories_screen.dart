import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../home/home_providers.dart';
import 'category_editor.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Drink categories')),
      body: ListView(
        children: [
          for (final category in categories)
            ListTile(
              key: Key('category-${category.id}'),
              leading: CircleAvatar(
                backgroundColor: Color(category.colorValue),
              ),
              title: Text(category.name),
              subtitle: Text(
                '${(category.hydrationFactor * 100).round()}% hydration',
              ),
              onTap: () => showCategoryEditor(context, existing: category),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCategoryEditor(context),
        icon: const Icon(Icons.add),
        label: const Text('Add category'),
      ),
    );
  }
}
