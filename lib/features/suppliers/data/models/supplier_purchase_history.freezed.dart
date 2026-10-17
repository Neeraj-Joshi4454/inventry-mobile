// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_purchase_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupplierPurchaseSummary {

 int get totalPurchases; double get totalAmount; double get totalQuantityPurchased; double get outstandingAmount;
/// Create a copy of SupplierPurchaseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplierPurchaseSummaryCopyWith<SupplierPurchaseSummary> get copyWith => _$SupplierPurchaseSummaryCopyWithImpl<SupplierPurchaseSummary>(this as SupplierPurchaseSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupplierPurchaseSummary&&(identical(other.totalPurchases, totalPurchases) || other.totalPurchases == totalPurchases)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalQuantityPurchased, totalQuantityPurchased) || other.totalQuantityPurchased == totalQuantityPurchased)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalPurchases,totalAmount,totalQuantityPurchased,outstandingAmount);

@override
String toString() {
  return 'SupplierPurchaseSummary(totalPurchases: $totalPurchases, totalAmount: $totalAmount, totalQuantityPurchased: $totalQuantityPurchased, outstandingAmount: $outstandingAmount)';
}


}

/// @nodoc
abstract mixin class $SupplierPurchaseSummaryCopyWith<$Res>  {
  factory $SupplierPurchaseSummaryCopyWith(SupplierPurchaseSummary value, $Res Function(SupplierPurchaseSummary) _then) = _$SupplierPurchaseSummaryCopyWithImpl;
@useResult
$Res call({
 int totalPurchases, double totalAmount, double totalQuantityPurchased, double outstandingAmount
});




}
/// @nodoc
class _$SupplierPurchaseSummaryCopyWithImpl<$Res>
    implements $SupplierPurchaseSummaryCopyWith<$Res> {
  _$SupplierPurchaseSummaryCopyWithImpl(this._self, this._then);

  final SupplierPurchaseSummary _self;
  final $Res Function(SupplierPurchaseSummary) _then;

/// Create a copy of SupplierPurchaseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPurchases = null,Object? totalAmount = null,Object? totalQuantityPurchased = null,Object? outstandingAmount = null,}) {
  return _then(_self.copyWith(
totalPurchases: null == totalPurchases ? _self.totalPurchases : totalPurchases // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalQuantityPurchased: null == totalQuantityPurchased ? _self.totalQuantityPurchased : totalQuantityPurchased // ignore: cast_nullable_to_non_nullable
as double,outstandingAmount: null == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SupplierPurchaseSummary].
extension SupplierPurchaseSummaryPatterns on SupplierPurchaseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupplierPurchaseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupplierPurchaseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupplierPurchaseSummary value)  $default,){
final _that = this;
switch (_that) {
case _SupplierPurchaseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupplierPurchaseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SupplierPurchaseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPurchases,  double totalAmount,  double totalQuantityPurchased,  double outstandingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupplierPurchaseSummary() when $default != null:
return $default(_that.totalPurchases,_that.totalAmount,_that.totalQuantityPurchased,_that.outstandingAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPurchases,  double totalAmount,  double totalQuantityPurchased,  double outstandingAmount)  $default,) {final _that = this;
switch (_that) {
case _SupplierPurchaseSummary():
return $default(_that.totalPurchases,_that.totalAmount,_that.totalQuantityPurchased,_that.outstandingAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPurchases,  double totalAmount,  double totalQuantityPurchased,  double outstandingAmount)?  $default,) {final _that = this;
switch (_that) {
case _SupplierPurchaseSummary() when $default != null:
return $default(_that.totalPurchases,_that.totalAmount,_that.totalQuantityPurchased,_that.outstandingAmount);case _:
  return null;

}
}

}

/// @nodoc


class _SupplierPurchaseSummary implements SupplierPurchaseSummary {
  const _SupplierPurchaseSummary({required this.totalPurchases, required this.totalAmount, required this.totalQuantityPurchased, required this.outstandingAmount});
  

@override final  int totalPurchases;
@override final  double totalAmount;
@override final  double totalQuantityPurchased;
@override final  double outstandingAmount;

/// Create a copy of SupplierPurchaseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplierPurchaseSummaryCopyWith<_SupplierPurchaseSummary> get copyWith => __$SupplierPurchaseSummaryCopyWithImpl<_SupplierPurchaseSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupplierPurchaseSummary&&(identical(other.totalPurchases, totalPurchases) || other.totalPurchases == totalPurchases)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalQuantityPurchased, totalQuantityPurchased) || other.totalQuantityPurchased == totalQuantityPurchased)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalPurchases,totalAmount,totalQuantityPurchased,outstandingAmount);

@override
String toString() {
  return 'SupplierPurchaseSummary(totalPurchases: $totalPurchases, totalAmount: $totalAmount, totalQuantityPurchased: $totalQuantityPurchased, outstandingAmount: $outstandingAmount)';
}


}

/// @nodoc
abstract mixin class _$SupplierPurchaseSummaryCopyWith<$Res> implements $SupplierPurchaseSummaryCopyWith<$Res> {
  factory _$SupplierPurchaseSummaryCopyWith(_SupplierPurchaseSummary value, $Res Function(_SupplierPurchaseSummary) _then) = __$SupplierPurchaseSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalPurchases, double totalAmount, double totalQuantityPurchased, double outstandingAmount
});




}
/// @nodoc
class __$SupplierPurchaseSummaryCopyWithImpl<$Res>
    implements _$SupplierPurchaseSummaryCopyWith<$Res> {
  __$SupplierPurchaseSummaryCopyWithImpl(this._self, this._then);

  final _SupplierPurchaseSummary _self;
  final $Res Function(_SupplierPurchaseSummary) _then;

/// Create a copy of SupplierPurchaseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPurchases = null,Object? totalAmount = null,Object? totalQuantityPurchased = null,Object? outstandingAmount = null,}) {
  return _then(_SupplierPurchaseSummary(
totalPurchases: null == totalPurchases ? _self.totalPurchases : totalPurchases // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalQuantityPurchased: null == totalQuantityPurchased ? _self.totalQuantityPurchased : totalQuantityPurchased // ignore: cast_nullable_to_non_nullable
as double,outstandingAmount: null == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
