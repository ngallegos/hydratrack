import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings.freezed.dart';
part 'reminder_settings.g.dart';

@freezed
abstract class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    @Default(false) bool enabled,
    @Default(8 * 60) int startMinute,
    @Default(22 * 60) int endMinute,
    @Default(90) int intervalMinutes,
    @Default({
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    })
    Set<int> weekdays,
  }) = _ReminderSettings;

  factory ReminderSettings.fromJson(Map<String, dynamic> json) =>
      _$ReminderSettingsFromJson(json);
}
