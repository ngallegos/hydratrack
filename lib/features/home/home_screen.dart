import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../domain/hydration.dart';
import '../avatar/avatar_band.dart';
import '../avatar/avatar_view.dart';
import '../log/log_actions.dart';
import '../log/log_sheet.dart';
import 'home_providers.dart';
import 'starred_drink_chip.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hydration = ref.watch(todayHydrationProvider);
    final categories = ref.watch(categoriesProvider).value ?? const [];
    final starred = ref.watch(starredDrinksProvider).value ?? const [];
    final goalMl = ref.watch(dailyGoalMlProvider);
    final shape = ref.watch(avatarShapeProvider);

    final totalMl = totalHydrationMl(hydration).round();
    final bands = computeAvatarBands(
      hydrationByCategory: hydration,
      categories: categories,
      goalMl: goalMl,
    );
    final categoriesById = {for (final c in categories) c.id: c};
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HydraTrack'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AvatarView(
                  shape: shape,
                  bands: bands,
                  semanticsLabel:
                      '${formatMl(totalMl)} of ${formatMl(goalMl)} today',
                ),
              ),
            ),
            Text(
              '${formatMl(totalMl)} / ${formatMl(goalMl)}',
              style: textTheme.headlineMedium,
            ),
            if (totalMl >= goalMl)
              Text('Goal reached', style: textTheme.titleSmall),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (final drink in starred)
                    if (categoriesById[drink.categoryId] case final category?)
                      StarredDrinkChip(
                        drink: drink,
                        category: category,
                        onTap: () => logDrink(
                          context,
                          ref,
                          categoryId: category.id,
                          categoryName: category.name,
                          volumeMl: drink.volumeMl,
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 96),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showLogSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Log drink'),
      ),
    );
  }
}
