// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaxConfig {

 bool get gstEnabled; String? get gstin; String? get state; double get defaultTaxRate; String get taxType;
/// Create a copy of TaxConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxConfigCopyWith<TaxConfig> get copyWith => _$TaxConfigCopyWithImpl<TaxConfig>(this as TaxConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxConfig&&(identical(other.gstEnabled, gstEnabled) || other.gstEnabled == gstEnabled)&&(identical(other.gstin, gstin) || other.gstin == gstin)&&(identical(other.state, state) || other.state == state)&&(identical(other.defaultTaxRate, defaultTaxRate) || other.defaultTaxRate == defaultTaxRate)&&(identical(other.taxType, taxType) || other.taxType == taxType));
}


@override
int get hashCode => Object.hash(runtimeType,gstEnabled,gstin,state,defaultTaxRate,taxType);

@override
String toString() {
  return 'TaxConfig(gstEnabled: $gstEnabled, gstin: $gstin, state: $state, defaultTaxRate: $defaultTaxRate, taxType: $taxType)';
}


}

/// @nodoc
abstract mixin class $TaxConfigCopyWith<$Res>  {
  factory $TaxConfigCopyWith(TaxConfig value, $Res Function(TaxConfig) _then) = _$TaxConfigCopyWithImpl;
@useResult
$Res call({
 bool gstEnabled, String? gstin, String? state, double defaultTaxRate, String taxType
});




}
/// @nodoc
class _$TaxConfigCopyWithImpl<$Res>
    implements $TaxConfigCopyWith<$Res> {
  _$TaxConfigCopyWithImpl(this._self, this._then);

  final TaxConfig _self;
  final $Res Function(TaxConfig) _then;

/// Create a copy of TaxConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gstEnabled = null,Object? gstin = freezed,Object? state = freezed,Object? defaultTaxRate = null,Object? taxType = null,}) {
  return _then(_self.copyWith(
gstEnabled: null == gstEnabled ? _self.gstEnabled : gstEnabled // ignore: cast_nullable_to_non_nullable
as bool,gstin: freezed == gstin ? _self.gstin : gstin // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,defaultTaxRate: null == defaultTaxRate ? _self.defaultTaxRate : defaultTaxRate // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxConfig].
extension TaxConfigPatterns on TaxConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxConfig value)  $default,){
final _that = this;
switch (_that) {
case _TaxConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TaxConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool gstEnabled,  String? gstin,  String? state,  double defaultTaxRate,  String taxType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxConfig() when $default != null:
return $default(_that.gstEnabled,_that.gstin,_that.state,_that.defaultTaxRate,_that.taxType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool gstEnabled,  String? gstin,  String? state,  double defaultTaxRate,  String taxType)  $default,) {final _that = this;
switch (_that) {
case _TaxConfig():
return $default(_that.gstEnabled,_that.gstin,_that.state,_that.defaultTaxRate,_that.taxType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool gstEnabled,  String? gstin,  String? state,  double defaultTaxRate,  String taxType)?  $default,) {final _that = this;
switch (_that) {
case _TaxConfig() when $default != null:
return $default(_that.gstEnabled,_that.gstin,_that.state,_that.defaultTaxRate,_that.taxType);case _:
  return null;

}
}

}

/// @nodoc


class _TaxConfig implements TaxConfig {
  const _TaxConfig({required this.gstEnabled, this.gstin, this.state, required this.defaultTaxRate, required this.taxType});
  

@override final  bool gstEnabled;
@override final  String? gstin;
@override final  String? state;
@override final  double defaultTaxRate;
@override final  String taxType;

/// Create a copy of TaxConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxConfigCopyWith<_TaxConfig> get copyWith => __$TaxConfigCopyWithImpl<_TaxConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxConfig&&(identical(other.gstEnabled, gstEnabled) || other.gstEnabled == gstEnabled)&&(identical(other.gstin, gstin) || other.gstin == gstin)&&(identical(other.state, state) || other.state == state)&&(identical(other.defaultTaxRate, defaultTaxRate) || other.defaultTaxRate == defaultTaxRate)&&(identical(other.taxType, taxType) || other.taxType == taxType));
}


@override
int get hashCode => Object.hash(runtimeType,gstEnabled,gstin,state,defaultTaxRate,taxType);

@override
String toString() {
  return 'TaxConfig(gstEnabled: $gstEnabled, gstin: $gstin, state: $state, defaultTaxRate: $defaultTaxRate, taxType: $taxType)';
}


}

/// @nodoc
abstract mixin class _$TaxConfigCopyWith<$Res> implements $TaxConfigCopyWith<$Res> {
  factory _$TaxConfigCopyWith(_TaxConfig value, $Res Function(_TaxConfig) _then) = __$TaxConfigCopyWithImpl;
@override @useResult
$Res call({
 bool gstEnabled, String? gstin, String? state, double defaultTaxRate, String taxType
});




}
/// @nodoc
class __$TaxConfigCopyWithImpl<$Res>
    implements _$TaxConfigCopyWith<$Res> {
  __$TaxConfigCopyWithImpl(this._self, this._then);

  final _TaxConfig _self;
  final $Res Function(_TaxConfig) _then;

/// Create a copy of TaxConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gstEnabled = null,Object? gstin = freezed,Object? state = freezed,Object? defaultTaxRate = null,Object? taxType = null,}) {
  return _then(_TaxConfig(
gstEnabled: null == gstEnabled ? _self.gstEnabled : gstEnabled // ignore: cast_nullable_to_non_nullable
as bool,gstin: freezed == gstin ? _self.gstin : gstin // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,defaultTaxRate: null == defaultTaxRate ? _self.defaultTaxRate : defaultTaxRate // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
