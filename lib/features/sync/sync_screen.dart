import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../platform/folder_picker.dart';
import '../settings/app_settings.dart';
import '../settings/settings_providers.dart';
import 'sync_providers.dart';

final folderPickerProvider = Provider<FolderPicker>(
  (ref) => const SystemFolderPicker(),
);

class SyncScreen extends ConsumerWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings =
        ref.watch(appSettingsProvider).value ?? const AppSettings();
    final state = ref.watch(syncControllerProvider);
    final actions = ref.read(settingsActionsProvider);
    final controller = ref.read(syncControllerProvider.notifier);
    final configured = settings.syncMode != SyncMode.off;

    Future<void> chooseFolder() async {
      final path = await ref.read(folderPickerProvider).pickFolder();
      if (path == null) return;
      await actions.setSyncFolder(path);
      await controller.syncNow();
    }

    final drive = ref.read(driveSignInProvider);

    Future<void> signInToDrive() async {
      final files = await drive.signIn();
      if (files == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google sign-in did not complete')),
          );
        }
        return;
      }
      await actions.setSyncMode(SyncMode.drive);
      await controller.syncNow();
    }

    Future<void> turnOff() async {
      if (settings.syncMode == SyncMode.drive) await drive.signOut();
      await actions.setSyncMode(SyncMode.off);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sync')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'HydraTrack works fully offline with no account. Turn on sync '
              'only if you want your data on more than one device.',
            ),
          ),
          if (!kIsWeb)
            ListTile(
              key: const Key('folder-tile'),
              leading: const Icon(Icons.folder_outlined),
              title: const Text('Shared folder'),
              subtitle: Text(
                settings.syncMode == SyncMode.folder
                    ? settings.syncFolderPath ?? 'Not set'
                    : 'Use a folder kept in sync by Syncthing, Dropbox, etc.',
              ),
              trailing: settings.syncMode == SyncMode.folder
                  ? const Icon(Icons.check_circle)
                  : null,
              onTap: chooseFolder,
            ),
          ListTile(
            key: const Key('drive-tile'),
            leading: const Icon(Icons.cloud_outlined),
            title: const Text('Google Drive'),
            subtitle: Text(
              drive.unavailableReason ??
                  (settings.syncMode == SyncMode.drive
                      ? 'Syncing through your private app folder'
                      : 'Sign in only if you want this. Stored in a hidden app folder.'),
            ),
            trailing: settings.syncMode == SyncMode.drive
                ? const Icon(Icons.check_circle)
                : null,
            enabled: drive.isAvailable,
            onTap: signInToDrive,
          ),
          if (configured) ...[
            const Divider(),
            ListTile(
              title: Text(_statusText(state, settings)),
              trailing: state is SyncRunning
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  FilledButton(
                    onPressed: state is SyncRunning ? null : controller.syncNow,
                    child: const Text('Sync now'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: turnOff,
                    child: const Text('Turn off sync'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _statusText(SyncState state, AppSettings settings) {
    return switch (state) {
      SyncRunning() => 'Syncing…',
      SyncFailed(:final message) => 'Last sync failed: $message',
      SyncIdle() =>
        settings.lastSyncAt == null
            ? 'Not synced yet'
            : 'Last synced ${settings.lastSyncAt!.toLocal()}',
    };
  }
}
