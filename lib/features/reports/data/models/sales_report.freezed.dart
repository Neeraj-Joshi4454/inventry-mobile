// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesReportSummary {

 int get totalSales; double get totalQuantitySold; double get totalDiscount; double get totalTax; double get netSales;
/// Create a copy of SalesReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesReportSummaryCopyWith<SalesReportSummary> get copyWith => _$SalesReportSummaryCopyWithImpl<SalesReportSummary>(this as SalesReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesReportSummary&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalQuantitySold, totalQuantitySold) || other.totalQuantitySold == totalQuantitySold)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.netSales, netSales) || other.netSales == netSales));
}


@override
int get hashCode => Object.hash(runtimeType,totalSales,totalQuantitySold,totalDiscount,totalTax,netSales);

@override
String toString() {
  return 'SalesReportSummary(totalSales: $totalSales, totalQuantitySold: $totalQuantitySold, totalDiscount: $totalDiscount, totalTax: $totalTax, netSales: $netSales)';
}


}

/// @nodoc
abstract mixin class $SalesReportSummaryCopyWith<$Res>  {
  factory $SalesReportSummaryCopyWith(SalesReportSummary value, $Res Function(SalesReportSummary) _then) = _$SalesReportSummaryCopyWithImpl;
@useResult
$Res call({
 int totalSales, double totalQuantitySold, double totalDiscount, double totalTax, double netSales
});




}
/// @nodoc
class _$SalesReportSummaryCopyWithImpl<$Res>
    implements $SalesReportSummaryCopyWith<$Res> {
  _$SalesReportSummaryCopyWithImpl(this._self, this._then);

  final SalesReportSummary _self;
  final $Res Function(SalesReportSummary) _then;

/// Create a copy of SalesReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSales = null,Object? totalQuantitySold = null,Object? totalDiscount = null,Object? totalTax = null,Object? netSales = null,}) {
  return _then(_self.copyWith(
totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as int,totalQuantitySold: null == totalQuantitySold ? _self.totalQuantitySold : totalQuantitySold // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,netSales: null == netSales ? _self.netSales : netSales // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesReportSummary].
extension SalesReportSummaryPatterns on SalesReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _SalesReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SalesReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSales,  double totalQuantitySold,  double totalDiscount,  double totalTax,  double netSales)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesReportSummary() when $default != null:
return $default(_that.totalSales,_that.totalQuantitySold,_that.totalDiscount,_that.totalTax,_that.netSales);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSales,  double totalQuantitySold,  double totalDiscount,  double totalTax,  double netSales)  $default,) {final _that = this;
switch (_that) {
case _SalesReportSummary():
return $default(_that.totalSales,_that.totalQuantitySold,_that.totalDiscount,_that.totalTax,_that.netSales);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSales,  double totalQuantitySold,  double totalDiscount,  double totalTax,  double netSales)?  $default,) {final _that = this;
switch (_that) {
case _SalesReportSummary() when $default != null:
return $default(_that.totalSales,_that.totalQuantitySold,_that.totalDiscount,_that.totalTax,_that.netSales);case _:
  return null;

}
}

}

/// @nodoc


class _SalesReportSummary implements SalesReportSummary {
  const _SalesReportSummary({required this.totalSales, required this.totalQuantitySold, required this.totalDiscount, required this.totalTax, required this.netSales});
  

@override final  int totalSales;
@override final  double totalQuantitySold;
@override final  double totalDiscount;
@override final  double totalTax;
@override final  double netSales;

/// Create a copy of SalesReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesReportSummaryCopyWith<_SalesReportSummary> get copyWith => __$SalesReportSummaryCopyWithImpl<_SalesReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesReportSummary&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalQuantitySold, totalQuantitySold) || other.totalQuantitySold == totalQuantitySold)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.netSales, netSales) || other.netSales == netSales));
}


@override
int get hashCode => Object.hash(runtimeType,totalSales,totalQuantitySold,totalDiscount,totalTax,netSales);

@override
String toString() {
  return 'SalesReportSummary(totalSales: $totalSales, totalQuantitySold: $totalQuantitySold, totalDiscount: $totalDiscount, totalTax: $totalTax, netSales: $netSales)';
}


}

