// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductUnit {

 String get id; String get name; String get symbol;
/// Create a copy of ProductUnit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductUnitCopyWith<ProductUnit> get copyWith => _$ProductUnitCopyWithImpl<ProductUnit>(this as ProductUnit, _$identity);

  /// Serializes this ProductUnit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductUnit&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,symbol);

@override
String toString() {
  return 'ProductUnit(id: $id, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class $ProductUnitCopyWith<$Res>  {
  factory $ProductUnitCopyWith(ProductUnit value, $Res Function(ProductUnit) _then) = _$ProductUnitCopyWithImpl;
@useResult
$Res call({
 String id, String name, String symbol
});




}
/// @nodoc
class _$ProductUnitCopyWithImpl<$Res>
    implements $ProductUnitCopyWith<$Res> {
  _$ProductUnitCopyWithImpl(this._self, this._then);

  final ProductUnit _self;
  final $Res Function(ProductUnit) _then;

/// Create a copy of ProductUnit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? symbol = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductUnit].
extension ProductUnitPatterns on ProductUnit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductUnit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductUnit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductUnit value)  $default,){
final _that = this;
switch (_that) {
case _ProductUnit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductUnit value)?  $default,){
final _that = this;
switch (_that) {
case _ProductUnit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String symbol)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductUnit() when $default != null:
return $default(_that.id,_that.name,_that.symbol);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String symbol)  $default,) {final _that = this;
switch (_that) {
case _ProductUnit():
return $default(_that.id,_that.name,_that.symbol);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String symbol)?  $default,) {final _that = this;
switch (_that) {
case _ProductUnit() when $default != null:
return $default(_that.id,_that.name,_that.symbol);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductUnit implements ProductUnit {
  const _ProductUnit({required this.id, required this.name, required this.symbol});
  factory _ProductUnit.fromJson(Map<String, dynamic> json) => _$ProductUnitFromJson(json);

@override final  String id;
@override final  String name;
@override final  String symbol;

/// Create a copy of ProductUnit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductUnitCopyWith<_ProductUnit> get copyWith => __$ProductUnitCopyWithImpl<_ProductUnit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductUnitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductUnit&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,symbol);

@override
String toString() {
  return 'ProductUnit(id: $id, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class _$ProductUnitCopyWith<$Res> implements $ProductUnitCopyWith<$Res> {
  factory _$ProductUnitCopyWith(_ProductUnit value, $Res Function(_ProductUnit) _then) = __$ProductUnitCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String symbol
});




}
/// @nodoc
class __$ProductUnitCopyWithImpl<$Res>
    implements _$ProductUnitCopyWith<$Res> {
  __$ProductUnitCopyWithImpl(this._self, this._then);

  final _ProductUnit _self;
  final $Res Function(_ProductUnit) _then;

/// Create a copy of ProductUnit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? symbol = null,}) {
  return _then(_ProductUnit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
