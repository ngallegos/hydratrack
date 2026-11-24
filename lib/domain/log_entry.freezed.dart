// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LogEntry {

 String get id; String get categoryId; int get volumeMl; DateTime get loggedAt; DateTime get updatedAt; String get deviceId; bool get deleted;
/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogEntryCopyWith<LogEntry> get copyWith => _$LogEntryCopyWithImpl<LogEntry>(this as LogEntry, _$identity);

  /// Serializes this LogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LogEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.loggedAt, _this.loggedAt) || other.loggedAt == _this.loggedAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LogEntry;
  return Object.hash(runtimeType,_this.id,_this.categoryId,_this.volumeMl,_this.loggedAt,_this.updatedAt,_this.deviceId,_this.deleted);
}

@override
String toString() {
  final _this = this as LogEntry;
  return 'LogEntry(id: ${_this.id}, categoryId: ${_this.categoryId}, volumeMl: ${_this.volumeMl}, loggedAt: ${_this.loggedAt}, updatedAt: ${_this.updatedAt}, deviceId: ${_this.deviceId}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $LogEntryCopyWith<$Res>  {
  factory $LogEntryCopyWith(LogEntry value, $Res Function(LogEntry) _then) = _$LogEntryCopyWithImpl;
@useResult
$Res call({
 String id, String categoryId, int volumeMl, DateTime loggedAt, DateTime updatedAt, String deviceId, bool deleted
});




}
/// @nodoc
class _$LogEntryCopyWithImpl<$Res>
    implements $LogEntryCopyWith<$Res> {
  _$LogEntryCopyWithImpl(this._self, this._then);

  final LogEntry _self;
  final $Res Function(LogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? volumeMl = null,Object? loggedAt = null,Object? updatedAt = null,Object? deviceId = null,Object? deleted = null,}) {
  return _then(LogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,loggedAt: null == loggedAt ? _self.loggedAt : loggedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LogEntry].
extension LogEntryPatterns on LogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogEntry value)  $default,){
final _that = this;
switch (_that) {
case _LogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryId,  int volumeMl,  DateTime loggedAt,  DateTime updatedAt,  String deviceId,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogEntry() when $default != null:
return $default(_that.id,_that.categoryId,_that.volumeMl,_that.loggedAt,_that.updatedAt,_that.deviceId,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryId,  int volumeMl,  DateTime loggedAt,  DateTime updatedAt,  String deviceId,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _LogEntry():
return $default(_that.id,_that.categoryId,_that.volumeMl,_that.loggedAt,_that.updatedAt,_that.deviceId,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryId,  int volumeMl,  DateTime loggedAt,  DateTime updatedAt,  String deviceId,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _LogEntry() when $default != null:
return $default(_that.id,_that.categoryId,_that.volumeMl,_that.loggedAt,_that.updatedAt,_that.deviceId,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LogEntry implements LogEntry {
  const _LogEntry({required this.id, required this.categoryId, required this.volumeMl, required this.loggedAt, required this.updatedAt, required this.deviceId, this.deleted = false});
  factory _LogEntry.fromJson(Map<String, dynamic> json) => _$LogEntryFromJson(json);

@override final  String id;
@override final  String categoryId;
@override final  int volumeMl;
@override final  DateTime loggedAt;
@override final  DateTime updatedAt;
@override final  String deviceId;
@override@JsonKey() final  bool deleted;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogEntryCopyWith<_LogEntry> get copyWith => __$LogEntryCopyWithImpl<_LogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.loggedAt, loggedAt) || other.loggedAt == loggedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,categoryId,volumeMl,loggedAt,updatedAt,deviceId,deleted);
}

@override
String toString() {
    return 'LogEntry(id: $id, categoryId: $categoryId, volumeMl: $volumeMl, loggedAt: $loggedAt, updatedAt: $updatedAt, deviceId: $deviceId, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$LogEntryCopyWith<$Res> implements $LogEntryCopyWith<$Res> {
  factory _$LogEntryCopyWith(_LogEntry value, $Res Function(_LogEntry) _then) = __$LogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryId, int volumeMl, DateTime loggedAt, DateTime updatedAt, String deviceId, bool deleted
});




}
/// @nodoc
class __$LogEntryCopyWithImpl<$Res>
    implements _$LogEntryCopyWith<$Res> {
  __$LogEntryCopyWithImpl(this._self, this._then);

  final _LogEntry _self;
  final $Res Function(_LogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? volumeMl = null,Object? loggedAt = null,Object? updatedAt = null,Object? deviceId = null,Object? deleted = null,}) {
  return _then(_LogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,loggedAt: null == loggedAt ? _self.loggedAt : loggedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
