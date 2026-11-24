// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DrinkCategory _$DrinkCategoryFromJson(Map<String, dynamic> json) =>
    _DrinkCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      hydrationFactor: (json['hydrationFactor'] as num).toDouble(),
      sortOrder: (json['sortOrder'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deviceId: json['deviceId'] as String,
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$DrinkCategoryToJson(_DrinkCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorValue': instance.colorValue,
      'hydrationFactor': instance.hydrationFactor,
      'sortOrder': instance.sortOrder,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deviceId': instance.deviceId,
      'deleted': instance.deleted,
    };
