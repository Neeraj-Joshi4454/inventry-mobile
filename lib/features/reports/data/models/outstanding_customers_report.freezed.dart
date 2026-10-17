// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outstanding_customers_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OutstandingCustomersSummary {

 int get totalOutstandingCustomers; double get totalOutstandingAmount;
/// Create a copy of OutstandingCustomersSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutstandingCustomersSummaryCopyWith<OutstandingCustomersSummary> get copyWith => _$OutstandingCustomersSummaryCopyWithImpl<OutstandingCustomersSummary>(this as OutstandingCustomersSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutstandingCustomersSummary&&(identical(other.totalOutstandingCustomers, totalOutstandingCustomers) || other.totalOutstandingCustomers == totalOutstandingCustomers)&&(identical(other.totalOutstandingAmount, totalOutstandingAmount) || other.totalOutstandingAmount == totalOutstandingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalOutstandingCustomers,totalOutstandingAmount);

@override
String toString() {
  return 'OutstandingCustomersSummary(totalOutstandingCustomers: $totalOutstandingCustomers, totalOutstandingAmount: $totalOutstandingAmount)';
}


}

/// @nodoc
abstract mixin class $OutstandingCustomersSummaryCopyWith<$Res>  {
  factory $OutstandingCustomersSummaryCopyWith(OutstandingCustomersSummary value, $Res Function(OutstandingCustomersSummary) _then) = _$OutstandingCustomersSummaryCopyWithImpl;
@useResult
$Res call({
 int totalOutstandingCustomers, double totalOutstandingAmount
});




}
/// @nodoc
class _$OutstandingCustomersSummaryCopyWithImpl<$Res>
    implements $OutstandingCustomersSummaryCopyWith<$Res> {
  _$OutstandingCustomersSummaryCopyWithImpl(this._self, this._then);

  final OutstandingCustomersSummary _self;
  final $Res Function(OutstandingCustomersSummary) _then;

/// Create a copy of OutstandingCustomersSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalOutstandingCustomers = null,Object? totalOutstandingAmount = null,}) {
  return _then(_self.copyWith(
totalOutstandingCustomers: null == totalOutstandingCustomers ? _self.totalOutstandingCustomers : totalOutstandingCustomers // ignore: cast_nullable_to_non_nullable
as int,totalOutstandingAmount: null == totalOutstandingAmount ? _self.totalOutstandingAmount : totalOutstandingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OutstandingCustomersSummary].
extension OutstandingCustomersSummaryPatterns on OutstandingCustomersSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutstandingCustomersSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutstandingCustomersSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutstandingCustomersSummary value)  $default,){
final _that = this;
switch (_that) {
case _OutstandingCustomersSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutstandingCustomersSummary value)?  $default,){
final _that = this;
switch (_that) {
case _OutstandingCustomersSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalOutstandingCustomers,  double totalOutstandingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutstandingCustomersSummary() when $default != null:
return $default(_that.totalOutstandingCustomers,_that.totalOutstandingAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalOutstandingCustomers,  double totalOutstandingAmount)  $default,) {final _that = this;
switch (_that) {
case _OutstandingCustomersSummary():
return $default(_that.totalOutstandingCustomers,_that.totalOutstandingAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalOutstandingCustomers,  double totalOutstandingAmount)?  $default,) {final _that = this;
switch (_that) {
case _OutstandingCustomersSummary() when $default != null:
return $default(_that.totalOutstandingCustomers,_that.totalOutstandingAmount);case _:
  return null;

}
}

}

/// @nodoc


class _OutstandingCustomersSummary implements OutstandingCustomersSummary {
  const _OutstandingCustomersSummary({required this.totalOutstandingCustomers, required this.totalOutstandingAmount});
  

@override final  int totalOutstandingCustomers;
@override final  double totalOutstandingAmount;

/// Create a copy of OutstandingCustomersSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutstandingCustomersSummaryCopyWith<_OutstandingCustomersSummary> get copyWith => __$OutstandingCustomersSummaryCopyWithImpl<_OutstandingCustomersSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutstandingCustomersSummary&&(identical(other.totalOutstandingCustomers, totalOutstandingCustomers) || other.totalOutstandingCustomers == totalOutstandingCustomers)&&(identical(other.totalOutstandingAmount, totalOutstandingAmount) || other.totalOutstandingAmount == totalOutstandingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalOutstandingCustomers,totalOutstandingAmount);

@override
String toString() {
  return 'OutstandingCustomersSummary(totalOutstandingCustomers: $totalOutstandingCustomers, totalOutstandingAmount: $totalOutstandingAmount)';
}


}

/// @nodoc
abstract mixin class _$OutstandingCustomersSummaryCopyWith<$Res> implements $OutstandingCustomersSummaryCopyWith<$Res> {
  factory _$OutstandingCustomersSummaryCopyWith(_OutstandingCustomersSummary value, $Res Function(_OutstandingCustomersSummary) _then) = __$OutstandingCustomersSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalOutstandingCustomers, double totalOutstandingAmount
});




}
/// @nodoc
class __$OutstandingCustomersSummaryCopyWithImpl<$Res>
    implements _$OutstandingCustomersSummaryCopyWith<$Res> {
  __$OutstandingCustomersSummaryCopyWithImpl(this._self, this._then);

  final _OutstandingCustomersSummary _self;
  final $Res Function(_OutstandingCustomersSummary) _then;

/// Create a copy of OutstandingCustomersSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalOutstandingCustomers = null,Object? totalOutstandingAmount = null,}) {
  return _then(_OutstandingCustomersSummary(
totalOutstandingCustomers: null == totalOutstandingCustomers ? _self.totalOutstandingCustomers : totalOutstandingCustomers // ignore: cast_nullable_to_non_nullable
as int,totalOutstandingAmount: null == totalOutstandingAmount ? _self.totalOutstandingAmount : totalOutstandingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$OutstandingCustomerRow {

 String get customerId; String get customerName; String? get mobileNumber; double get totalSales; double get paidAmount; double get outstandingAmount; DateTime? get lastTransactionDate;
/// Create a copy of OutstandingCustomerRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutstandingCustomerRowCopyWith<OutstandingCustomerRow> get copyWith => _$OutstandingCustomerRowCopyWithImpl<OutstandingCustomerRow>(this as OutstandingCustomerRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutstandingCustomerRow&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.lastTransactionDate, lastTransactionDate) || other.lastTransactionDate == lastTransactionDate));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,customerName,mobileNumber,totalSales,paidAmount,outstandingAmount,lastTransactionDate);

@override
String toString() {
  return 'OutstandingCustomerRow(customerId: $customerId, customerName: $customerName, mobileNumber: $mobileNumber, totalSales: $totalSales, paidAmount: $paidAmount, outstandingAmount: $outstandingAmount, lastTransactionDate: $lastTransactionDate)';
}


}

/// @nodoc
abstract mixin class $OutstandingCustomerRowCopyWith<$Res>  {
  factory $OutstandingCustomerRowCopyWith(OutstandingCustomerRow value, $Res Function(OutstandingCustomerRow) _then) = _$OutstandingCustomerRowCopyWithImpl;
@useResult
$Res call({
 String customerId, String customerName, String? mobileNumber, double totalSales, double paidAmount, double outstandingAmount, DateTime? lastTransactionDate
});




}
/// @nodoc
class _$OutstandingCustomerRowCopyWithImpl<$Res>
    implements $OutstandingCustomerRowCopyWith<$Res> {
  _$OutstandingCustomerRowCopyWithImpl(this._self, this._then);

  final OutstandingCustomerRow _self;
  final $Res Function(OutstandingCustomerRow) _then;

/// Create a copy of OutstandingCustomerRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = null,Object? customerName = null,Object? mobileNumber = freezed,Object? totalSales = null,Object? paidAmount = null,Object? outstandingAmount = null,Object? lastTransactionDate = freezed,}) {
  return _then(_self.copyWith(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,outstandingAmount: null == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double,lastTransactionDate: freezed == lastTransactionDate ? _self.lastTransactionDate : lastTransactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutstandingCustomerRow].
extension OutstandingCustomerRowPatterns on OutstandingCustomerRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutstandingCustomerRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutstandingCustomerRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutstandingCustomerRow value)  $default,){
final _that = this;
switch (_that) {
case _OutstandingCustomerRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutstandingCustomerRow value)?  $default,){
final _that = this;
switch (_that) {
case _OutstandingCustomerRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String customerId,  String customerName,  String? mobileNumber,  double totalSales,  double paidAmount,  double outstandingAmount,  DateTime? lastTransactionDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutstandingCustomerRow() when $default != null:
return $default(_that.customerId,_that.customerName,_that.mobileNumber,_that.totalSales,_that.paidAmount,_that.outstandingAmount,_that.lastTransactionDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String customerId,  String customerName,  String? mobileNumber,  double totalSales,  double paidAmount,  double outstandingAmount,  DateTime? lastTransactionDate)  $default,) {final _that = this;
switch (_that) {
case _OutstandingCustomerRow():
return $default(_that.customerId,_that.customerName,_that.mobileNumber,_that.totalSales,_that.paidAmount,_that.outstandingAmount,_that.lastTransactionDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String customerId,  String customerName,  String? mobileNumber,  double totalSales,  double paidAmount,  double outstandingAmount,  DateTime? lastTransactionDate)?  $default,) {final _that = this;
switch (_that) {
case _OutstandingCustomerRow() when $default != null:
return $default(_that.customerId,_that.customerName,_that.mobileNumber,_that.totalSales,_that.paidAmount,_that.outstandingAmount,_that.lastTransactionDate);case _:
  return null;

}
}

}

/// @nodoc


class _OutstandingCustomerRow implements OutstandingCustomerRow {
  const _OutstandingCustomerRow({required this.customerId, required this.customerName, this.mobileNumber, required this.totalSales, required this.paidAmount, required this.outstandingAmount, this.lastTransactionDate});
  

@override final  String customerId;
@override final  String customerName;
@override final  String? mobileNumber;
@override final  double totalSales;
@override final  double paidAmount;
@override final  double outstandingAmount;
@override final  DateTime? lastTransactionDate;

/// Create a copy of OutstandingCustomerRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutstandingCustomerRowCopyWith<_OutstandingCustomerRow> get copyWith => __$OutstandingCustomerRowCopyWithImpl<_OutstandingCustomerRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutstandingCustomerRow&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.lastTransactionDate, lastTransactionDate) || other.lastTransactionDate == lastTransactionDate));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,customerName,mobileNumber,totalSales,paidAmount,outstandingAmount,lastTransactionDate);

@override
String toString() {
  return 'OutstandingCustomerRow(customerId: $customerId, customerName: $customerName, mobileNumber: $mobileNumber, totalSales: $totalSales, paidAmount: $paidAmount, outstandingAmount: $outstandingAmount, lastTransactionDate: $lastTransactionDate)';
}


}

/// @nodoc
abstract mixin class _$OutstandingCustomerRowCopyWith<$Res> implements $OutstandingCustomerRowCopyWith<$Res> {
  factory _$OutstandingCustomerRowCopyWith(_OutstandingCustomerRow value, $Res Function(_OutstandingCustomerRow) _then) = __$OutstandingCustomerRowCopyWithImpl;
@override @useResult
$Res call({
 String customerId, String customerName, String? mobileNumber, double totalSales, double paidAmount, double outstandingAmount, DateTime? lastTransactionDate
});




}
/// @nodoc
class __$OutstandingCustomerRowCopyWithImpl<$Res>
    implements _$OutstandingCustomerRowCopyWith<$Res> {
  __$OutstandingCustomerRowCopyWithImpl(this._self, this._then);

  final _OutstandingCustomerRow _self;
  final $Res Function(_OutstandingCustomerRow) _then;

/// Create a copy of OutstandingCustomerRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? customerName = null,Object? mobileNumber = freezed,Object? totalSales = null,Object? paidAmount = null,Object? outstandingAmount = null,Object? lastTransactionDate = freezed,}) {
  return _then(_OutstandingCustomerRow(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,outstandingAmount: null == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double,lastTransactionDate: freezed == lastTransactionDate ? _self.lastTransactionDate : lastTransactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