/// @nodoc
abstract mixin class _$SalesReportSummaryCopyWith<$Res> implements $SalesReportSummaryCopyWith<$Res> {
  factory _$SalesReportSummaryCopyWith(_SalesReportSummary value, $Res Function(_SalesReportSummary) _then) = __$SalesReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalSales, double totalQuantitySold, double totalDiscount, double totalTax, double netSales
});




}
/// @nodoc
class __$SalesReportSummaryCopyWithImpl<$Res>
    implements _$SalesReportSummaryCopyWith<$Res> {
  __$SalesReportSummaryCopyWithImpl(this._self, this._then);

  final _SalesReportSummary _self;
  final $Res Function(_SalesReportSummary) _then;

/// Create a copy of SalesReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSales = null,Object? totalQuantitySold = null,Object? totalDiscount = null,Object? totalTax = null,Object? netSales = null,}) {
  return _then(_SalesReportSummary(
totalSales: null == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as int,totalQuantitySold: null == totalQuantitySold ? _self.totalQuantitySold : totalQuantitySold // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,netSales: null == netSales ? _self.netSales : netSales // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SalesReportRow {

 String get id; String get saleNumber; DateTime get saleDate; double get totalAmount; String get paymentStatus; String get customerName; String? get createdByName;
/// Create a copy of SalesReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesReportRowCopyWith<SalesReportRow> get copyWith => _$SalesReportRowCopyWithImpl<SalesReportRow>(this as SalesReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.saleNumber, saleNumber) || other.saleNumber == saleNumber)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,saleNumber,saleDate,totalAmount,paymentStatus,customerName,createdByName);

@override
String toString() {
  return 'SalesReportRow(id: $id, saleNumber: $saleNumber, saleDate: $saleDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, customerName: $customerName, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class $SalesReportRowCopyWith<$Res>  {
  factory $SalesReportRowCopyWith(SalesReportRow value, $Res Function(SalesReportRow) _then) = _$SalesReportRowCopyWithImpl;
@useResult
$Res call({
 String id, String saleNumber, DateTime saleDate, double totalAmount, String paymentStatus, String customerName, String? createdByName
});




}
/// @nodoc
class _$SalesReportRowCopyWithImpl<$Res>
    implements $SalesReportRowCopyWith<$Res> {
  _$SalesReportRowCopyWithImpl(this._self, this._then);

  final SalesReportRow _self;
  final $Res Function(SalesReportRow) _then;

/// Create a copy of SalesReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? saleNumber = null,Object? saleDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? customerName = null,Object? createdByName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,saleNumber: null == saleNumber ? _self.saleNumber : saleNumber // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesReportRow].
extension SalesReportRowPatterns on SalesReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesReportRow value)  $default,){
final _that = this;
switch (_that) {
case _SalesReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _SalesReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String saleNumber,  DateTime saleDate,  double totalAmount,  String paymentStatus,  String customerName,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesReportRow() when $default != null:
return $default(_that.id,_that.saleNumber,_that.saleDate,_that.totalAmount,_that.paymentStatus,_that.customerName,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String saleNumber,  DateTime saleDate,  double totalAmount,  String paymentStatus,  String customerName,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _SalesReportRow():
return $default(_that.id,_that.saleNumber,_that.saleDate,_that.totalAmount,_that.paymentStatus,_that.customerName,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String saleNumber,  DateTime saleDate,  double totalAmount,  String paymentStatus,  String customerName,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _SalesReportRow() when $default != null:
return $default(_that.id,_that.saleNumber,_that.saleDate,_that.totalAmount,_that.paymentStatus,_that.customerName,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc


class _SalesReportRow implements SalesReportRow {
  const _SalesReportRow({required this.id, required this.saleNumber, required this.saleDate, required this.totalAmount, required this.paymentStatus, required this.customerName, this.createdByName});
  

@override final  String id;
@override final  String saleNumber;
@override final  DateTime saleDate;
@override final  double totalAmount;
@override final  String paymentStatus;
@override final  String customerName;
@override final  String? createdByName;

/// Create a copy of SalesReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesReportRowCopyWith<_SalesReportRow> get copyWith => __$SalesReportRowCopyWithImpl<_SalesReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.saleNumber, saleNumber) || other.saleNumber == saleNumber)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,saleNumber,saleDate,totalAmount,paymentStatus,customerName,createdByName);

@override
String toString() {
  return 'SalesReportRow(id: $id, saleNumber: $saleNumber, saleDate: $saleDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, customerName: $customerName, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$SalesReportRowCopyWith<$Res> implements $SalesReportRowCopyWith<$Res> {
  factory _$SalesReportRowCopyWith(_SalesReportRow value, $Res Function(_SalesReportRow) _then) = __$SalesReportRowCopyWithImpl;
@override @useResult
$Res call({
 String id, String saleNumber, DateTime saleDate, double totalAmount, String paymentStatus, String customerName, String? createdByName
});




}
/// @nodoc
class __$SalesReportRowCopyWithImpl<$Res>
    implements _$SalesReportRowCopyWith<$Res> {
  __$SalesReportRowCopyWithImpl(this._self, this._then);

  final _SalesReportRow _self;
  final $Res Function(_SalesReportRow) _then;

/// Create a copy of SalesReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? saleNumber = null,Object? saleDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? customerName = null,Object? createdByName = freezed,}) {
  return _then(_SalesReportRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,saleNumber: null == saleNumber ? _self.saleNumber : saleNumber // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
