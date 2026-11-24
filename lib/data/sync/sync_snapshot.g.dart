// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncSnapshot _$SyncSnapshotFromJson(Map<String, dynamic> json) =>
    _SyncSnapshot(
      deviceId: json['deviceId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => DrinkCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      drinks:
          (json['drinks'] as List<dynamic>?)
              ?.map((e) => Drink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      entries:
          (json['entries'] as List<dynamic>?)
              ?.map((e) => LogEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SyncSnapshotToJson(_SyncSnapshot instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'drinks': instance.drinks.map((e) => e.toJson()).toList(),
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };
