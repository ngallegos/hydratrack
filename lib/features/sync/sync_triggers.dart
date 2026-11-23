import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import 'sync_providers.dart';

const syncDebounce = Duration(seconds: 30);

/// Emits whenever synced data changes. Settings are deliberately excluded:
/// recording the last sync time writes to them and would retrigger syncing
/// forever. Overridden in tests.
final localChangesProvider = Provider<Stream<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return db
      .tableUpdates(
        TableUpdateQuery.onAllTables([
          db.drinkCategories,
          db.drinks,
          db.logEntries,
        ]),
      )
      .map((_) {});
});

/// Syncs on launch, when the app returns to the foreground, and shortly
/// after local data changes (debounced so a burst of edits syncs once).
class SyncTriggers extends ConsumerStatefulWidget {
  const SyncTriggers({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<SyncTriggers> createState() => _SyncTriggersState();
}

class _SyncTriggersState extends ConsumerState<SyncTriggers> {
  late final AppLifecycleListener _lifecycle;
  StreamSubscription<void>? _changes;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _sync);
    _changes = ref.read(localChangesProvider).listen((_) {
      _debounce?.cancel();
      _debounce = Timer(syncDebounce, _sync);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  void _sync() {
    if (!mounted) return;
    unawaited(ref.read(syncControllerProvider.notifier).syncNow());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    unawaited(_changes?.cancel());
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
