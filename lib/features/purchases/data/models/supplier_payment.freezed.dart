// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupplierPayment {

 String get id; String get purchaseId; double get amount; String get method; DateTime get paymentDate; String? get referenceNumber; String? get notes; String? get recordedByName;
/// Create a copy of SupplierPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplierPaymentCopyWith<SupplierPayment> get copyWith => _$SupplierPaymentCopyWithImpl<SupplierPayment>(this as SupplierPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupplierPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.recordedByName, recordedByName) || other.recordedByName == recordedByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseId,amount,method,paymentDate,referenceNumber,notes,recordedByName);

@override
String toString() {
  return 'SupplierPayment(id: $id, purchaseId: $purchaseId, amount: $amount, method: $method, paymentDate: $paymentDate, referenceNumber: $referenceNumber, notes: $notes, recordedByName: $recordedByName)';
}


}

/// @nodoc
abstract mixin class $SupplierPaymentCopyWith<$Res>  {
  factory $SupplierPaymentCopyWith(SupplierPayment value, $Res Function(SupplierPayment) _then) = _$SupplierPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String purchaseId, double amount, String method, DateTime paymentDate, String? referenceNumber, String? notes, String? recordedByName
});




}
/// @nodoc
class _$SupplierPaymentCopyWithImpl<$Res>
    implements $SupplierPaymentCopyWith<$Res> {
  _$SupplierPaymentCopyWithImpl(this._self, this._then);

  final SupplierPayment _self;
  final $Res Function(SupplierPayment) _then;

/// Create a copy of SupplierPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? purchaseId = null,Object? amount = null,Object? method = null,Object? paymentDate = null,Object? referenceNumber = freezed,Object? notes = freezed,Object? recordedByName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,recordedByName: freezed == recordedByName ? _self.recordedByName : recordedByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupplierPayment].
extension SupplierPaymentPatterns on SupplierPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupplierPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupplierPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupplierPayment value)  $default,){
final _that = this;
switch (_that) {
case _SupplierPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupplierPayment value)?  $default,){
final _that = this;
switch (_that) {
case _SupplierPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String purchaseId,  double amount,  String method,  DateTime paymentDate,  String? referenceNumber,  String? notes,  String? recordedByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupplierPayment() when $default != null:
return $default(_that.id,_that.purchaseId,_that.amount,_that.method,_that.paymentDate,_that.referenceNumber,_that.notes,_that.recordedByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String purchaseId,  double amount,  String method,  DateTime paymentDate,  String? referenceNumber,  String? notes,  String? recordedByName)  $default,) {final _that = this;
switch (_that) {
case _SupplierPayment():
return $default(_that.id,_that.purchaseId,_that.amount,_that.method,_that.paymentDate,_that.referenceNumber,_that.notes,_that.recordedByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String purchaseId,  double amount,  String method,  DateTime paymentDate,  String? referenceNumber,  String? notes,  String? recordedByName)?  $default,) {final _that = this;
switch (_that) {
case _SupplierPayment() when $default != null:
return $default(_that.id,_that.purchaseId,_that.amount,_that.method,_that.paymentDate,_that.referenceNumber,_that.notes,_that.recordedByName);case _:
  return null;

}
}

}

/// @nodoc


class _SupplierPayment implements SupplierPayment {
  const _SupplierPayment({required this.id, required this.purchaseId, required this.amount, required this.method, required this.paymentDate, this.referenceNumber, this.notes, this.recordedByName});
  

@override final  String id;
@override final  String purchaseId;
@override final  double amount;
@override final  String method;
@override final  DateTime paymentDate;
@override final  String? referenceNumber;
@override final  String? notes;
@override final  String? recordedByName;

/// Create a copy of SupplierPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplierPaymentCopyWith<_SupplierPayment> get copyWith => __$SupplierPaymentCopyWithImpl<_SupplierPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupplierPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.recordedByName, recordedByName) || other.recordedByName == recordedByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseId,amount,method,paymentDate,referenceNumber,notes,recordedByName);

@override
String toString() {
  return 'SupplierPayment(id: $id, purchaseId: $purchaseId, amount: $amount, method: $method, paymentDate: $paymentDate, referenceNumber: $referenceNumber, notes: $notes, recordedByName: $recordedByName)';
}


}

/// @nodoc
abstract mixin class _$SupplierPaymentCopyWith<$Res> implements $SupplierPaymentCopyWith<$Res> {
  factory _$SupplierPaymentCopyWith(_SupplierPayment value, $Res Function(_SupplierPayment) _then) = __$SupplierPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String purchaseId, double amount, String method, DateTime paymentDate, String? referenceNumber, String? notes, String? recordedByName
});




}
/// @nodoc
class __$SupplierPaymentCopyWithImpl<$Res>
    implements _$SupplierPaymentCopyWith<$Res> {
  __$SupplierPaymentCopyWithImpl(this._self, this._then);

  final _SupplierPayment _self;
  final $Res Function(_SupplierPayment) _then;

/// Create a copy of SupplierPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? purchaseId = null,Object? amount = null,Object? method = null,Object? paymentDate = null,Object? referenceNumber = freezed,Object? notes = freezed,Object? recordedByName = freezed,}) {
  return _then(_SupplierPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,recordedByName: freezed == recordedByName ? _self.recordedByName : recordedByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
