// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 int get dailyGoalMl; AvatarShape get avatarShape; ActivityLevel get activity; bool get onboardingDone; ReminderSettings get reminders; SyncMode get syncMode; String? get syncFolderPath; DateTime? get lastSyncAt; double? get weightKg;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.dailyGoalMl, _this.dailyGoalMl) || other.dailyGoalMl == _this.dailyGoalMl)&&(identical(other.avatarShape, _this.avatarShape) || other.avatarShape == _this.avatarShape)&&(identical(other.activity, _this.activity) || other.activity == _this.activity)&&(identical(other.onboardingDone, _this.onboardingDone) || other.onboardingDone == _this.onboardingDone)&&(identical(other.reminders, _this.reminders) || other.reminders == _this.reminders)&&(identical(other.syncMode, _this.syncMode) || other.syncMode == _this.syncMode)&&(identical(other.syncFolderPath, _this.syncFolderPath) || other.syncFolderPath == _this.syncFolderPath)&&(identical(other.lastSyncAt, _this.lastSyncAt) || other.lastSyncAt == _this.lastSyncAt)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.dailyGoalMl,_this.avatarShape,_this.activity,_this.onboardingDone,_this.reminders,_this.syncMode,_this.syncFolderPath,_this.lastSyncAt,_this.weightKg);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(dailyGoalMl: ${_this.dailyGoalMl}, avatarShape: ${_this.avatarShape}, activity: ${_this.activity}, onboardingDone: ${_this.onboardingDone}, reminders: ${_this.reminders}, syncMode: ${_this.syncMode}, syncFolderPath: ${_this.syncFolderPath}, lastSyncAt: ${_this.lastSyncAt}, weightKg: ${_this.weightKg})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 int dailyGoalMl, AvatarShape avatarShape, ActivityLevel activity, bool onboardingDone, ReminderSettings reminders, SyncMode syncMode, String? syncFolderPath, DateTime? lastSyncAt, double? weightKg
});


