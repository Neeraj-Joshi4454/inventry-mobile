// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profit_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfitSummary {

 double get salesRevenue; double get costOfGoodsSold; double get grossProfit; double get grossMarginPercent; double get operatingExpenses; double get netProfit;
/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitSummaryCopyWith<ProfitSummary> get copyWith => _$ProfitSummaryCopyWithImpl<ProfitSummary>(this as ProfitSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitSummary&&(identical(other.salesRevenue, salesRevenue) || other.salesRevenue == salesRevenue)&&(identical(other.costOfGoodsSold, costOfGoodsSold) || other.costOfGoodsSold == costOfGoodsSold)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.grossMarginPercent, grossMarginPercent) || other.grossMarginPercent == grossMarginPercent)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}


@override
int get hashCode => Object.hash(runtimeType,salesRevenue,costOfGoodsSold,grossProfit,grossMarginPercent,operatingExpenses,netProfit);

@override
String toString() {
  return 'ProfitSummary(salesRevenue: $salesRevenue, costOfGoodsSold: $costOfGoodsSold, grossProfit: $grossProfit, grossMarginPercent: $grossMarginPercent, operatingExpenses: $operatingExpenses, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class $ProfitSummaryCopyWith<$Res>  {
  factory $ProfitSummaryCopyWith(ProfitSummary value, $Res Function(ProfitSummary) _then) = _$ProfitSummaryCopyWithImpl;
@useResult
$Res call({
 double salesRevenue, double costOfGoodsSold, double grossProfit, double grossMarginPercent, double operatingExpenses, double netProfit
});




}
/// @nodoc
class _$ProfitSummaryCopyWithImpl<$Res>
    implements $ProfitSummaryCopyWith<$Res> {
  _$ProfitSummaryCopyWithImpl(this._self, this._then);

  final ProfitSummary _self;
  final $Res Function(ProfitSummary) _then;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salesRevenue = null,Object? costOfGoodsSold = null,Object? grossProfit = null,Object? grossMarginPercent = null,Object? operatingExpenses = null,Object? netProfit = null,}) {
  return _then(_self.copyWith(
salesRevenue: null == salesRevenue ? _self.salesRevenue : salesRevenue // ignore: cast_nullable_to_non_nullable
as double,costOfGoodsSold: null == costOfGoodsSold ? _self.costOfGoodsSold : costOfGoodsSold // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,grossMarginPercent: null == grossMarginPercent ? _self.grossMarginPercent : grossMarginPercent // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitSummary].
extension ProfitSummaryPatterns on ProfitSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProfitSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double salesRevenue,  double costOfGoodsSold,  double grossProfit,  double grossMarginPercent,  double operatingExpenses,  double netProfit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
return $default(_that.salesRevenue,_that.costOfGoodsSold,_that.grossProfit,_that.grossMarginPercent,_that.operatingExpenses,_that.netProfit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double salesRevenue,  double costOfGoodsSold,  double grossProfit,  double grossMarginPercent,  double operatingExpenses,  double netProfit)  $default,) {final _that = this;
switch (_that) {
case _ProfitSummary():
return $default(_that.salesRevenue,_that.costOfGoodsSold,_that.grossProfit,_that.grossMarginPercent,_that.operatingExpenses,_that.netProfit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double salesRevenue,  double costOfGoodsSold,  double grossProfit,  double grossMarginPercent,  double operatingExpenses,  double netProfit)?  $default,) {final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
return $default(_that.salesRevenue,_that.costOfGoodsSold,_that.grossProfit,_that.grossMarginPercent,_that.operatingExpenses,_that.netProfit);case _:
  return null;

}
}

}

/// @nodoc


class _ProfitSummary implements ProfitSummary {
  const _ProfitSummary({required this.salesRevenue, required this.costOfGoodsSold, required this.grossProfit, required this.grossMarginPercent, required this.operatingExpenses, required this.netProfit});
  

@override final  double salesRevenue;
@override final  double costOfGoodsSold;
@override final  double grossProfit;
@override final  double grossMarginPercent;
@override final  double operatingExpenses;
@override final  double netProfit;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitSummaryCopyWith<_ProfitSummary> get copyWith => __$ProfitSummaryCopyWithImpl<_ProfitSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitSummary&&(identical(other.salesRevenue, salesRevenue) || other.salesRevenue == salesRevenue)&&(identical(other.costOfGoodsSold, costOfGoodsSold) || other.costOfGoodsSold == costOfGoodsSold)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.grossMarginPercent, grossMarginPercent) || other.grossMarginPercent == grossMarginPercent)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}


@override
int get hashCode => Object.hash(runtimeType,salesRevenue,costOfGoodsSold,grossProfit,grossMarginPercent,operatingExpenses,netProfit);

@override
String toString() {
  return 'ProfitSummary(salesRevenue: $salesRevenue, costOfGoodsSold: $costOfGoodsSold, grossProfit: $grossProfit, grossMarginPercent: $grossMarginPercent, operatingExpenses: $operatingExpenses, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class _$ProfitSummaryCopyWith<$Res> implements $ProfitSummaryCopyWith<$Res> {
  factory _$ProfitSummaryCopyWith(_ProfitSummary value, $Res Function(_ProfitSummary) _then) = __$ProfitSummaryCopyWithImpl;
@override @useResult
$Res call({
 double salesRevenue, double costOfGoodsSold, double grossProfit, double grossMarginPercent, double operatingExpenses, double netProfit
});




}
/// @nodoc
class __$ProfitSummaryCopyWithImpl<$Res>
    implements _$ProfitSummaryCopyWith<$Res> {
  __$ProfitSummaryCopyWithImpl(this._self, this._then);

  final _ProfitSummary _self;
  final $Res Function(_ProfitSummary) _then;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salesRevenue = null,Object? costOfGoodsSold = null,Object? grossProfit = null,Object? grossMarginPercent = null,Object? operatingExpenses = null,Object? netProfit = null,}) {
  return _then(_ProfitSummary(
salesRevenue: null == salesRevenue ? _self.salesRevenue : salesRevenue // ignore: cast_nullable_to_non_nullable
as double,costOfGoodsSold: null == costOfGoodsSold ? _self.costOfGoodsSold : costOfGoodsSold // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,grossMarginPercent: null == grossMarginPercent ? _self.grossMarginPercent : grossMarginPercent // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
