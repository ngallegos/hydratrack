// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drink.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Drink {

 String get id; String get categoryId; String get name; int get volumeMl; DateTime get updatedAt; String get deviceId; bool get starred; bool get deleted;
/// Create a copy of Drink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrinkCopyWith<Drink> get copyWith => _$DrinkCopyWithImpl<Drink>(this as Drink, _$identity);

  /// Serializes this Drink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Drink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Drink&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.starred, _this.starred) || other.starred == _this.starred)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Drink;
  return Object.hash(runtimeType,_this.id,_this.categoryId,_this.name,_this.volumeMl,_this.updatedAt,_this.deviceId,_this.starred,_this.deleted);
}

@override
String toString() {
  final _this = this as Drink;
  return 'Drink(id: ${_this.id}, categoryId: ${_this.categoryId}, name: ${_this.name}, volumeMl: ${_this.volumeMl}, updatedAt: ${_this.updatedAt}, deviceId: ${_this.deviceId}, starred: ${_this.starred}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $DrinkCopyWith<$Res>  {
  factory $DrinkCopyWith(Drink value, $Res Function(Drink) _then) = _$DrinkCopyWithImpl;
@useResult
$Res call({
 String id, String categoryId, String name, int volumeMl, DateTime updatedAt, String deviceId, bool starred, bool deleted
});




}
/// @nodoc
class _$DrinkCopyWithImpl<$Res>
    implements $DrinkCopyWith<$Res> {
  _$DrinkCopyWithImpl(this._self, this._then);

  final Drink _self;
  final $Res Function(Drink) _then;

/// Create a copy of Drink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? volumeMl = null,Object? updatedAt = null,Object? deviceId = null,Object? starred = null,Object? deleted = null,}) {
  return _then(Drink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Drink].
extension DrinkPatterns on Drink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Drink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Drink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Drink value)  $default,){
final _that = this;
switch (_that) {
case _Drink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Drink value)?  $default,){
final _that = this;
switch (_that) {
case _Drink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  int volumeMl,  DateTime updatedAt,  String deviceId,  bool starred,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Drink() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.volumeMl,_that.updatedAt,_that.deviceId,_that.starred,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryId,  String name,  int volumeMl,  DateTime updatedAt,  String deviceId,  bool starred,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _Drink():
return $default(_that.id,_that.categoryId,_that.name,_that.volumeMl,_that.updatedAt,_that.deviceId,_that.starred,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryId,  String name,  int volumeMl,  DateTime updatedAt,  String deviceId,  bool starred,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _Drink() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.volumeMl,_that.updatedAt,_that.deviceId,_that.starred,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Drink implements Drink {
  const _Drink({required this.id, required this.categoryId, required this.name, required this.volumeMl, required this.updatedAt, required this.deviceId, this.starred = false, this.deleted = false});
  factory _Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);

@override final  String id;
@override final  String categoryId;
@override final  String name;
@override final  int volumeMl;
@override final  DateTime updatedAt;
@override final  String deviceId;
@override@JsonKey() final  bool starred;
@override@JsonKey() final  bool deleted;

/// Create a copy of Drink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrinkCopyWith<_Drink> get copyWith => __$DrinkCopyWithImpl<_Drink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DrinkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Drink&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.starred, starred) || other.starred == starred)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,categoryId,name,volumeMl,updatedAt,deviceId,starred,deleted);
}

@override
String toString() {
    return 'Drink(id: $id, categoryId: $categoryId, name: $name, volumeMl: $volumeMl, updatedAt: $updatedAt, deviceId: $deviceId, starred: $starred, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$DrinkCopyWith<$Res> implements $DrinkCopyWith<$Res> {
  factory _$DrinkCopyWith(_Drink value, $Res Function(_Drink) _then) = __$DrinkCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryId, String name, int volumeMl, DateTime updatedAt, String deviceId, bool starred, bool deleted
});




}
/// @nodoc
class __$DrinkCopyWithImpl<$Res>
    implements _$DrinkCopyWith<$Res> {
  __$DrinkCopyWithImpl(this._self, this._then);

  final _Drink _self;
  final $Res Function(_Drink) _then;

/// Create a copy of Drink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? volumeMl = null,Object? updatedAt = null,Object? deviceId = null,Object? starred = null,Object? deleted = null,}) {
  return _then(_Drink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,starred: null == starred ? _self.starred : starred // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
