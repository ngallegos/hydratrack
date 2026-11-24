import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'backup_providers.dart';
import 'backup_service.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.read(backupServiceProvider);

    void say(String message) => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

    Future<void> export(Future<ExportResult> Function() run) async {
      final result = await run();
      if (result == ExportResult.saved && context.mounted) say('File saved');
    }

    Future<void> import() async {
      try {
        final changed = await service.importBackup();
        if (changed == null || !context.mounted) return;
        say(changed == 0 ? 'Already up to date' : 'Imported $changed records');
      } on FormatException catch (error) {
        if (context.mounted) say(error.message);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & export')),
      body: ListView(
        children: [
          ListTile(
            key: const Key('export-json'),
            leading: const Icon(Icons.download_outlined),
            title: const Text('Save a backup'),
            subtitle: const Text(
              'Everything, as a JSON file you can import later',
            ),
            onTap: () => export(service.exportBackup),
          ),
          ListTile(
            key: const Key('export-csv'),
            leading: const Icon(Icons.table_chart_outlined),
            title: const Text('Export entries as CSV'),
            subtitle: const Text('For spreadsheets'),
            onTap: () => export(service.exportCsv),
          ),
          ListTile(
            key: const Key('import'),
            leading: const Icon(Icons.upload_outlined),
            title: const Text('Import a backup'),
            subtitle: const Text(
              'Merges with your data; newer changes are kept',
            ),
            onTap: import,
          ),
        ],
      ),
    );
  }
}
