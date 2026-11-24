// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogEntry _$LogEntryFromJson(Map<String, dynamic> json) => _LogEntry(
  id: json['id'] as String,
  categoryId: json['categoryId'] as String,
  volumeMl: (json['volumeMl'] as num).toInt(),
  loggedAt: DateTime.parse(json['loggedAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deviceId: json['deviceId'] as String,
  deleted: json['deleted'] as bool? ?? false,
);

Map<String, dynamic> _$LogEntryToJson(_LogEntry instance) => <String, dynamic>{
  'id': instance.id,
  'categoryId': instance.categoryId,
  'volumeMl': instance.volumeMl,
  'loggedAt': instance.loggedAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deviceId': instance.deviceId,
  'deleted': instance.deleted,
};
