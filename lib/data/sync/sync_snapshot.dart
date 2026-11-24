import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/drink.dart';
import '../../domain/drink_category.dart';
import '../../domain/log_entry.dart';

part 'sync_snapshot.freezed.dart';
part 'sync_snapshot.g.dart';

/// Everything one device knows, tombstones included. Each device writes its
/// own snapshot file and only ever reads the others, so no two devices write
/// the same file.
@freezed
abstract class SyncSnapshot with _$SyncSnapshot {
  const factory SyncSnapshot({
    required String deviceId,
    required DateTime generatedAt,
    @Default([]) List<DrinkCategory> categories,
    @Default([]) List<Drink> drinks,
    @Default([]) List<LogEntry> entries,
  }) = _SyncSnapshot;

  factory SyncSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SyncSnapshotFromJson(json);
}
