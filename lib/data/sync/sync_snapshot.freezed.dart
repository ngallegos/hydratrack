// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncSnapshot {

 String get deviceId; DateTime get generatedAt; List<DrinkCategory> get categories; List<Drink> get drinks; List<LogEntry> get entries;
/// Create a copy of SyncSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSnapshotCopyWith<SyncSnapshot> get copyWith => _$SyncSnapshotCopyWithImpl<SyncSnapshot>(this as SyncSnapshot, _$identity);

  /// Serializes this SyncSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SyncSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSnapshot&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.drinks, _this.drinks)&&const DeepCollectionEquality().equals(other.entries, _this.entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SyncSnapshot;
  return Object.hash(runtimeType,_this.deviceId,_this.generatedAt,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.drinks),const DeepCollectionEquality().hash(_this.entries));
}

@override
String toString() {
  final _this = this as SyncSnapshot;
  return 'SyncSnapshot(deviceId: ${_this.deviceId}, generatedAt: ${_this.generatedAt}, categories: ${_this.categories}, drinks: ${_this.drinks}, entries: ${_this.entries})';
}


}

/// @nodoc
abstract mixin class $SyncSnapshotCopyWith<$Res>  {
  factory $SyncSnapshotCopyWith(SyncSnapshot value, $Res Function(SyncSnapshot) _then) = _$SyncSnapshotCopyWithImpl;
@useResult
$Res call({
 String deviceId, DateTime generatedAt, List<DrinkCategory> categories, List<Drink> drinks, List<LogEntry> entries
});




}
/// @nodoc
class _$SyncSnapshotCopyWithImpl<$Res>
    implements $SyncSnapshotCopyWith<$Res> {
  _$SyncSnapshotCopyWithImpl(this._self, this._then);

  final SyncSnapshot _self;
  final $Res Function(SyncSnapshot) _then;

/// Create a copy of SyncSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? generatedAt = null,Object? categories = null,Object? drinks = null,Object? entries = null,}) {
  return _then(SyncSnapshot(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<DrinkCategory>,drinks: null == drinks ? _self.drinks : drinks // ignore: cast_nullable_to_non_nullable
as List<Drink>,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSnapshot].
extension SyncSnapshotPatterns on SyncSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _SyncSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  DateTime generatedAt,  List<DrinkCategory> categories,  List<Drink> drinks,  List<LogEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSnapshot() when $default != null:
return $default(_that.deviceId,_that.generatedAt,_that.categories,_that.drinks,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  DateTime generatedAt,  List<DrinkCategory> categories,  List<Drink> drinks,  List<LogEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _SyncSnapshot():
return $default(_that.deviceId,_that.generatedAt,_that.categories,_that.drinks,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  DateTime generatedAt,  List<DrinkCategory> categories,  List<Drink> drinks,  List<LogEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _SyncSnapshot() when $default != null:
return $default(_that.deviceId,_that.generatedAt,_that.categories,_that.drinks,_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncSnapshot implements SyncSnapshot {
  const _SyncSnapshot({required this.deviceId, required this.generatedAt,  List<DrinkCategory> categories = const [],  List<Drink> drinks = const [],  List<LogEntry> entries = const []}): _categories = categories,_drinks = drinks,_entries = entries;
  factory _SyncSnapshot.fromJson(Map<String, dynamic> json) => _$SyncSnapshotFromJson(json);

@override final  String deviceId;
@override final  DateTime generatedAt;
 final  List<DrinkCategory> _categories;
@override@JsonKey() List<DrinkCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Drink> _drinks;
@override@JsonKey() List<Drink> get drinks {
  if (_drinks is EqualUnmodifiableListView) return _drinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drinks);
}

 final  List<LogEntry> _entries;
@override@JsonKey() List<LogEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of SyncSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSnapshotCopyWith<_SyncSnapshot> get copyWith => __$SyncSnapshotCopyWithImpl<_SyncSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSnapshot&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.drinks, _drinks)&&const DeepCollectionEquality().equals(other.entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deviceId,generatedAt,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_drinks),const DeepCollectionEquality().hash(_entries));
}

@override
String toString() {
    return 'SyncSnapshot(deviceId: $deviceId, generatedAt: $generatedAt, categories: $categories, drinks: $drinks, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$SyncSnapshotCopyWith<$Res> implements $SyncSnapshotCopyWith<$Res> {
  factory _$SyncSnapshotCopyWith(_SyncSnapshot value, $Res Function(_SyncSnapshot) _then) = __$SyncSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, DateTime generatedAt, List<DrinkCategory> categories, List<Drink> drinks, List<LogEntry> entries
});




}
/// @nodoc
class __$SyncSnapshotCopyWithImpl<$Res>
    implements _$SyncSnapshotCopyWith<$Res> {
  __$SyncSnapshotCopyWithImpl(this._self, this._then);

  final _SyncSnapshot _self;
  final $Res Function(_SyncSnapshot) _then;

/// Create a copy of SyncSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? generatedAt = null,Object? categories = null,Object? drinks = null,Object? entries = null,}) {
  return _then(_SyncSnapshot(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<DrinkCategory>,drinks: null == drinks ? _self._drinks : drinks // ignore: cast_nullable_to_non_nullable
as List<Drink>,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,
  ));
}


}

// dart format on
