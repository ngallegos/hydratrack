import 'dart:convert';

import '../domain/drink_category.dart';
import '../domain/hydration.dart';
import '../domain/log_entry.dart';
import 'sync/sync_snapshot.dart';

String backupToJson(SyncSnapshot snapshot) =>
    const JsonEncoder.withIndent('  ').convert(snapshot.toJson());

/// Parses a backup file. Throws [FormatException] with a user-readable
/// message when the text isn't a HydraTrack backup.
SyncSnapshot parseBackup(String text) {
  try {
    return SyncSnapshot.fromJson(jsonDecode(text) as Map<String, dynamic>);
  } on Exception {
    throw const FormatException('This file is not a HydraTrack backup');
  } on TypeError {
    throw const FormatException('This file is not a HydraTrack backup');
  }
}

String entriesToCsv(
  List<LogEntry> entries,
  Map<String, DrinkCategory> categoriesById,
) {
  final rows = [...entries.where((e) => !e.deleted)]
    ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

  String two(int n) => n.toString().padLeft(2, '0');

  final lines = [
    'date,time,category,volume_ml,effective_ml',
    for (final entry in rows)
      _csvRow([
        '${entry.loggedAt.year}-${two(entry.loggedAt.month)}-${two(entry.loggedAt.day)}',
        '${two(entry.loggedAt.hour)}:${two(entry.loggedAt.minute)}',
        categoriesById[entry.categoryId]?.name ?? entry.categoryId,
        '${entry.volumeMl}',
        categoriesById[entry.categoryId] == null
            ? ''
            : effectiveHydrationMl(
                entry,
                categoriesById[entry.categoryId]!,
              ).toStringAsFixed(1),
      ]),
  ];
  return '${lines.join('\n')}\n';
}

String _csvRow(List<String> fields) => fields.map(_csvField).join(',');

String _csvField(String value) {
  if (!value.contains(RegExp('[",\n\r]'))) return value;
  return '"${value.replaceAll('"', '""')}"';
}
