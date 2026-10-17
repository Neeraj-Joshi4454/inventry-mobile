// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Sale {

 String get id; String get saleNumber; String? get customerId; String get customerName; DateTime get saleDate; double get subTotal; double get discountAmount; double get taxableAmount; double get cgstAmount; double get sgstAmount; double get igstAmount; double get taxAmount; String get taxType; double get totalAmount; double get paidAmount; double get dueAmount; String get paymentStatus; String? get paymentMethod; String? get createdByName; String? get notes; DateTime? get createdAt;
/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleCopyWith<Sale> get copyWith => _$SaleCopyWithImpl<Sale>(this as Sale, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sale&&(identical(other.id, id) || other.id == id)&&(identical(other.saleNumber, saleNumber) || other.saleNumber == saleNumber)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.dueAmount, dueAmount) || other.dueAmount == dueAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,saleNumber,customerId,customerName,saleDate,subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,taxAmount,taxType,totalAmount,paidAmount,dueAmount,paymentStatus,paymentMethod,createdByName,notes,createdAt]);

@override
String toString() {
  return 'Sale(id: $id, saleNumber: $saleNumber, customerId: $customerId, customerName: $customerName, saleDate: $saleDate, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, taxAmount: $taxAmount, taxType: $taxType, totalAmount: $totalAmount, paidAmount: $paidAmount, dueAmount: $dueAmount, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, createdByName: $createdByName, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SaleCopyWith<$Res>  {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) _then) = _$SaleCopyWithImpl;
@useResult
$Res call({
 String id, String saleNumber, String? customerId, String customerName, DateTime saleDate, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double taxAmount, String taxType, double totalAmount, double paidAmount, double dueAmount, String paymentStatus, String? paymentMethod, String? createdByName, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$SaleCopyWithImpl<$Res>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._self, this._then);

  final Sale _self;
  final $Res Function(Sale) _then;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? saleNumber = null,Object? customerId = freezed,Object? customerName = null,Object? saleDate = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? taxAmount = null,Object? taxType = null,Object? totalAmount = null,Object? paidAmount = null,Object? dueAmount = null,Object? paymentStatus = null,Object? paymentMethod = freezed,Object? createdByName = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,saleNumber: null == saleNumber ? _self.saleNumber : saleNumber // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,dueAmount: null == dueAmount ? _self.dueAmount : dueAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Sale].
extension SalePatterns on Sale {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sale value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sale() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sale value)  $default,){
final _that = this;
switch (_that) {
case _Sale():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sale value)?  $default,){
final _that = this;
switch (_that) {
case _Sale() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String saleNumber,  String? customerId,  String customerName,  DateTime saleDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  double paidAmount,  double dueAmount,  String paymentStatus,  String? paymentMethod,  String? createdByName,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sale() when $default != null:
return $default(_that.id,_that.saleNumber,_that.customerId,_that.customerName,_that.saleDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paidAmount,_that.dueAmount,_that.paymentStatus,_that.paymentMethod,_that.createdByName,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String saleNumber,  String? customerId,  String customerName,  DateTime saleDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  double paidAmount,  double dueAmount,  String paymentStatus,  String? paymentMethod,  String? createdByName,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Sale():
return $default(_that.id,_that.saleNumber,_that.customerId,_that.customerName,_that.saleDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paidAmount,_that.dueAmount,_that.paymentStatus,_that.paymentMethod,_that.createdByName,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String saleNumber,  String? customerId,  String customerName,  DateTime saleDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  double paidAmount,  double dueAmount,  String paymentStatus,  String? paymentMethod,  String? createdByName,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Sale() when $default != null:
return $default(_that.id,_that.saleNumber,_that.customerId,_that.customerName,_that.saleDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paidAmount,_that.dueAmount,_that.paymentStatus,_that.paymentMethod,_that.createdByName,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Sale implements Sale {
  const _Sale({required this.id, required this.saleNumber, this.customerId, required this.customerName, required this.saleDate, required this.subTotal, required this.discountAmount, this.taxableAmount = 0, this.cgstAmount = 0, this.sgstAmount = 0, this.igstAmount = 0, required this.taxAmount, this.taxType = 'NO_TAX', required this.totalAmount, required this.paidAmount, required this.dueAmount, required this.paymentStatus, this.paymentMethod, this.createdByName, this.notes, this.createdAt});
  

@override final  String id;
@override final  String saleNumber;
@override final  String? customerId;
@override final  String customerName;
@override final  DateTime saleDate;
@override final  double subTotal;
@override final  double discountAmount;
@override@JsonKey() final  double taxableAmount;
@override@JsonKey() final  double cgstAmount;
@override@JsonKey() final  double sgstAmount;
@override@JsonKey() final  double igstAmount;
@override final  double taxAmount;
@override@JsonKey() final  String taxType;
@override final  double totalAmount;
@override final  double paidAmount;
@override final  double dueAmount;
@override final  String paymentStatus;
@override final  String? paymentMethod;
@override final  String? createdByName;
@override final  String? notes;
@override final  DateTime? createdAt;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleCopyWith<_Sale> get copyWith => __$SaleCopyWithImpl<_Sale>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sale&&(identical(other.id, id) || other.id == id)&&(identical(other.saleNumber, saleNumber) || other.saleNumber == saleNumber)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.dueAmount, dueAmount) || other.dueAmount == dueAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,saleNumber,customerId,customerName,saleDate,subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,taxAmount,taxType,totalAmount,paidAmount,dueAmount,paymentStatus,paymentMethod,createdByName,notes,createdAt]);

@override
String toString() {
  return 'Sale(id: $id, saleNumber: $saleNumber, customerId: $customerId, customerName: $customerName, saleDate: $saleDate, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, taxAmount: $taxAmount, taxType: $taxType, totalAmount: $totalAmount, paidAmount: $paidAmount, dueAmount: $dueAmount, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, createdByName: $createdByName, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SaleCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$SaleCopyWith(_Sale value, $Res Function(_Sale) _then) = __$SaleCopyWithImpl;
@override @useResult
$Res call({
 String id, String saleNumber, String? customerId, String customerName, DateTime saleDate, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double taxAmount, String taxType, double totalAmount, double paidAmount, double dueAmount, String paymentStatus, String? paymentMethod, String? createdByName, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$SaleCopyWithImpl<$Res>
    implements _$SaleCopyWith<$Res> {
  __$SaleCopyWithImpl(this._self, this._then);

  final _Sale _self;
  final $Res Function(_Sale) _then;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? saleNumber = null,Object? customerId = freezed,Object? customerName = null,Object? saleDate = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? taxAmount = null,Object? taxType = null,Object? totalAmount = null,Object? paidAmount = null,Object? dueAmount = null,Object? paymentStatus = null,Object? paymentMethod = freezed,Object? createdByName = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_Sale(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,saleNumber: null == saleNumber ? _self.saleNumber : saleNumber // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,dueAmount: null == dueAmount ? _self.dueAmount : dueAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
