import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/categories/categories_screen.dart';
import 'features/drinks/drinks_screen.dart';
import 'features/home/home_screen.dart';
import 'features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: '/settings',
        builder: (_, _) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'categories',
            builder: (_, _) => const CategoriesScreen(),
          ),
          GoRoute(path: 'drinks', builder: (_, _) => const DrinksScreen()),
        ],
      ),
    ],
  ),
);
