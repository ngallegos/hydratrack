// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReminderSettings {

 bool get enabled; int get startMinute; int get endMinute; int get intervalMinutes; Set<int> get weekdays;
/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<ReminderSettings> get copyWith => _$ReminderSettingsCopyWithImpl<ReminderSettings>(this as ReminderSettings, _$identity);

  /// Serializes this ReminderSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReminderSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderSettings&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.startMinute, _this.startMinute) || other.startMinute == _this.startMinute)&&(identical(other.endMinute, _this.endMinute) || other.endMinute == _this.endMinute)&&(identical(other.intervalMinutes, _this.intervalMinutes) || other.intervalMinutes == _this.intervalMinutes)&&const DeepCollectionEquality().equals(other.weekdays, _this.weekdays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReminderSettings;
  return Object.hash(runtimeType,_this.enabled,_this.startMinute,_this.endMinute,_this.intervalMinutes,const DeepCollectionEquality().hash(_this.weekdays));
}

@override
String toString() {
  final _this = this as ReminderSettings;
  return 'ReminderSettings(enabled: ${_this.enabled}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute}, intervalMinutes: ${_this.intervalMinutes}, weekdays: ${_this.weekdays})';
}


}

/// @nodoc
abstract mixin class $ReminderSettingsCopyWith<$Res>  {
  factory $ReminderSettingsCopyWith(ReminderSettings value, $Res Function(ReminderSettings) _then) = _$ReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, int startMinute, int endMinute, int intervalMinutes, Set<int> weekdays
});




}
/// @nodoc
class _$ReminderSettingsCopyWithImpl<$Res>
    implements $ReminderSettingsCopyWith<$Res> {
  _$ReminderSettingsCopyWithImpl(this._self, this._then);

  final ReminderSettings _self;
  final $Res Function(ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? startMinute = null,Object? endMinute = null,Object? intervalMinutes = null,Object? weekdays = null,}) {
  return _then(ReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderSettings].
extension ReminderSettingsPatterns on ReminderSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int startMinute,  int endMinute,  int intervalMinutes,  Set<int> weekdays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.enabled,_that.startMinute,_that.endMinute,_that.intervalMinutes,_that.weekdays);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int startMinute,  int endMinute,  int intervalMinutes,  Set<int> weekdays)  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings():
return $default(_that.enabled,_that.startMinute,_that.endMinute,_that.intervalMinutes,_that.weekdays);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int startMinute,  int endMinute,  int intervalMinutes,  Set<int> weekdays)?  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.enabled,_that.startMinute,_that.endMinute,_that.intervalMinutes,_that.weekdays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReminderSettings implements ReminderSettings {
  const _ReminderSettings({this.enabled = false, this.startMinute = 8 * 60, this.endMinute = 22 * 60, this.intervalMinutes = 90,  Set<int> weekdays = const {DateTime.monday, DateTime.tuesday, DateTime.wednesday, DateTime.thursday, DateTime.friday, DateTime.saturday, DateTime.sunday}}): _weekdays = weekdays;
  factory _ReminderSettings.fromJson(Map<String, dynamic> json) => _$ReminderSettingsFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int startMinute;
@override@JsonKey() final  int endMinute;
@override@JsonKey() final  int intervalMinutes;
 final  Set<int> _weekdays;
@override@JsonKey() Set<int> get weekdays {
  if (_weekdays is EqualUnmodifiableSetView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_weekdays);
}


/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderSettingsCopyWith<_ReminderSettings> get copyWith => __$ReminderSettingsCopyWithImpl<_ReminderSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReminderSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&(identical(other.intervalMinutes, intervalMinutes) || other.intervalMinutes == intervalMinutes)&&const DeepCollectionEquality().equals(other.weekdays, _weekdays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,startMinute,endMinute,intervalMinutes,const DeepCollectionEquality().hash(_weekdays));
}

@override
String toString() {
    return 'ReminderSettings(enabled: $enabled, startMinute: $startMinute, endMinute: $endMinute, intervalMinutes: $intervalMinutes, weekdays: $weekdays)';
}


}

/// @nodoc
abstract mixin class _$ReminderSettingsCopyWith<$Res> implements $ReminderSettingsCopyWith<$Res> {
  factory _$ReminderSettingsCopyWith(_ReminderSettings value, $Res Function(_ReminderSettings) _then) = __$ReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int startMinute, int endMinute, int intervalMinutes, Set<int> weekdays
});




}
/// @nodoc
class __$ReminderSettingsCopyWithImpl<$Res>
    implements _$ReminderSettingsCopyWith<$Res> {
  __$ReminderSettingsCopyWithImpl(this._self, this._then);

  final _ReminderSettings _self;
  final $Res Function(_ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? startMinute = null,Object? endMinute = null,Object? intervalMinutes = null,Object? weekdays = null,}) {
  return _then(_ReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
