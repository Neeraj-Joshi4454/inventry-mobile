// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseReportSummary {

 int get totalPurchases; double get totalQuantityPurchased; double get totalDiscount; double get totalTax; double get netPurchaseAmount;
/// Create a copy of PurchaseReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseReportSummaryCopyWith<PurchaseReportSummary> get copyWith => _$PurchaseReportSummaryCopyWithImpl<PurchaseReportSummary>(this as PurchaseReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseReportSummary&&(identical(other.totalPurchases, totalPurchases) || other.totalPurchases == totalPurchases)&&(identical(other.totalQuantityPurchased, totalQuantityPurchased) || other.totalQuantityPurchased == totalQuantityPurchased)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.netPurchaseAmount, netPurchaseAmount) || other.netPurchaseAmount == netPurchaseAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalPurchases,totalQuantityPurchased,totalDiscount,totalTax,netPurchaseAmount);

@override
String toString() {
  return 'PurchaseReportSummary(totalPurchases: $totalPurchases, totalQuantityPurchased: $totalQuantityPurchased, totalDiscount: $totalDiscount, totalTax: $totalTax, netPurchaseAmount: $netPurchaseAmount)';
}


}

/// @nodoc
abstract mixin class $PurchaseReportSummaryCopyWith<$Res>  {
  factory $PurchaseReportSummaryCopyWith(PurchaseReportSummary value, $Res Function(PurchaseReportSummary) _then) = _$PurchaseReportSummaryCopyWithImpl;
@useResult
$Res call({
 int totalPurchases, double totalQuantityPurchased, double totalDiscount, double totalTax, double netPurchaseAmount
});




}
/// @nodoc
class _$PurchaseReportSummaryCopyWithImpl<$Res>
    implements $PurchaseReportSummaryCopyWith<$Res> {
  _$PurchaseReportSummaryCopyWithImpl(this._self, this._then);

  final PurchaseReportSummary _self;
  final $Res Function(PurchaseReportSummary) _then;

/// Create a copy of PurchaseReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPurchases = null,Object? totalQuantityPurchased = null,Object? totalDiscount = null,Object? totalTax = null,Object? netPurchaseAmount = null,}) {
  return _then(_self.copyWith(
totalPurchases: null == totalPurchases ? _self.totalPurchases : totalPurchases // ignore: cast_nullable_to_non_nullable
as int,totalQuantityPurchased: null == totalQuantityPurchased ? _self.totalQuantityPurchased : totalQuantityPurchased // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,netPurchaseAmount: null == netPurchaseAmount ? _self.netPurchaseAmount : netPurchaseAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseReportSummary].
extension PurchaseReportSummaryPatterns on PurchaseReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPurchases,  double totalQuantityPurchased,  double totalDiscount,  double totalTax,  double netPurchaseAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseReportSummary() when $default != null:
return $default(_that.totalPurchases,_that.totalQuantityPurchased,_that.totalDiscount,_that.totalTax,_that.netPurchaseAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPurchases,  double totalQuantityPurchased,  double totalDiscount,  double totalTax,  double netPurchaseAmount)  $default,) {final _that = this;
switch (_that) {
case _PurchaseReportSummary():
return $default(_that.totalPurchases,_that.totalQuantityPurchased,_that.totalDiscount,_that.totalTax,_that.netPurchaseAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPurchases,  double totalQuantityPurchased,  double totalDiscount,  double totalTax,  double netPurchaseAmount)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseReportSummary() when $default != null:
return $default(_that.totalPurchases,_that.totalQuantityPurchased,_that.totalDiscount,_that.totalTax,_that.netPurchaseAmount);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseReportSummary implements PurchaseReportSummary {
  const _PurchaseReportSummary({required this.totalPurchases, required this.totalQuantityPurchased, required this.totalDiscount, required this.totalTax, required this.netPurchaseAmount});
  

@override final  int totalPurchases;
@override final  double totalQuantityPurchased;
@override final  double totalDiscount;
@override final  double totalTax;
@override final  double netPurchaseAmount;

/// Create a copy of PurchaseReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseReportSummaryCopyWith<_PurchaseReportSummary> get copyWith => __$PurchaseReportSummaryCopyWithImpl<_PurchaseReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseReportSummary&&(identical(other.totalPurchases, totalPurchases) || other.totalPurchases == totalPurchases)&&(identical(other.totalQuantityPurchased, totalQuantityPurchased) || other.totalQuantityPurchased == totalQuantityPurchased)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.netPurchaseAmount, netPurchaseAmount) || other.netPurchaseAmount == netPurchaseAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalPurchases,totalQuantityPurchased,totalDiscount,totalTax,netPurchaseAmount);

@override
String toString() {
  return 'PurchaseReportSummary(totalPurchases: $totalPurchases, totalQuantityPurchased: $totalQuantityPurchased, totalDiscount: $totalDiscount, totalTax: $totalTax, netPurchaseAmount: $netPurchaseAmount)';
}


}

/// @nodoc
abstract mixin class _$PurchaseReportSummaryCopyWith<$Res> implements $PurchaseReportSummaryCopyWith<$Res> {
  factory _$PurchaseReportSummaryCopyWith(_PurchaseReportSummary value, $Res Function(_PurchaseReportSummary) _then) = __$PurchaseReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalPurchases, double totalQuantityPurchased, double totalDiscount, double totalTax, double netPurchaseAmount
});




}
/// @nodoc
class __$PurchaseReportSummaryCopyWithImpl<$Res>
    implements _$PurchaseReportSummaryCopyWith<$Res> {
  __$PurchaseReportSummaryCopyWithImpl(this._self, this._then);

  final _PurchaseReportSummary _self;
  final $Res Function(_PurchaseReportSummary) _then;

/// Create a copy of PurchaseReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPurchases = null,Object? totalQuantityPurchased = null,Object? totalDiscount = null,Object? totalTax = null,Object? netPurchaseAmount = null,}) {
  return _then(_PurchaseReportSummary(
totalPurchases: null == totalPurchases ? _self.totalPurchases : totalPurchases // ignore: cast_nullable_to_non_nullable
as int,totalQuantityPurchased: null == totalQuantityPurchased ? _self.totalQuantityPurchased : totalQuantityPurchased // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,netPurchaseAmount: null == netPurchaseAmount ? _self.netPurchaseAmount : netPurchaseAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PurchaseReportRow {

 String get id; String get purchaseNumber; DateTime get purchaseDate; double get totalAmount; String get paymentStatus; String get supplierName; String? get createdByName;
/// Create a copy of PurchaseReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseReportRowCopyWith<PurchaseReportRow> get copyWith => _$PurchaseReportRowCopyWithImpl<PurchaseReportRow>(this as PurchaseReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseNumber, purchaseNumber) || other.purchaseNumber == purchaseNumber)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseNumber,purchaseDate,totalAmount,paymentStatus,supplierName,createdByName);

@override
String toString() {
  return 'PurchaseReportRow(id: $id, purchaseNumber: $purchaseNumber, purchaseDate: $purchaseDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, supplierName: $supplierName, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class $PurchaseReportRowCopyWith<$Res>  {
  factory $PurchaseReportRowCopyWith(PurchaseReportRow value, $Res Function(PurchaseReportRow) _then) = _$PurchaseReportRowCopyWithImpl;
@useResult
$Res call({
 String id, String purchaseNumber, DateTime purchaseDate, double totalAmount, String paymentStatus, String supplierName, String? createdByName
});




}
/// @nodoc
class _$PurchaseReportRowCopyWithImpl<$Res>
    implements $PurchaseReportRowCopyWith<$Res> {
  _$PurchaseReportRowCopyWithImpl(this._self, this._then);

  final PurchaseReportRow _self;
  final $Res Function(PurchaseReportRow) _then;

/// Create a copy of PurchaseReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? purchaseNumber = null,Object? purchaseDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? supplierName = null,Object? createdByName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseNumber: null == purchaseNumber ? _self.purchaseNumber : purchaseNumber // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,supplierName: null == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseReportRow].
extension PurchaseReportRowPatterns on PurchaseReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseReportRow value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String purchaseNumber,  DateTime purchaseDate,  double totalAmount,  String paymentStatus,  String supplierName,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseReportRow() when $default != null:
return $default(_that.id,_that.purchaseNumber,_that.purchaseDate,_that.totalAmount,_that.paymentStatus,_that.supplierName,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String purchaseNumber,  DateTime purchaseDate,  double totalAmount,  String paymentStatus,  String supplierName,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _PurchaseReportRow():
return $default(_that.id,_that.purchaseNumber,_that.purchaseDate,_that.totalAmount,_that.paymentStatus,_that.supplierName,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String purchaseNumber,  DateTime purchaseDate,  double totalAmount,  String paymentStatus,  String supplierName,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseReportRow() when $default != null:
return $default(_that.id,_that.purchaseNumber,_that.purchaseDate,_that.totalAmount,_that.paymentStatus,_that.supplierName,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseReportRow implements PurchaseReportRow {
  const _PurchaseReportRow({required this.id, required this.purchaseNumber, required this.purchaseDate, required this.totalAmount, required this.paymentStatus, required this.supplierName, this.createdByName});
  

@override final  String id;
@override final  String purchaseNumber;
@override final  DateTime purchaseDate;
@override final  double totalAmount;
@override final  String paymentStatus;
@override final  String supplierName;
@override final  String? createdByName;

/// Create a copy of PurchaseReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseReportRowCopyWith<_PurchaseReportRow> get copyWith => __$PurchaseReportRowCopyWithImpl<_PurchaseReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseNumber, purchaseNumber) || other.purchaseNumber == purchaseNumber)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseNumber,purchaseDate,totalAmount,paymentStatus,supplierName,createdByName);

@override
String toString() {
  return 'PurchaseReportRow(id: $id, purchaseNumber: $purchaseNumber, purchaseDate: $purchaseDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, supplierName: $supplierName, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$PurchaseReportRowCopyWith<$Res> implements $PurchaseReportRowCopyWith<$Res> {
  factory _$PurchaseReportRowCopyWith(_PurchaseReportRow value, $Res Function(_PurchaseReportRow) _then) = __$PurchaseReportRowCopyWithImpl;
@override @useResult
$Res call({
 String id, String purchaseNumber, DateTime purchaseDate, double totalAmount, String paymentStatus, String supplierName, String? createdByName
});




}
/// @nodoc
class __$PurchaseReportRowCopyWithImpl<$Res>
    implements _$PurchaseReportRowCopyWith<$Res> {
  __$PurchaseReportRowCopyWithImpl(this._self, this._then);

  final _PurchaseReportRow _self;
  final $Res Function(_PurchaseReportRow) _then;

/// Create a copy of PurchaseReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? purchaseNumber = null,Object? purchaseDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? supplierName = null,Object? createdByName = freezed,}) {
  return _then(_PurchaseReportRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseNumber: null == purchaseNumber ? _self.purchaseNumber : purchaseNumber // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,supplierName: null == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
