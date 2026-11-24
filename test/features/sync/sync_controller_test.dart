import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/sync_service.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/features/sync/sync_providers.dart';

class _FakeSyncService extends Fake implements SyncService {
  _FakeSyncService({this.gate, this.failure});

  final Completer<void>? gate;
  final Exception? failure;
  var runs = 0;

  @override
  Future<SyncResult> sync() async {
    runs++;
    await gate?.future;
    if (failure != null) throw failure!;
    return const SyncResult(recordsChanged: 0, skippedFiles: []);
  }
}

class _FakeSettingsActions extends Fake implements SettingsActions {
  final recorded = <DateTime>[];

  @override
  Future<void> recordSync(DateTime at) async => recorded.add(at);
}

ProviderContainer _container(
  _FakeSyncService? service,
  _FakeSettingsActions actions,
) {
  final container = ProviderContainer(
    overrides: [
      syncServiceProvider.overrideWithValue(service),
      settingsActionsProvider.overrideWithValue(actions),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('does nothing when sync is not configured', () async {
    final actions = _FakeSettingsActions();
    final container = _container(null, actions);

    await container.read(syncControllerProvider.notifier).syncNow();

    expect(container.read(syncControllerProvider), isA<SyncIdle>());
    expect(actions.recorded, isEmpty);
  });

  test(
    'records the time and returns to idle after a successful sync',
    () async {
      final service = _FakeSyncService();
      final actions = _FakeSettingsActions();
      final container = _container(service, actions);

      await container.read(syncControllerProvider.notifier).syncNow();

      expect(service.runs, 1);
      expect(actions.recorded, hasLength(1));
      expect(container.read(syncControllerProvider), isA<SyncIdle>());
    },
  );

  test('reports the failure and does not record a sync time', () async {
    final service = _FakeSyncService(failure: const FormatException('boom'));
    final actions = _FakeSettingsActions();
    final container = _container(service, actions);

    await container.read(syncControllerProvider.notifier).syncNow();

    final state = container.read(syncControllerProvider);
    expect(state, isA<SyncFailed>());
    expect((state as SyncFailed).message, contains('boom'));
    expect(actions.recorded, isEmpty);
  });

  test('ignores a second request while one is running', () async {
    final gate = Completer<void>();
    final service = _FakeSyncService(gate: gate);
    final container = _container(service, _FakeSettingsActions());
    final controller = container.read(syncControllerProvider.notifier);

    final first = controller.syncNow();
    expect(container.read(syncControllerProvider), isA<SyncRunning>());
    await controller.syncNow();
    gate.complete();
    await first;

    expect(service.runs, 1);
  });

  test('can sync again after a failure', () async {
    final service = _FakeSyncService(failure: const FormatException('x'));
    final container = _container(service, _FakeSettingsActions());
    final controller = container.read(syncControllerProvider.notifier);

    await controller.syncNow();
    await controller.syncNow();

    expect(service.runs, 2);
  });
}
