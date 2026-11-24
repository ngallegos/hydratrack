// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_band.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvatarBand {

 String get categoryId; int get colorValue; double get start; double get end;
/// Create a copy of AvatarBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarBandCopyWith<AvatarBand> get copyWith => _$AvatarBandCopyWithImpl<AvatarBand>(this as AvatarBand, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AvatarBand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarBand&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.colorValue, _this.colorValue) || other.colorValue == _this.colorValue)&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.end, _this.end) || other.end == _this.end));
}


@override
int get hashCode {
  final _this = this as AvatarBand;
  return Object.hash(runtimeType,_this.categoryId,_this.colorValue,_this.start,_this.end);
}

@override
String toString() {
  final _this = this as AvatarBand;
  return 'AvatarBand(categoryId: ${_this.categoryId}, colorValue: ${_this.colorValue}, start: ${_this.start}, end: ${_this.end})';
}


}

/// @nodoc
abstract mixin class $AvatarBandCopyWith<$Res>  {
  factory $AvatarBandCopyWith(AvatarBand value, $Res Function(AvatarBand) _then) = _$AvatarBandCopyWithImpl;
@useResult
$Res call({
 String categoryId, int colorValue, double start, double end
});




}
/// @nodoc
class _$AvatarBandCopyWithImpl<$Res>
    implements $AvatarBandCopyWith<$Res> {
  _$AvatarBandCopyWithImpl(this._self, this._then);

  final AvatarBand _self;
  final $Res Function(AvatarBand) _then;

/// Create a copy of AvatarBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? colorValue = null,Object? start = null,Object? end = null,}) {
  return _then(AvatarBand(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AvatarBand].
extension AvatarBandPatterns on AvatarBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvatarBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvatarBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvatarBand value)  $default,){
final _that = this;
switch (_that) {
case _AvatarBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvatarBand value)?  $default,){
final _that = this;
switch (_that) {
case _AvatarBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  int colorValue,  double start,  double end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvatarBand() when $default != null:
return $default(_that.categoryId,_that.colorValue,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  int colorValue,  double start,  double end)  $default,) {final _that = this;
switch (_that) {
case _AvatarBand():
return $default(_that.categoryId,_that.colorValue,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  int colorValue,  double start,  double end)?  $default,) {final _that = this;
switch (_that) {
case _AvatarBand() when $default != null:
return $default(_that.categoryId,_that.colorValue,_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _AvatarBand implements AvatarBand {
  const _AvatarBand({required this.categoryId, required this.colorValue, required this.start, required this.end});
  

@override final  String categoryId;
@override final  int colorValue;
@override final  double start;
@override final  double end;

/// Create a copy of AvatarBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvatarBandCopyWith<_AvatarBand> get copyWith => __$AvatarBandCopyWithImpl<_AvatarBand>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvatarBand&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode {
    return Object.hash(runtimeType,categoryId,colorValue,start,end);
}

@override
String toString() {
    return 'AvatarBand(categoryId: $categoryId, colorValue: $colorValue, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$AvatarBandCopyWith<$Res> implements $AvatarBandCopyWith<$Res> {
  factory _$AvatarBandCopyWith(_AvatarBand value, $Res Function(_AvatarBand) _then) = __$AvatarBandCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, int colorValue, double start, double end
});




}
/// @nodoc
class __$AvatarBandCopyWithImpl<$Res>
    implements _$AvatarBandCopyWith<$Res> {
  __$AvatarBandCopyWithImpl(this._self, this._then);

  final _AvatarBand _self;
  final $Res Function(_AvatarBand) _then;

/// Create a copy of AvatarBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? colorValue = null,Object? start = null,Object? end = null,}) {
  return _then(_AvatarBand(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,colorValue: null == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
