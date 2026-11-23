import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/backup/backup_providers.dart';
import 'package:hydratrack/features/backup/backup_screen.dart';
import 'package:hydratrack/features/backup/backup_service.dart';
import 'package:material_ui/material_ui.dart';

class _FakeBackupService extends Fake implements BackupService {
  _FakeBackupService({
    this.exportResult = ExportResult.saved,
    this.importResult,
    this.importError,
  });

  final ExportResult exportResult;
  final int? importResult;
  final Exception? importError;
  var jsonExports = 0;
  var csvExports = 0;

  @override
  Future<ExportResult> exportBackup() async {
    jsonExports++;
    return exportResult;
  }

  @override
  Future<ExportResult> exportCsv() async {
    csvExports++;
    return exportResult;
  }

  @override
  Future<int?> importBackup() async {
    if (importError != null) throw importError!;
    return importResult;
  }
}

Widget _host(_FakeBackupService service) => ProviderScope(
  overrides: [backupServiceProvider.overrideWithValue(service)],
  child: const MaterialApp(home: BackupScreen()),
);

void main() {
  testWidgets('exports JSON and CSV and confirms', (tester) async {
    final service = _FakeBackupService();
    await tester.pumpWidget(_host(service));

    await tester.tap(find.byKey(const Key('export-json')));
    await tester.pumpAndSettle();
    expect(service.jsonExports, 1);
    expect(find.text('File saved'), findsOneWidget);

    await tester.tap(find.byKey(const Key('export-csv')));
    await tester.pumpAndSettle();
    expect(service.csvExports, 1);
  });

  testWidgets('a cancelled export says nothing', (tester) async {
    await tester.pumpWidget(
      _host(_FakeBackupService(exportResult: ExportResult.cancelled)),
    );

    await tester.tap(find.byKey(const Key('export-json')));
    await tester.pumpAndSettle();

    expect(find.text('File saved'), findsNothing);
  });

  testWidgets('reports how many records an import changed', (tester) async {
    await tester.pumpWidget(_host(_FakeBackupService(importResult: 12)));

    await tester.tap(find.byKey(const Key('import')));
    await tester.pumpAndSettle();

    expect(find.text('Imported 12 records'), findsOneWidget);
  });

  testWidgets('says when an import changed nothing', (tester) async {
    await tester.pumpWidget(_host(_FakeBackupService(importResult: 0)));

    await tester.tap(find.byKey(const Key('import')));
    await tester.pumpAndSettle();

    expect(find.text('Already up to date'), findsOneWidget);
  });

  testWidgets('shows why an invalid file was rejected', (tester) async {
    await tester.pumpWidget(
      _host(
        _FakeBackupService(
          importError: const FormatException(
            'This file is not a HydraTrack backup',
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('import')));
    await tester.pumpAndSettle();

    expect(find.text('This file is not a HydraTrack backup'), findsOneWidget);
  });

  testWidgets('a cancelled import says nothing', (tester) async {
    await tester.pumpWidget(_host(_FakeBackupService()));

    await tester.tap(find.byKey(const Key('import')));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsNothing);
  });
}
