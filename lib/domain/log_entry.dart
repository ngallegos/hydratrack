import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_entry.freezed.dart';
part 'log_entry.g.dart';

@freezed
abstract class LogEntry with _$LogEntry {
  const factory LogEntry({
    required String id,
    required String categoryId,
    required int volumeMl,
    required DateTime loggedAt,
    required DateTime updatedAt,
    required String deviceId,
    @Default(false) bool deleted,
  }) = _LogEntry;

  factory LogEntry.fromJson(Map<String, dynamic> json) =>
      _$LogEntryFromJson(json);
}
