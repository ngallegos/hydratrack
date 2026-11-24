import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/reminder_settings.dart';
import '../settings/settings_providers.dart';
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

    Future<void> toggle(bool enable) async {
      if (enable) {
        await ref.read(notificationAccessProvider.notifier).request();
      }
      await actions.setReminders(reminders.copyWith(enabled: enable));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Remind me to drink'),
            subtitle: const Text('Stops for the day once you reach your goal'),
            value: reminders.enabled,
            onChanged: toggle,
          ),
          if (reminders.enabled && access == NotificationAccess.unavailable)
            ListTile(
              key: const Key('notifications-blocked'),
              leading: const Icon(Icons.notifications_off_outlined),
              title: const Text('Notifications are blocked here'),
              subtitle: const Text(
                'Reminders are on but nothing will appear until you allow '
                'notifications for HydraTrack in your browser or device '
                'settings.',
              ),
              trailing: TextButton(
                onPressed: () =>
                    ref.read(notificationAccessProvider.notifier).request(),
                child: const Text('Try again'),
              ),
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
