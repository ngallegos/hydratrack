import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../domain/goal.dart';
import '../settings/app_settings.dart';
import '../settings/settings_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _weight = TextEditingController();
  var _activity = ActivityLevel.sedentary;
  var _goalMl = defaultDailyGoalMl.toDouble();

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }

  double? get _weightKg => double.tryParse(_weight.text.trim());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Welcome to HydraTrack', style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text(
              'No account needed. Set a daily goal to get started, '
              'or tell us a bit about you and we will suggest one.',
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _weight,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                helperText: 'Optional',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final level in ActivityLevel.values)
                  ChoiceChip(
                    key: Key('activity-${level.name}'),
                    label: Text(level.label),
                    selected: level == _activity,
                    onSelected: (_) => setState(() => _activity = level),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: (_weightKg ?? 0) > 0 ? _suggest : null,
              child: const Text('Suggest my goal'),
            ),
            const SizedBox(height: 24),
            Text(
              formatMl(_goalMl.round()),
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Slider(
              value: _goalMl,
              min: minGoalMl.toDouble(),
              max: maxGoalMl.toDouble(),
              divisions: (maxGoalMl - minGoalMl) ~/ goalStepMl,
              onChanged: (v) => setState(() => _goalMl = v),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _start, child: const Text('Start')),
            TextButton(
              onPressed: _skip,
              child: const Text('Skip, use the default'),
            ),
          ],
        ),
      ),
    );
  }

  void _suggest() {
    final goal = suggestedDailyGoalMl(
      weightKg: _weightKg!,
      activity: _activity,
    );
    setState(() => _goalMl = goal.toDouble());
  }

  Future<void> _start() async {
    final router = GoRouter.of(context);
    await ref
        .read(settingsActionsProvider)
        .completeOnboarding(
          dailyGoalMl: _goalMl.round(),
          weightKg: _weightKg,
          activity: _activity,
        );
    router.go('/');
  }

  Future<void> _skip() async {
    final router = GoRouter.of(context);
    await ref
        .read(settingsActionsProvider)
        .completeOnboarding(dailyGoalMl: defaultDailyGoalMl);
    router.go('/');
  }
}
