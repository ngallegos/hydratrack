// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReminderSettings _$ReminderSettingsFromJson(Map<String, dynamic> json) =>
    _ReminderSettings(
      enabled: json['enabled'] as bool? ?? false,
      startMinute: (json['startMinute'] as num?)?.toInt() ?? 8 * 60,
      endMinute: (json['endMinute'] as num?)?.toInt() ?? 22 * 60,
      intervalMinutes: (json['intervalMinutes'] as num?)?.toInt() ?? 90,
      weekdays:
          (json['weekdays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toSet() ??
          const {
            DateTime.monday,
            DateTime.tuesday,
            DateTime.wednesday,
            DateTime.thursday,
            DateTime.friday,
            DateTime.saturday,
            DateTime.sunday,
          },
    );

Map<String, dynamic> _$ReminderSettingsToJson(_ReminderSettings instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
      'intervalMinutes': instance.intervalMinutes,
      'weekdays': instance.weekdays.toList(),
    };
