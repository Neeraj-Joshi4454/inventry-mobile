// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Purchase {

 String get id; String get purchaseNumber; String? get invoiceNumber; String get supplierName; DateTime get purchaseDate; double get subTotal; double get discountAmount; double get taxableAmount; double get cgstAmount; double get sgstAmount; double get igstAmount; double get taxAmount; String get taxType; double get totalAmount; String get paymentStatus; String? get notes; String? get createdByName;
/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseCopyWith<Purchase> get copyWith => _$PurchaseCopyWithImpl<Purchase>(this as Purchase, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Purchase&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseNumber, purchaseNumber) || other.purchaseNumber == purchaseNumber)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseNumber,invoiceNumber,supplierName,purchaseDate,subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,taxAmount,taxType,totalAmount,paymentStatus,notes,createdByName);

@override
String toString() {
  return 'Purchase(id: $id, purchaseNumber: $purchaseNumber, invoiceNumber: $invoiceNumber, supplierName: $supplierName, purchaseDate: $purchaseDate, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, taxAmount: $taxAmount, taxType: $taxType, totalAmount: $totalAmount, paymentStatus: $paymentStatus, notes: $notes, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class $PurchaseCopyWith<$Res>  {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) _then) = _$PurchaseCopyWithImpl;
@useResult
$Res call({
 String id, String purchaseNumber, String? invoiceNumber, String supplierName, DateTime purchaseDate, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double taxAmount, String taxType, double totalAmount, String paymentStatus, String? notes, String? createdByName
});




}
/// @nodoc
class _$PurchaseCopyWithImpl<$Res>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._self, this._then);

  final Purchase _self;
  final $Res Function(Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? purchaseNumber = null,Object? invoiceNumber = freezed,Object? supplierName = null,Object? purchaseDate = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? taxAmount = null,Object? taxType = null,Object? totalAmount = null,Object? paymentStatus = null,Object? notes = freezed,Object? createdByName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseNumber: null == purchaseNumber ? _self.purchaseNumber : purchaseNumber // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,supplierName: null == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Purchase].
extension PurchasePatterns on Purchase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Purchase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Purchase value)  $default,){
final _that = this;
switch (_that) {
case _Purchase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Purchase value)?  $default,){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String purchaseNumber,  String? invoiceNumber,  String supplierName,  DateTime purchaseDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  String paymentStatus,  String? notes,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.purchaseNumber,_that.invoiceNumber,_that.supplierName,_that.purchaseDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paymentStatus,_that.notes,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String purchaseNumber,  String? invoiceNumber,  String supplierName,  DateTime purchaseDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  String paymentStatus,  String? notes,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _Purchase():
return $default(_that.id,_that.purchaseNumber,_that.invoiceNumber,_that.supplierName,_that.purchaseDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paymentStatus,_that.notes,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String purchaseNumber,  String? invoiceNumber,  String supplierName,  DateTime purchaseDate,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double taxAmount,  String taxType,  double totalAmount,  String paymentStatus,  String? notes,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.purchaseNumber,_that.invoiceNumber,_that.supplierName,_that.purchaseDate,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.taxAmount,_that.taxType,_that.totalAmount,_that.paymentStatus,_that.notes,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc


class _Purchase implements Purchase {
  const _Purchase({required this.id, required this.purchaseNumber, this.invoiceNumber, required this.supplierName, required this.purchaseDate, required this.subTotal, this.discountAmount = 0, this.taxableAmount = 0, this.cgstAmount = 0, this.sgstAmount = 0, this.igstAmount = 0, required this.taxAmount, this.taxType = 'NO_TAX', required this.totalAmount, required this.paymentStatus, this.notes, this.createdByName});
  

@override final  String id;
@override final  String purchaseNumber;
@override final  String? invoiceNumber;
@override final  String supplierName;
@override final  DateTime purchaseDate;
@override final  double subTotal;
@override@JsonKey() final  double discountAmount;
@override@JsonKey() final  double taxableAmount;
@override@JsonKey() final  double cgstAmount;
@override@JsonKey() final  double sgstAmount;
@override@JsonKey() final  double igstAmount;
@override final  double taxAmount;
@override@JsonKey() final  String taxType;
@override final  double totalAmount;
@override final  String paymentStatus;
@override final  String? notes;
@override final  String? createdByName;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseCopyWith<_Purchase> get copyWith => __$PurchaseCopyWithImpl<_Purchase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Purchase&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseNumber, purchaseNumber) || other.purchaseNumber == purchaseNumber)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseNumber,invoiceNumber,supplierName,purchaseDate,subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,taxAmount,taxType,totalAmount,paymentStatus,notes,createdByName);

@override
String toString() {
  return 'Purchase(id: $id, purchaseNumber: $purchaseNumber, invoiceNumber: $invoiceNumber, supplierName: $supplierName, purchaseDate: $purchaseDate, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, taxAmount: $taxAmount, taxType: $taxType, totalAmount: $totalAmount, paymentStatus: $paymentStatus, notes: $notes, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$PurchaseCopyWith<$Res> implements $PurchaseCopyWith<$Res> {
  factory _$PurchaseCopyWith(_Purchase value, $Res Function(_Purchase) _then) = __$PurchaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String purchaseNumber, String? invoiceNumber, String supplierName, DateTime purchaseDate, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double taxAmount, String taxType, double totalAmount, String paymentStatus, String? notes, String? createdByName
});




}
/// @nodoc
class __$PurchaseCopyWithImpl<$Res>
    implements _$PurchaseCopyWith<$Res> {
  __$PurchaseCopyWithImpl(this._self, this._then);

  final _Purchase _self;
  final $Res Function(_Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? purchaseNumber = null,Object? invoiceNumber = freezed,Object? supplierName = null,Object? purchaseDate = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? taxAmount = null,Object? taxType = null,Object? totalAmount = null,Object? paymentStatus = null,Object? notes = freezed,Object? createdByName = freezed,}) {
  return _then(_Purchase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseNumber: null == purchaseNumber ? _self.purchaseNumber : purchaseNumber // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,supplierName: null == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
