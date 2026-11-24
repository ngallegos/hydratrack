// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drink_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DrinkCategory {

 String get id; String get name; int get colorValue; double get hydrationFactor; int get sortOrder; DateTime get updatedAt; String get deviceId; bool get deleted;
/// Create a copy of DrinkCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrinkCategoryCopyWith<DrinkCategory> get copyWith => _$DrinkCategoryCopyWithImpl<DrinkCategory>(this as DrinkCategory, _$identity);

  /// Serializes this DrinkCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DrinkCategory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrinkCategory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.colorValue, _this.colorValue) || other.colorValue == _this.colorValue)&&(identical(other.hydrationFactor, _this.hydrationFactor) || other.hydrationFactor == _this.hydrationFactor)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DrinkCategory;
  return Object.hash(runtimeType,_this.id,_this.name,_this.colorValue,_this.hydrationFactor,_this.sortOrder,_this.updatedAt,_this.deviceId,_this.deleted);
}

@override
String toString() {
  final _this = this as DrinkCategory;
  return 'DrinkCategory(id: ${_this.id}, name: ${_this.name}, colorValue: ${_this.colorValue}, hydrationFactor: ${_this.hydrationFactor}, sortOrder: ${_this.sortOrder}, updatedAt: ${_this.updatedAt}, deviceId: ${_this.deviceId}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $DrinkCategoryCopyWith<$Res>  {
  factory $DrinkCategoryCopyWith(DrinkCategory value, $Res Function(DrinkCategory) _then) = _$DrinkCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, int colorValue, double hydrationFactor, int sortOrder, DateTime updatedAt, String deviceId, bool deleted
});




}
/// @nodoc
class _$DrinkCategoryCopyWithImpl<$Res>
    implements $DrinkCategoryCopyWith<$Res> {
  _$DrinkCategoryCopyWithImpl(this._self, this._then);

  final DrinkCategory _self;
  final $Res Function(DrinkCategory) _then;

/// Create a copy of DrinkCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? colorValue = null,Object? hydrationFactor = null,Object? sortOrder = null,Object? updatedAt = null,Object? deviceId = null,Object? deleted = null,}) {
  return _then(DrinkCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,hydrationFactor: null == hydrationFactor ? _self.hydrationFactor : hydrationFactor // ignore: cast_nullable_to_non_nullable
as double,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DrinkCategory].
extension DrinkCategoryPatterns on DrinkCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrinkCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrinkCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrinkCategory value)  $default,){
final _that = this;
switch (_that) {
case _DrinkCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrinkCategory value)?  $default,){
final _that = this;
switch (_that) {
case _DrinkCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int colorValue,  double hydrationFactor,  int sortOrder,  DateTime updatedAt,  String deviceId,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrinkCategory() when $default != null:
return $default(_that.id,_that.name,_that.colorValue,_that.hydrationFactor,_that.sortOrder,_that.updatedAt,_that.deviceId,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int colorValue,  double hydrationFactor,  int sortOrder,  DateTime updatedAt,  String deviceId,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _DrinkCategory():
return $default(_that.id,_that.name,_that.colorValue,_that.hydrationFactor,_that.sortOrder,_that.updatedAt,_that.deviceId,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int colorValue,  double hydrationFactor,  int sortOrder,  DateTime updatedAt,  String deviceId,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _DrinkCategory() when $default != null:
return $default(_that.id,_that.name,_that.colorValue,_that.hydrationFactor,_that.sortOrder,_that.updatedAt,_that.deviceId,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DrinkCategory implements DrinkCategory {
  const _DrinkCategory({required this.id, required this.name, required this.colorValue, required this.hydrationFactor, required this.sortOrder, required this.updatedAt, required this.deviceId, this.deleted = false});
  factory _DrinkCategory.fromJson(Map<String, dynamic> json) => _$DrinkCategoryFromJson(json);

@override final  String id;
@override final  String name;
@override final  int colorValue;
@override final  double hydrationFactor;
@override final  int sortOrder;
@override final  DateTime updatedAt;
@override final  String deviceId;
@override@JsonKey() final  bool deleted;

/// Create a copy of DrinkCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrinkCategoryCopyWith<_DrinkCategory> get copyWith => __$DrinkCategoryCopyWithImpl<_DrinkCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DrinkCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrinkCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.hydrationFactor, hydrationFactor) || other.hydrationFactor == hydrationFactor)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,colorValue,hydrationFactor,sortOrder,updatedAt,deviceId,deleted);
}

@override
String toString() {
    return 'DrinkCategory(id: $id, name: $name, colorValue: $colorValue, hydrationFactor: $hydrationFactor, sortOrder: $sortOrder, updatedAt: $updatedAt, deviceId: $deviceId, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$DrinkCategoryCopyWith<$Res> implements $DrinkCategoryCopyWith<$Res> {
  factory _$DrinkCategoryCopyWith(_DrinkCategory value, $Res Function(_DrinkCategory) _then) = __$DrinkCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int colorValue, double hydrationFactor, int sortOrder, DateTime updatedAt, String deviceId, bool deleted
});




}
/// @nodoc
class __$DrinkCategoryCopyWithImpl<$Res>
    implements _$DrinkCategoryCopyWith<$Res> {
  __$DrinkCategoryCopyWithImpl(this._self, this._then);

  final _DrinkCategory _self;
  final $Res Function(_DrinkCategory) _then;

/// Create a copy of DrinkCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? colorValue = null,Object? hydrationFactor = null,Object? sortOrder = null,Object? updatedAt = null,Object? deviceId = null,Object? deleted = null,}) {
  return _then(_DrinkCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,hydrationFactor: null == hydrationFactor ? _self.hydrationFactor : hydrationFactor // ignore: cast_nullable_to_non_nullable
as double,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
