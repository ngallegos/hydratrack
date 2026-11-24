import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/drink.dart';

final allDrinksProvider = StreamProvider<List<Drink>>(
  (ref) => ref.watch(drinkRepositoryProvider).watchAll(),
);