$ReminderSettingsCopyWith<$Res> get reminders;

}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailyGoalMl = null,Object? avatarShape = null,Object? activity = null,Object? onboardingDone = null,Object? reminders = null,Object? syncMode = null,Object? syncFolderPath = freezed,Object? lastSyncAt = freezed,Object? weightKg = freezed,}) {
  return _then(AppSettings(
dailyGoalMl: null == dailyGoalMl ? _self.dailyGoalMl : dailyGoalMl // ignore: cast_nullable_to_non_nullable
as int,avatarShape: null == avatarShape ? _self.avatarShape : avatarShape // ignore: cast_nullable_to_non_nullable
as AvatarShape,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as ActivityLevel,onboardingDone: null == onboardingDone ? _self.onboardingDone : onboardingDone // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as ReminderSettings,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,syncFolderPath: freezed == syncFolderPath ? _self.syncFolderPath : syncFolderPath // ignore: cast_nullable_to_non_nullable
as String?,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as DateTime?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<$Res> get reminders {
  
  return $ReminderSettingsCopyWith<$Res>(_self.reminders, (value) {
    return _then(_self.copyWith(reminders: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dailyGoalMl,  AvatarShape avatarShape,  ActivityLevel activity,  bool onboardingDone,  ReminderSettings reminders,  SyncMode syncMode,  String? syncFolderPath,  DateTime? lastSyncAt,  double? weightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.dailyGoalMl,_that.avatarShape,_that.activity,_that.onboardingDone,_that.reminders,_that.syncMode,_that.syncFolderPath,_that.lastSyncAt,_that.weightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dailyGoalMl,  AvatarShape avatarShape,  ActivityLevel activity,  bool onboardingDone,  ReminderSettings reminders,  SyncMode syncMode,  String? syncFolderPath,  DateTime? lastSyncAt,  double? weightKg)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.dailyGoalMl,_that.avatarShape,_that.activity,_that.onboardingDone,_that.reminders,_that.syncMode,_that.syncFolderPath,_that.lastSyncAt,_that.weightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dailyGoalMl,  AvatarShape avatarShape,  ActivityLevel activity,  bool onboardingDone,  ReminderSettings reminders,  SyncMode syncMode,  String? syncFolderPath,  DateTime? lastSyncAt,  double? weightKg)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.dailyGoalMl,_that.avatarShape,_that.activity,_that.onboardingDone,_that.reminders,_that.syncMode,_that.syncFolderPath,_that.lastSyncAt,_that.weightKg);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.dailyGoalMl = defaultDailyGoalMl, this.avatarShape = AvatarShape.bottle, this.activity = ActivityLevel.sedentary, this.onboardingDone = false, this.reminders = const ReminderSettings(), this.syncMode = SyncMode.off, this.syncFolderPath, this.lastSyncAt, this.weightKg});
  

@override@JsonKey() final  int dailyGoalMl;
@override@JsonKey() final  AvatarShape avatarShape;
@override@JsonKey() final  ActivityLevel activity;
@override@JsonKey() final  bool onboardingDone;
@override@JsonKey() final  ReminderSettings reminders;
@override@JsonKey() final  SyncMode syncMode;
@override final  String? syncFolderPath;
@override final  DateTime? lastSyncAt;
@override final  double? weightKg;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.dailyGoalMl, dailyGoalMl) || other.dailyGoalMl == dailyGoalMl)&&(identical(other.avatarShape, avatarShape) || other.avatarShape == avatarShape)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.onboardingDone, onboardingDone) || other.onboardingDone == onboardingDone)&&(identical(other.reminders, reminders) || other.reminders == reminders)&&(identical(other.syncMode, syncMode) || other.syncMode == syncMode)&&(identical(other.syncFolderPath, syncFolderPath) || other.syncFolderPath == syncFolderPath)&&(identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dailyGoalMl,avatarShape,activity,onboardingDone,reminders,syncMode,syncFolderPath,lastSyncAt,weightKg);
}

@override
String toString() {
    return 'AppSettings(dailyGoalMl: $dailyGoalMl, avatarShape: $avatarShape, activity: $activity, onboardingDone: $onboardingDone, reminders: $reminders, syncMode: $syncMode, syncFolderPath: $syncFolderPath, lastSyncAt: $lastSyncAt, weightKg: $weightKg)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 int dailyGoalMl, AvatarShape avatarShape, ActivityLevel activity, bool onboardingDone, ReminderSettings reminders, SyncMode syncMode, String? syncFolderPath, DateTime? lastSyncAt, double? weightKg
});


@override $ReminderSettingsCopyWith<$Res> get reminders;

}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailyGoalMl = null,Object? avatarShape = null,Object? activity = null,Object? onboardingDone = null,Object? reminders = null,Object? syncMode = null,Object? syncFolderPath = freezed,Object? lastSyncAt = freezed,Object? weightKg = freezed,}) {
  return _then(_AppSettings(
dailyGoalMl: null == dailyGoalMl ? _self.dailyGoalMl : dailyGoalMl // ignore: cast_nullable_to_non_nullable
as int,avatarShape: null == avatarShape ? _self.avatarShape : avatarShape // ignore: cast_nullable_to_non_nullable
as AvatarShape,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as ActivityLevel,onboardingDone: null == onboardingDone ? _self.onboardingDone : onboardingDone // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as ReminderSettings,syncMode: null == syncMode ? _self.syncMode : syncMode // ignore: cast_nullable_to_non_nullable
as SyncMode,syncFolderPath: freezed == syncFolderPath ? _self.syncFolderPath : syncFolderPath // ignore: cast_nullable_to_non_nullable
as String?,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as DateTime?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<$Res> get reminders {
  
  return $ReminderSettingsCopyWith<$Res>(_self.reminders, (value) {
    return _then(_self.copyWith(reminders: value));
  });
}
}

// dart format on
