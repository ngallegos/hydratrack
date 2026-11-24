import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/providers.dart';
import '../settings/settings_providers.dart';

/// Logs a drink and offers a snackbar Undo that soft-deletes the new entry.
Future<void> logDrink(
  BuildContext context,
  WidgetRef ref, {
  required String categoryId,
  required String categoryName,
  required int volumeMl,
  DateTime? at,
}) async {
  final repository = ref.read(logRepositoryProvider);
  final unit = ref.read(volumeUnitProvider);
  final entry = await repository.add(
    categoryId: categoryId,
    volumeMl: volumeMl,
    at: at,
  );
  if (!context.mounted) return;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('Logged ${unit.format(volumeMl)} $categoryName'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => repository.softDelete(entry.id),
        ),
      ),
    );
}
