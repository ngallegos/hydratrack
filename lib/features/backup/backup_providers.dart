import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../data/sync/sync_store.dart';
import '../../platform/file_transfer.dart';
import 'backup_service.dart';

final fileTransferProvider = Provider<FileTransfer>(
  (ref) => const SystemFileTransfer(),
);

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(
    store: SyncStore(ref.watch(databaseProvider)),
    transfer: ref.watch(fileTransferProvider),
    deviceId: ref.watch(deviceIdProvider),
  ),
);
