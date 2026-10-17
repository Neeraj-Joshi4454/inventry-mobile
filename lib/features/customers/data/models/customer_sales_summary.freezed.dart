// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_sales_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerSalesSummary {

 int get totalSales; double get totalAmount; double get totalPaid; double get totalOutstanding; DateTime? get lastSaleDate; DateTime? get lastPaymentDate; int get unpaidOrPartialCount;
/// Create a copy of CustomerSalesSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerSalesSummaryCopyWith<CustomerSalesSummary> get copyWith => _$CustomerSalesSummaryCopyWithImpl<CustomerSalesSummary>(this as CustomerSalesSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerSalesSummary&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalPaid, totalPaid) || other.totalPaid == totalPaid)&&(identical(other.totalOutstanding, totalOutstanding) || other.totalOutstanding == totalOutstanding)&&(identical(other.lastSaleDate, lastSaleDate) || other.lastSaleDate == lastSaleDate)&&(identical(other.lastPaymentDate, lastPaymentDate) || other.lastPaymentDate == lastPaymentDate)&&(identical(other.unpaidOrPartialCount, unpaidOrPartialCount) || other.unpaidOrPartialCount == unpaidOrPartialCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalSales,totalAmount,totalPaid,totalOutstanding,lastSaleDate,lastPaymentDate,unpaidOrPartialCount);

@override
String toString() {
  return 'CustomerSalesSummary(totalSales: $totalSales, totalAmount: $totalAmount, totalPaid: $totalPaid, totalOutstanding: $totalOutstanding, lastSaleDate: $lastSaleDate, lastPaymentDate: $lastPaymentDate, unpaidOrPartialCount: $unpaidOrPartialCount)';
}


}

