import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../data/providers.dart';
import '../home/home_providers.dart';
import 'drink_editor.dart';
import 'drinks_providers.dart';

class DrinksScreen extends ConsumerWidget {
  const DrinksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinks = ref.watch(allDrinksProvider).value ?? const [];
    final categoryList = ref.watch(categoriesProvider).value ?? const [];
    final categories = {for (final c in categoryList) c.id: c};

    return Scaffold(
      appBar: AppBar(title: const Text('Drinks')),
      body: ListView(
        children: [
          for (final drink in drinks)
            if (categories[drink.categoryId] case final category?)
              ListTile(
                key: Key('drink-${drink.id}'),
                leading: CircleAvatar(
                  backgroundColor: Color(category.colorValue),
                ),
                title: Text(drink.name),
                subtitle: Text(
                  '${category.name} · ${formatMl(drink.volumeMl)}',
                ),
                trailing: IconButton(
                  key: Key('star-${drink.id}'),
                  tooltip: drink.starred ? 'Unstar' : 'Star',
                  icon: Icon(drink.starred ? Icons.star : Icons.star_border),
                  onPressed: () => ref
                      .read(drinkRepositoryProvider)
                      .setStarred(drink.id, starred: !drink.starred),
                ),
                onTap: () => showDrinkEditor(context, existing: drink),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDrinkEditor(context),
        icon: const Icon(Icons.add),
        label: const Text('Add drink'),
      ),
    );
  }
}
