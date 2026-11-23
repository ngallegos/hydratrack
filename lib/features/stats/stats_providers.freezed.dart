// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatsData {

 Map<DateTime, double> get dailyTotals; int get goalMl; int get currentStreak; int get longestStreak; Set<Achievement> get achievements;
/// Create a copy of StatsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsDataCopyWith<StatsData> get copyWith => _$StatsDataCopyWithImpl<StatsData>(this as StatsData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StatsData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsData&&const DeepCollectionEquality().equals(other.dailyTotals, _this.dailyTotals)&&(identical(other.goalMl, _this.goalMl) || other.goalMl == _this.goalMl)&&(identical(other.currentStreak, _this.currentStreak) || other.currentStreak == _this.currentStreak)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak)&&const DeepCollectionEquality().equals(other.achievements, _this.achievements));
}


@override
int get hashCode {
  final _this = this as StatsData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.dailyTotals),_this.goalMl,_this.currentStreak,_this.longestStreak,const DeepCollectionEquality().hash(_this.achievements));
}

@override
String toString() {
  final _this = this as StatsData;
  return 'StatsData(dailyTotals: ${_this.dailyTotals}, goalMl: ${_this.goalMl}, currentStreak: ${_this.currentStreak}, longestStreak: ${_this.longestStreak}, achievements: ${_this.achievements})';
}


}

/// @nodoc
abstract mixin class $StatsDataCopyWith<$Res>  {
  factory $StatsDataCopyWith(StatsData value, $Res Function(StatsData) _then) = _$StatsDataCopyWithImpl;
@useResult
$Res call({
 Map<DateTime, double> dailyTotals, int goalMl, int currentStreak, int longestStreak, Set<Achievement> achievements
});




}
/// @nodoc
class _$StatsDataCopyWithImpl<$Res>
    implements $StatsDataCopyWith<$Res> {
  _$StatsDataCopyWithImpl(this._self, this._then);

  final StatsData _self;
  final $Res Function(StatsData) _then;

/// Create a copy of StatsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailyTotals = null,Object? goalMl = null,Object? currentStreak = null,Object? longestStreak = null,Object? achievements = null,}) {
  return _then(StatsData(
dailyTotals: null == dailyTotals ? _self.dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as Map<DateTime, double>,goalMl: null == goalMl ? _self.goalMl : goalMl // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as Set<Achievement>,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsData].
extension StatsDataPatterns on StatsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsData value)  $default,){
final _that = this;
switch (_that) {
case _StatsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsData value)?  $default,){
final _that = this;
switch (_that) {
case _StatsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<DateTime, double> dailyTotals,  int goalMl,  int currentStreak,  int longestStreak,  Set<Achievement> achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsData() when $default != null:
return $default(_that.dailyTotals,_that.goalMl,_that.currentStreak,_that.longestStreak,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<DateTime, double> dailyTotals,  int goalMl,  int currentStreak,  int longestStreak,  Set<Achievement> achievements)  $default,) {final _that = this;
switch (_that) {
case _StatsData():
return $default(_that.dailyTotals,_that.goalMl,_that.currentStreak,_that.longestStreak,_that.achievements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<DateTime, double> dailyTotals,  int goalMl,  int currentStreak,  int longestStreak,  Set<Achievement> achievements)?  $default,) {final _that = this;
switch (_that) {
case _StatsData() when $default != null:
return $default(_that.dailyTotals,_that.goalMl,_that.currentStreak,_that.longestStreak,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc


class _StatsData implements StatsData {
  const _StatsData({required  Map<DateTime, double> dailyTotals, required this.goalMl, required this.currentStreak, required this.longestStreak, required  Set<Achievement> achievements}): _dailyTotals = dailyTotals,_achievements = achievements;
  

 final  Map<DateTime, double> _dailyTotals;
@override Map<DateTime, double> get dailyTotals {
  if (_dailyTotals is EqualUnmodifiableMapView) return _dailyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dailyTotals);
}

@override final  int goalMl;
@override final  int currentStreak;
@override final  int longestStreak;
 final  Set<Achievement> _achievements;
@override Set<Achievement> get achievements {
  if (_achievements is EqualUnmodifiableSetView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_achievements);
}


/// Create a copy of StatsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsDataCopyWith<_StatsData> get copyWith => __$StatsDataCopyWithImpl<_StatsData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsData&&const DeepCollectionEquality().equals(other.dailyTotals, _dailyTotals)&&(identical(other.goalMl, goalMl) || other.goalMl == goalMl)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&const DeepCollectionEquality().equals(other.achievements, _achievements));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_dailyTotals),goalMl,currentStreak,longestStreak,const DeepCollectionEquality().hash(_achievements));
}

@override
String toString() {
    return 'StatsData(dailyTotals: $dailyTotals, goalMl: $goalMl, currentStreak: $currentStreak, longestStreak: $longestStreak, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$StatsDataCopyWith<$Res> implements $StatsDataCopyWith<$Res> {
  factory _$StatsDataCopyWith(_StatsData value, $Res Function(_StatsData) _then) = __$StatsDataCopyWithImpl;
@override @useResult
$Res call({
 Map<DateTime, double> dailyTotals, int goalMl, int currentStreak, int longestStreak, Set<Achievement> achievements
});




}
/// @nodoc
class __$StatsDataCopyWithImpl<$Res>
    implements _$StatsDataCopyWith<$Res> {
  __$StatsDataCopyWithImpl(this._self, this._then);

  final _StatsData _self;
  final $Res Function(_StatsData) _then;

/// Create a copy of StatsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailyTotals = null,Object? goalMl = null,Object? currentStreak = null,Object? longestStreak = null,Object? achievements = null,}) {
  return _then(_StatsData(
dailyTotals: null == dailyTotals ? _self._dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as Map<DateTime, double>,goalMl: null == goalMl ? _self.goalMl : goalMl // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as Set<Achievement>,
  ));
}


}

// dart format on
