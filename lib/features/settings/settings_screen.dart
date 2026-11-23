import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/format.dart';
import '../../domain/goal.dart';
import '../avatar/avatar_shape.dart';
import 'app_settings.dart';
import 'settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings =
        ref.watch(appSettingsProvider).value ?? const AppSettings();
    final actions = ref.read(settingsActionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Daily goal'),
            subtitle: Text(formatMl(settings.dailyGoalMl)),
            leading: const Icon(Icons.flag_outlined),
            onTap: () => _editGoal(context, settings.dailyGoalMl, actions),
          ),
          ListTile(
            title: const Text('Avatar'),
            leading: const Icon(Icons.face_outlined),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  for (final shape in AvatarShape.values)
                    ChoiceChip(
                      key: Key('avatar-${shape.name}'),
                      label: Text(shape.label),
                      selected: shape == settings.avatarShape,
                      onSelected: (_) => actions.setAvatarShape(shape),
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Sync'),
            subtitle: Text(switch (settings.syncMode) {
              SyncMode.off => 'Off',
              SyncMode.folder => 'Shared folder',
              SyncMode.drive => 'Google Drive',
            }),
            leading: const Icon(Icons.sync),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/sync'),
          ),
          ListTile(
            title: const Text('Reminders'),
            subtitle: Text(settings.reminders.enabled ? 'On' : 'Off'),
            leading: const Icon(Icons.notifications_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/reminders'),
          ),
          ListTile(
            title: const Text('Drink categories'),
            subtitle: const Text('Colors and hydration levels'),
            leading: const Icon(Icons.palette_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/categories'),
          ),
          ListTile(
            title: const Text('Drinks'),
            subtitle: const Text('Cup sizes and starred quick-log drinks'),
            leading: const Icon(Icons.local_drink_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/drinks'),
          ),
        ],
      ),
    );
  }

  Future<void> _editGoal(
    BuildContext context,
    int currentMl,
    SettingsActions actions,
  ) async {
    final chosen = await showDialog<int>(
      context: context,
      builder: (_) => _GoalDialog(initialMl: currentMl),
    );
    if (chosen != null) await actions.setDailyGoalMl(chosen);
  }
}

class _GoalDialog extends StatefulWidget {
  const _GoalDialog({required this.initialMl});

  final int initialMl;

  @override
  State<_GoalDialog> createState() => _GoalDialogState();
}

class _GoalDialogState extends State<_GoalDialog> {
  late double _ml = widget.initialMl.clamp(minGoalMl, maxGoalMl).toDouble();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Daily goal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatMl(_ml.round()),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Slider(
            value: _ml,
            min: minGoalMl.toDouble(),
            max: maxGoalMl.toDouble(),
            divisions: (maxGoalMl - minGoalMl) ~/ goalStepMl,
            onChanged: (v) => setState(() => _ml = v),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _ml.round()),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
