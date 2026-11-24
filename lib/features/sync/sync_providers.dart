import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../data/sync/directory_backend.dart';
import '../../data/sync/drive_backend.dart';
import '../../data/sync/sync_backend.dart';
import '../../data/sync/sync_service.dart';
import '../../data/sync/sync_store.dart';
import '../../platform/drive_sign_in.dart';
import '../settings/app_settings.dart';
import '../settings/settings_providers.dart';

final driveSignInProvider = Provider<DriveSignIn>((ref) => GoogleDriveSignIn());

/// Overridden in tests; the default builds a backend from settings.
final syncBackendProvider = Provider<SyncBackend?>((ref) {
  final mode = ref.watch(appSettingsProvider.select((s) => s.value?.syncMode));
  final folder = ref.watch(
    appSettingsProvider.select((s) => s.value?.syncFolderPath),
  );

  return switch (mode) {
    SyncMode.folder when !kIsWeb && folder != null => DirectoryBackend(
      Directory(folder),
    ),
    SyncMode.drive => DriveBackend(ref.read(driveSignInProvider).restore),
    _ => null,
  };
});

final syncServiceProvider = Provider<SyncService?>((ref) {
  final backend = ref.watch(syncBackendProvider);
  if (backend == null) return null;
  return SyncService(
    store: SyncStore(ref.watch(databaseProvider)),
    backend: backend,
    deviceId: ref.watch(deviceIdProvider),
  );
});

sealed class SyncState {
  const SyncState();
}

final class SyncIdle extends SyncState {
  const SyncIdle();
}

final class SyncRunning extends SyncState {
  const SyncRunning();
}

final class SyncFailed extends SyncState {
  const SyncFailed(this.message);

  final String message;
}

class SyncController extends Notifier<SyncState> {
  @override
  SyncState build() => const SyncIdle();

  Future<void> syncNow() async {
    final service = ref.read(syncServiceProvider);
    if (service == null || state is SyncRunning) return;

    state = const SyncRunning();
    try {
      await service.sync();
      await ref.read(settingsActionsProvider).recordSync(DateTime.now());
      state = const SyncIdle();
    } on Exception catch (error) {
      state = SyncFailed('$error');
    }
  }
}

final syncControllerProvider = NotifierProvider<SyncController, SyncState>(
  SyncController.new,
);
