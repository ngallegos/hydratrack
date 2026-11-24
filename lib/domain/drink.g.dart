// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Drink _$DrinkFromJson(Map<String, dynamic> json) => _Drink(
  id: json['id'] as String,
  categoryId: json['categoryId'] as String,
  name: json['name'] as String,
  volumeMl: (json['volumeMl'] as num).toInt(),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deviceId: json['deviceId'] as String,
  starred: json['starred'] as bool? ?? false,
  deleted: json['deleted'] as bool? ?? false,
);

Map<String, dynamic> _$DrinkToJson(_Drink instance) => <String, dynamic>{
  'id': instance.id,
  'categoryId': instance.categoryId,
  'name': instance.name,
  'volumeMl': instance.volumeMl,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deviceId': instance.deviceId,
  'starred': instance.starred,
  'deleted': instance.deleted,
};