/// @nodoc
abstract mixin class $CustomerSalesSummaryCopyWith<$Res>  {
  factory $CustomerSalesSummaryCopyWith(CustomerSalesSummary value, $Res Function(CustomerSalesSummary) _then) = _$CustomerSalesSummaryCopyWithImpl;
@useResult
$Res call({
 int totalSales, double totalAmount, double totalPaid, double totalOutstanding, DateTime? lastSaleDate, DateTime? lastPaymentDate, int unpaidOrPartialCount
});




}
/// @nodoc
class _$CustomerSalesSummaryCopyWithImpl<$Res>
    implements $CustomerSalesSummaryCopyWith<$Res> {
  _$CustomerSalesSummaryCopyWithImpl(this._self, this._then);

  final CustomerSalesSummary _self;
  final $Res Function(CustomerSalesSummary) _then;

/// Create a copy of CustomerSalesSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSales = null,Object? totalAmount = null,Object? totalPaid = null,Object? totalOutstanding = null,Object? lastSaleDate = freezed,Object? lastPaymentDate = freezed,Object? unpaidOrPartialCount = null,}) {
  return _then(_self.copyWith(
totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalPaid: null == totalPaid ? _self.totalPaid : totalPaid // ignore: cast_nullable_to_non_nullable
as double,totalOutstanding: null == totalOutstanding ? _self.totalOutstanding : totalOutstanding // ignore: cast_nullable_to_non_nullable
as double,lastSaleDate: freezed == lastSaleDate ? _self.lastSaleDate : lastSaleDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPaymentDate: freezed == lastPaymentDate ? _self.lastPaymentDate : lastPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,unpaidOrPartialCount: null == unpaidOrPartialCount ? _self.unpaidOrPartialCount : unpaidOrPartialCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerSalesSummary].
extension CustomerSalesSummaryPatterns on CustomerSalesSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerSalesSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerSalesSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerSalesSummary value)  $default,){
final _that = this;
switch (_that) {
case _CustomerSalesSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerSalesSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerSalesSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSales,  double totalAmount,  double totalPaid,  double totalOutstanding,  DateTime? lastSaleDate,  DateTime? lastPaymentDate,  int unpaidOrPartialCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerSalesSummary() when $default != null:
return $default(_that.totalSales,_that.totalAmount,_that.totalPaid,_that.totalOutstanding,_that.lastSaleDate,_that.lastPaymentDate,_that.unpaidOrPartialCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSales,  double totalAmount,  double totalPaid,  double totalOutstanding,  DateTime? lastSaleDate,  DateTime? lastPaymentDate,  int unpaidOrPartialCount)  $default,) {final _that = this;
switch (_that) {
case _CustomerSalesSummary():
return $default(_that.totalSales,_that.totalAmount,_that.totalPaid,_that.totalOutstanding,_that.lastSaleDate,_that.lastPaymentDate,_that.unpaidOrPartialCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSales,  double totalAmount,  double totalPaid,  double totalOutstanding,  DateTime? lastSaleDate,  DateTime? lastPaymentDate,  int unpaidOrPartialCount)?  $default,) {final _that = this;
switch (_that) {
case _CustomerSalesSummary() when $default != null:
return $default(_that.totalSales,_that.totalAmount,_that.totalPaid,_that.totalOutstanding,_that.lastSaleDate,_that.lastPaymentDate,_that.unpaidOrPartialCount);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerSalesSummary implements CustomerSalesSummary {
  const _CustomerSalesSummary({required this.totalSales, required this.totalAmount, required this.totalPaid, required this.totalOutstanding, this.lastSaleDate, this.lastPaymentDate, required this.unpaidOrPartialCount});
  

@override final  int totalSales;
@override final  double totalAmount;
@override final  double totalPaid;
@override final  double totalOutstanding;
@override final  DateTime? lastSaleDate;
@override final  DateTime? lastPaymentDate;
@override final  int unpaidOrPartialCount;

/// Create a copy of CustomerSalesSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerSalesSummaryCopyWith<_CustomerSalesSummary> get copyWith => __$CustomerSalesSummaryCopyWithImpl<_CustomerSalesSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerSalesSummary&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalPaid, totalPaid) || other.totalPaid == totalPaid)&&(identical(other.totalOutstanding, totalOutstanding) || other.totalOutstanding == totalOutstanding)&&(identical(other.lastSaleDate, lastSaleDate) || other.lastSaleDate == lastSaleDate)&&(identical(other.lastPaymentDate, lastPaymentDate) || other.lastPaymentDate == lastPaymentDate)&&(identical(other.unpaidOrPartialCount, unpaidOrPartialCount) || other.unpaidOrPartialCount == unpaidOrPartialCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalSales,totalAmount,totalPaid,totalOutstanding,lastSaleDate,lastPaymentDate,unpaidOrPartialCount);

@override
String toString() {
  return 'CustomerSalesSummary(totalSales: $totalSales, totalAmount: $totalAmount, totalPaid: $totalPaid, totalOutstanding: $totalOutstanding, lastSaleDate: $lastSaleDate, lastPaymentDate: $lastPaymentDate, unpaidOrPartialCount: $unpaidOrPartialCount)';
}


}

/// @nodoc
abstract mixin class _$CustomerSalesSummaryCopyWith<$Res> implements $CustomerSalesSummaryCopyWith<$Res> {
  factory _$CustomerSalesSummaryCopyWith(_CustomerSalesSummary value, $Res Function(_CustomerSalesSummary) _then) = __$CustomerSalesSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalSales, double totalAmount, double totalPaid, double totalOutstanding, DateTime? lastSaleDate, DateTime? lastPaymentDate, int unpaidOrPartialCount
});




}
/// @nodoc
class __$CustomerSalesSummaryCopyWithImpl<$Res>
    implements _$CustomerSalesSummaryCopyWith<$Res> {
  __$CustomerSalesSummaryCopyWithImpl(this._self, this._then);

  final _CustomerSalesSummary _self;
  final $Res Function(_CustomerSalesSummary) _then;

/// Create a copy of CustomerSalesSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSales = null,Object? totalAmount = null,Object? totalPaid = null,Object? totalOutstanding = null,Object? lastSaleDate = freezed,Object? lastPaymentDate = freezed,Object? unpaidOrPartialCount = null,}) {
  return _then(_CustomerSalesSummary(
totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalPaid: null == totalPaid ? _self.totalPaid : totalPaid // ignore: cast_nullable_to_non_nullable
as double,totalOutstanding: null == totalOutstanding ? _self.totalOutstanding : totalOutstanding // ignore: cast_nullable_to_non_nullable
as double,lastSaleDate: freezed == lastSaleDate ? _self.lastSaleDate : lastSaleDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPaymentDate: freezed == lastPaymentDate ? _self.lastPaymentDate : lastPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,unpaidOrPartialCount: null == unpaidOrPartialCount ? _self.unpaidOrPartialCount : unpaidOrPartialCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
