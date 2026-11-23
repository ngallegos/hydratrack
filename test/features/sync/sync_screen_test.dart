import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/drive_files.dart';
import 'package:hydratrack/data/sync/sync_service.dart';
import 'package:hydratrack/features/settings/app_settings.dart';
import 'package:hydratrack/features/settings/settings_providers.dart';
import 'package:hydratrack/features/sync/sync_providers.dart';
import 'package:hydratrack/features/sync/sync_screen.dart';
import 'package:hydratrack/platform/drive_sign_in.dart';
import 'package:hydratrack/platform/folder_picker.dart';
import 'package:material_ui/material_ui.dart';

class _FakePicker implements FolderPicker {
  _FakePicker(this.path);

  final String? path;

  @override
  Future<String?> pickFolder() async => path;
}

class _FakeDriveFiles extends Fake implements DriveFiles {}

class _FakeDriveSignIn implements DriveSignIn {
  _FakeDriveSignIn({this.reason, this.succeeds = true});

  final String? reason;
  final bool succeeds;
  var signIns = 0;
  var signOuts = 0;

  @override
  String? get unavailableReason => reason;

  @override
  bool get isAvailable => reason == null;

  @override
  Future<DriveFiles?> restore() async => null;

  @override
  Future<DriveFiles?> signIn() async {
    signIns++;
    return succeeds ? _FakeDriveFiles() : null;
  }

  @override
  Future<void> signOut() async => signOuts++;
}

class _FakeService extends Fake implements SyncService {
  _FakeService({this.failure});

  final Exception? failure;
  var runs = 0;

  @override
  Future<SyncResult> sync() async {
    runs++;
    if (failure != null) throw failure!;
    return const SyncResult(recordsChanged: 0, skippedFiles: []);
  }
}

class _FakeSettingsActions extends Fake implements SettingsActions {
  final folders = <String>[];
  final modes = <SyncMode>[];

  @override
  Future<void> setSyncFolder(String path) async => folders.add(path);

  @override
  Future<void> setSyncMode(SyncMode mode) async => modes.add(mode);

  @override
  Future<void> recordSync(DateTime at) async {}
}

Widget _host(
  _FakeSettingsActions actions, {
  AppSettings settings = const AppSettings(),
  String? pickedPath,
  _FakeService? service,
  DriveSignIn? drive,
}) => ProviderScope(
  overrides: [
    appSettingsProvider.overrideWith((ref) => Stream.value(settings)),
    settingsActionsProvider.overrideWithValue(actions),
    folderPickerProvider.overrideWithValue(_FakePicker(pickedPath)),
    syncServiceProvider.overrideWithValue(service),
    driveSignInProvider.overrideWithValue(
      drive ?? _FakeDriveSignIn(reason: 'Needs a client id'),
    ),
  ],
  child: const MaterialApp(home: SyncScreen()),
);

const _folderSettings = AppSettings(
  syncMode: SyncMode.folder,
  syncFolderPath: '/sync/hydratrack',
);

void main() {
  testWidgets('offers folder sync and explains why Drive is unavailable', (
    tester,
  ) async {
    await tester.pumpWidget(_host(_FakeSettingsActions()));
    await tester.pumpAndSettle();

    expect(find.text('Shared folder'), findsOneWidget);
    expect(find.text('Needs a client id'), findsOneWidget);
    expect(find.text('Sync now'), findsNothing);
  });

  testWidgets('signing in to Drive selects it and syncs', (tester) async {
    final actions = _FakeSettingsActions();
    final drive = _FakeDriveSignIn();
    final service = _FakeService();
    await tester.pumpWidget(_host(actions, drive: drive, service: service));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('drive-tile')));
    await tester.pumpAndSettle();

    expect(drive.signIns, 1);
    expect(actions.modes, [SyncMode.drive]);
    expect(service.runs, 1);
  });

  testWidgets('a cancelled Drive sign-in changes nothing', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(
      _host(actions, drive: _FakeDriveSignIn(succeeds: false)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('drive-tile')));
    await tester.pumpAndSettle();

    expect(actions.modes, isEmpty);
    expect(find.text('Google sign-in did not complete'), findsOneWidget);
  });

  testWidgets('turning off Drive sync also signs out', (tester) async {
    final actions = _FakeSettingsActions();
    final drive = _FakeDriveSignIn();
    await tester.pumpWidget(
      _host(
        actions,
        drive: drive,
        settings: const AppSettings(syncMode: SyncMode.drive),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Turn off sync'));
    await tester.pumpAndSettle();

    expect(drive.signOuts, 1);
    expect(actions.modes, [SyncMode.off]);
  });

  testWidgets('turning off folder sync does not sign out of Google', (
    tester,
  ) async {
    final drive = _FakeDriveSignIn();
    await tester.pumpWidget(
      _host(_FakeSettingsActions(), drive: drive, settings: _folderSettings),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Turn off sync'));
    await tester.pumpAndSettle();

    expect(drive.signOuts, 0);
  });

  testWidgets('choosing a folder saves it and syncs straight away', (
    tester,
  ) async {
    final actions = _FakeSettingsActions();
    final service = _FakeService();
    await tester.pumpWidget(
      _host(actions, pickedPath: '/sync/hydratrack', service: service),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('folder-tile')));
    await tester.pumpAndSettle();

    expect(actions.folders, ['/sync/hydratrack']);
    expect(service.runs, 1);
  });

  testWidgets('cancelling the picker changes nothing', (tester) async {
    final actions = _FakeSettingsActions();
    await tester.pumpWidget(_host(actions));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('folder-tile')));
    await tester.pumpAndSettle();

    expect(actions.folders, isEmpty);
  });

  testWidgets('shows the folder and offers sync now and turn off', (
    tester,
  ) async {
    final actions = _FakeSettingsActions();
    final service = _FakeService();
    await tester.pumpWidget(
      _host(actions, settings: _folderSettings, service: service),
    );
    await tester.pumpAndSettle();

    expect(find.text('/sync/hydratrack'), findsOneWidget);
    expect(find.text('Not synced yet'), findsOneWidget);

    await tester.tap(find.text('Sync now'));
    await tester.pumpAndSettle();
    expect(service.runs, 1);

    await tester.tap(find.text('Turn off sync'));
    await tester.pumpAndSettle();
    expect(actions.modes, [SyncMode.off]);
  });

  testWidgets('shows why a sync failed', (tester) async {
    await tester.pumpWidget(
      _host(
        _FakeSettingsActions(),
        settings: _folderSettings,
        service: _FakeService(failure: const FormatException('disk full')),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sync now'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Last sync failed'), findsOneWidget);
    expect(find.textContaining('disk full'), findsOneWidget);
  });
}
