import 'package:material_ui/material_ui.dart';

import '../../domain/drink.dart';
import '../../domain/drink_category.dart';
import '../../domain/volume_unit.dart';

class StarredDrinkChip extends StatelessWidget {
  const StarredDrinkChip({
    required this.drink,
    required this.category,
    required this.onTap,
    this.unit = VolumeUnit.ml,
    super.key,
  });

  final Drink drink;
  final DrinkCategory category;
  final VoidCallback onTap;
  final VolumeUnit unit;

  @override
  Widget build(BuildContext context) {
    final label = '${drink.name} · ${unit.format(drink.volumeMl)}';
    // Scale the dot with the user's font-size setting.
    final dotSize = MediaQuery.textScalerOf(context).scale(12);
    final avatar = Semantics(
      label: category.name,
      child: Container(
        key: const Key('category-dot'),
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(category.colorValue),
        ),
      ),
    );
    return ActionChip(avatar: avatar, label: Text(label), onPressed: onTap);
  }
}
