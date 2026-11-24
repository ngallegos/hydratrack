import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/reminder_settings.dart';
import '../settings/settings_providers.dart';
import 'notification_access_text.dart';
import 'reminder_providers.dart';

const _intervalChoices = [30, 45, 60, 90, 120, 180];
const _weekdayLabels = {
  DateTime.monday: 'Mon',
  DateTime.tuesday: 'Tue',
  DateTime.wednesday: 'Wed',
  DateTime.thursday: 'Thu',
  DateTime.friday: 'Fri',
  DateTime.saturday: 'Sat',
  DateTime.sunday: 'Sun',
};

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders =
        ref.watch(appSettingsProvider).value?.reminders ??
        const ReminderSettings();
    final actions = ref.read(settingsActionsProvider);
    final access = ref.watch(notificationAccessProvider);

    String timeLabel(int minute) =>
        TimeOfDay(hour: minute ~/ 60, minute: minute % 60).format(context);

    Future<void> pickTime({required bool isStart}) async {
      final current = isStart ? reminders.startMinute : reminders.endMinute;
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      );
      if (picked == null) return;
      final minute = picked.hour * 60 + picked.minute;
      final updated = isStart
          ? reminders.copyWith(startMinute: minute)
          : reminders.copyWith(endMinute: minute);
      if (updated.endMinute < updated.startMinute) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The last reminder must be after the first'),
            ),
          );
        }
        return;
      }
      await actions.setReminders(updated);
    }

    final accessController = ref.read(notificationAccessProvider.notifier);

    Future<void> toggle(bool enable) async {
      if (!enable) {
        accessController.reset();
        await actions.setReminders(reminders.copyWith(enabled: false));
        return;
      }
      debugPrint('Reminders switch: asking for notification permission');
      if (await accessController.request()) {
        await actions.setReminders(reminders.copyWith(enabled: true));
      }
    }

    final message = accessMessage(access, isWeb: kIsWeb);

    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Remind me to drink'),
            subtitle: const Text('Stops for the day once you reach your goal'),
            value: reminders.enabled,
            onChanged: access.isChecking ? null : toggle,
          ),
          if (message != null)
            _AccessNotice(
              message: message,
              checking: access.isChecking,
              onRetry: () async {
                if (await accessController.request()) {
                  await actions.setReminders(reminders.copyWith(enabled: true));
                }
              },
            ),
          ListTile(
            enabled: reminders.enabled,
            title: const Text('First reminder'),
            trailing: Text(timeLabel(reminders.startMinute)),
            onTap: () => pickTime(isStart: true),
          ),
          ListTile(
            enabled: reminders.enabled,
            title: const Text('Last reminder'),
            trailing: Text(timeLabel(reminders.endMinute)),
            onTap: () => pickTime(isStart: false),
          ),
          ListTile(
            enabled: reminders.enabled,
            title: const Text('Every'),
            subtitle: Wrap(
              spacing: 8,
              children: [
                for (final minutes in _intervalChoices)
                  ChoiceChip(
                    key: Key('interval-$minutes'),
                    label: Text('$minutes min'),
                    selected: minutes == reminders.intervalMinutes,
                    onSelected: reminders.enabled
                        ? (_) => actions.setReminders(
                            reminders.copyWith(intervalMinutes: minutes),
                          )
                        : null,
                  ),
              ],
            ),
          ),
          ListTile(
            enabled: reminders.enabled,
            title: const Text('On these days'),
            subtitle: Wrap(
              spacing: 8,
              children: [
                for (final MapEntry(key: weekday, value: label)
                    in _weekdayLabels.entries)
                  FilterChip(
                    key: Key('weekday-$weekday'),
                    label: Text(label),
                    selected: reminders.weekdays.contains(weekday),
                    onSelected: reminders.enabled
                        ? (on) => actions.setReminders(
                            reminders.copyWith(
                              weekdays:
                                  on
                                        ? {...reminders.weekdays, weekday}
                                        : {...reminders.weekdays}
                                    ..remove(weekday),
                            ),
                          )
                        : null,
                  ),
              ],
            ),
          ),
          if (kIsWeb)
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                'In the browser, reminders only appear while this tab is open.',
              ),
            ),
        ],
      ),
    );
  }
}

class _AccessNotice extends StatelessWidget {
  const _AccessNotice({
    required this.message,
    required this.checking,
    required this.onRetry,
  });

  final AccessMessage message;
  final bool checking;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      key: const Key('notification-access-notice'),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: checking ? colors.surfaceContainerHigh : colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (checking) const LinearProgressIndicator(),
            if (checking) const SizedBox(height: 12),
            Text(message.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(message.fix),
            if (!checking)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onRetry,
                  child: const Text('Try again'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
