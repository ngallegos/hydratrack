import 'package:material_ui/material_ui.dart';

import '../../domain/drink.dart';
import '../../domain/drink_category.dart';

// EXERCISE: make the quick-log chip show the drink's volume and category color.
//
// Today it only shows the drink name. Requirements (see
// test/features/home/starred_drink_chip_test.dart):
//  - label reads "<name> · <volume>", e.g. "Glass of water · 250 ml"
//    (use formatMl from lib/core/format.dart)
//  - a small round dot in the category color sits before the label; give it
//    Key('category-dot') and the color Color(category.colorValue)
//  - tapping the chip calls onTap
//
// Hints: ActionChip takes `avatar` and `label` widgets; a Container with
// BoxDecoration(shape: BoxShape.circle, color: ...) makes a dot.
class StarredDrinkChip extends StatelessWidget {
  const StarredDrinkChip({
    required this.drink,
    required this.category,
    required this.onTap,
    super.key,
  });

  final Drink drink;
  final DrinkCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(label: Text(drink.name), onPressed: onTap);
  }
}
