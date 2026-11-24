import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/sync_service.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/features/sync/sync_providers.dart';
import 'package:hydratrack/features/sync/sync_triggers.dart';
import 'package:material_ui/material_ui.dart';

class _CountingService extends Fake implements SyncService {
  var runs = 0;

  @override
  Future<SyncResult> sync() async {
    runs++;
    return const SyncResult(recordsChanged: 0, skippedFiles: []);
  }
}

class _FakeSettingsActions extends Fake implements SettingsActions {
  @override
  Future<void> recordSync(DateTime at) async {}
}

void main() {
  late _CountingService service;
  late StreamController<void> changes;

  Widget host() => ProviderScope(
    overrides: [
      syncServiceProvider.overrideWithValue(service),
      settingsActionsProvider.overrideWithValue(_FakeSettingsActions()),
      localChangesProvider.overrideWithValue(changes.stream),
    ],
    child: const SyncTriggers(child: SizedBox()),
  );

  setUp(() {
    service = _CountingService();
    changes = StreamController<void>.broadcast();
  });

  tearDown(() => changes.close());

  testWidgets('syncs once on launch', (tester) async {
    await tester.pumpWidget(host());
    await tester.pump();

    expect(service.runs, 1);
  });

  testWidgets('syncs when the app returns to the foreground', (tester) async {
    await tester.pumpWidget(host());
    await tester.pump();

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(service.runs, 2);
  });

  testWidgets('a burst of local changes syncs once, after the debounce', (
    tester,
  ) async {
    await tester.pumpWidget(host());
    await tester.pump();

    changes.add(null);
    await tester.pump(const Duration(seconds: 10));
    changes.add(null);
    await tester.pump(const Duration(seconds: 20));
    expect(service.runs, 1);

    await tester.pump(const Duration(seconds: 11));
    expect(service.runs, 2);
  });

  testWidgets('stops listening when removed', (tester) async {
    await tester.pumpWidget(host());
    await tester.pump();

    await tester.pumpWidget(const SizedBox());
    changes.add(null);
    await tester.pump(syncDebounce * 2);

    expect(service.runs, 1);
  });
}
