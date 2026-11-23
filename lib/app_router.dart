import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/categories/categories_screen.dart';
import 'features/drinks/drinks_screen.dart';
import 'features/history/history_screen.dart';
import 'features/home/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/settings/settings_providers.dart';
import 'features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(appSettingsProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboardingDone = ref
          .read(appSettingsProvider)
          .value
          ?.onboardingDone;
      if (onboardingDone == null) return null;

      final onOnboarding = state.matchedLocation == '/onboarding';
      if (!onboardingDone && !onOnboarding) return '/onboarding';
      if (onboardingDone && onOnboarding) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
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
  );
});
