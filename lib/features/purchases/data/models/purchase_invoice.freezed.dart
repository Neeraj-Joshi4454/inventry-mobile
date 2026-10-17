// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseInvoiceParty {

 String? get name; String? get addressLine; String? get gstin; String? get phone; String? get email;
/// Create a copy of PurchaseInvoiceParty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseInvoicePartyCopyWith<PurchaseInvoiceParty> get copyWith => _$PurchaseInvoicePartyCopyWithImpl<PurchaseInvoiceParty>(this as PurchaseInvoiceParty, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseInvoiceParty&&(identical(other.name, name) || other.name == name)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.gstin, gstin) || other.gstin == gstin)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,name,addressLine,gstin,phone,email);

@override
String toString() {
  return 'PurchaseInvoiceParty(name: $name, addressLine: $addressLine, gstin: $gstin, phone: $phone, email: $email)';
}


}

/// @nodoc
abstract mixin class $PurchaseInvoicePartyCopyWith<$Res>  {
  factory $PurchaseInvoicePartyCopyWith(PurchaseInvoiceParty value, $Res Function(PurchaseInvoiceParty) _then) = _$PurchaseInvoicePartyCopyWithImpl;
@useResult
$Res call({
 String? name, String? addressLine, String? gstin, String? phone, String? email
});




}
/// @nodoc
class _$PurchaseInvoicePartyCopyWithImpl<$Res>
    implements $PurchaseInvoicePartyCopyWith<$Res> {
  _$PurchaseInvoicePartyCopyWithImpl(this._self, this._then);

  final PurchaseInvoiceParty _self;
  final $Res Function(PurchaseInvoiceParty) _then;

/// Create a copy of PurchaseInvoiceParty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? addressLine = freezed,Object? gstin = freezed,Object? phone = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,addressLine: freezed == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String?,gstin: freezed == gstin ? _self.gstin : gstin // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseInvoiceParty].
extension PurchaseInvoicePartyPatterns on PurchaseInvoiceParty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseInvoiceParty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseInvoiceParty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseInvoiceParty value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoiceParty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseInvoiceParty value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoiceParty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? addressLine,  String? gstin,  String? phone,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseInvoiceParty() when $default != null:
return $default(_that.name,_that.addressLine,_that.gstin,_that.phone,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? addressLine,  String? gstin,  String? phone,  String? email)  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoiceParty():
return $default(_that.name,_that.addressLine,_that.gstin,_that.phone,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? addressLine,  String? gstin,  String? phone,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoiceParty() when $default != null:
return $default(_that.name,_that.addressLine,_that.gstin,_that.phone,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseInvoiceParty extends PurchaseInvoiceParty {
  const _PurchaseInvoiceParty({this.name, this.addressLine, this.gstin, this.phone, this.email}): super._();
  

@override final  String? name;
@override final  String? addressLine;
@override final  String? gstin;
@override final  String? phone;
@override final  String? email;

/// Create a copy of PurchaseInvoiceParty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseInvoicePartyCopyWith<_PurchaseInvoiceParty> get copyWith => __$PurchaseInvoicePartyCopyWithImpl<_PurchaseInvoiceParty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseInvoiceParty&&(identical(other.name, name) || other.name == name)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.gstin, gstin) || other.gstin == gstin)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,name,addressLine,gstin,phone,email);

@override
String toString() {
  return 'PurchaseInvoiceParty(name: $name, addressLine: $addressLine, gstin: $gstin, phone: $phone, email: $email)';
}


}

/// @nodoc
abstract mixin class _$PurchaseInvoicePartyCopyWith<$Res> implements $PurchaseInvoicePartyCopyWith<$Res> {
  factory _$PurchaseInvoicePartyCopyWith(_PurchaseInvoiceParty value, $Res Function(_PurchaseInvoiceParty) _then) = __$PurchaseInvoicePartyCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? addressLine, String? gstin, String? phone, String? email
});




}
/// @nodoc
class __$PurchaseInvoicePartyCopyWithImpl<$Res>
    implements _$PurchaseInvoicePartyCopyWith<$Res> {
  __$PurchaseInvoicePartyCopyWithImpl(this._self, this._then);

  final _PurchaseInvoiceParty _self;
  final $Res Function(_PurchaseInvoiceParty) _then;

/// Create a copy of PurchaseInvoiceParty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? addressLine = freezed,Object? gstin = freezed,Object? phone = freezed,Object? email = freezed,}) {
  return _then(_PurchaseInvoiceParty(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,addressLine: freezed == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String?,gstin: freezed == gstin ? _self.gstin : gstin // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PurchaseInvoiceLineItem {

 String? get productName; String? get hsnCode; double get quantity; String? get unitSymbol; double get rate; double get discount; double get taxableValue; double get taxRate; double get cgst; double get sgst; double get igst; double get lineTotal;
/// Create a copy of PurchaseInvoiceLineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseInvoiceLineItemCopyWith<PurchaseInvoiceLineItem> get copyWith => _$PurchaseInvoiceLineItemCopyWithImpl<PurchaseInvoiceLineItem>(this as PurchaseInvoiceLineItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseInvoiceLineItem&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.hsnCode, hsnCode) || other.hsnCode == hsnCode)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.taxableValue, taxableValue) || other.taxableValue == taxableValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.cgst, cgst) || other.cgst == cgst)&&(identical(other.sgst, sgst) || other.sgst == sgst)&&(identical(other.igst, igst) || other.igst == igst)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode => Object.hash(runtimeType,productName,hsnCode,quantity,unitSymbol,rate,discount,taxableValue,taxRate,cgst,sgst,igst,lineTotal);

@override
String toString() {
  return 'PurchaseInvoiceLineItem(productName: $productName, hsnCode: $hsnCode, quantity: $quantity, unitSymbol: $unitSymbol, rate: $rate, discount: $discount, taxableValue: $taxableValue, taxRate: $taxRate, cgst: $cgst, sgst: $sgst, igst: $igst, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class $PurchaseInvoiceLineItemCopyWith<$Res>  {
  factory $PurchaseInvoiceLineItemCopyWith(PurchaseInvoiceLineItem value, $Res Function(PurchaseInvoiceLineItem) _then) = _$PurchaseInvoiceLineItemCopyWithImpl;
@useResult
$Res call({
 String? productName, String? hsnCode, double quantity, String? unitSymbol, double rate, double discount, double taxableValue, double taxRate, double cgst, double sgst, double igst, double lineTotal
});




}
/// @nodoc
class _$PurchaseInvoiceLineItemCopyWithImpl<$Res>
    implements $PurchaseInvoiceLineItemCopyWith<$Res> {
  _$PurchaseInvoiceLineItemCopyWithImpl(this._self, this._then);

  final PurchaseInvoiceLineItem _self;
  final $Res Function(PurchaseInvoiceLineItem) _then;

/// Create a copy of PurchaseInvoiceLineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = freezed,Object? hsnCode = freezed,Object? quantity = null,Object? unitSymbol = freezed,Object? rate = null,Object? discount = null,Object? taxableValue = null,Object? taxRate = null,Object? cgst = null,Object? sgst = null,Object? igst = null,Object? lineTotal = null,}) {
  return _then(_self.copyWith(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,hsnCode: freezed == hsnCode ? _self.hsnCode : hsnCode // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitSymbol: freezed == unitSymbol ? _self.unitSymbol : unitSymbol // ignore: cast_nullable_to_non_nullable
as String?,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,taxableValue: null == taxableValue ? _self.taxableValue : taxableValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,cgst: null == cgst ? _self.cgst : cgst // ignore: cast_nullable_to_non_nullable
as double,sgst: null == sgst ? _self.sgst : sgst // ignore: cast_nullable_to_non_nullable
as double,igst: null == igst ? _self.igst : igst // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseInvoiceLineItem].
extension PurchaseInvoiceLineItemPatterns on PurchaseInvoiceLineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseInvoiceLineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseInvoiceLineItem value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseInvoiceLineItem value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? productName,  String? hsnCode,  double quantity,  String? unitSymbol,  double rate,  double discount,  double taxableValue,  double taxRate,  double cgst,  double sgst,  double igst,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem() when $default != null:
return $default(_that.productName,_that.hsnCode,_that.quantity,_that.unitSymbol,_that.rate,_that.discount,_that.taxableValue,_that.taxRate,_that.cgst,_that.sgst,_that.igst,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? productName,  String? hsnCode,  double quantity,  String? unitSymbol,  double rate,  double discount,  double taxableValue,  double taxRate,  double cgst,  double sgst,  double igst,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem():
return $default(_that.productName,_that.hsnCode,_that.quantity,_that.unitSymbol,_that.rate,_that.discount,_that.taxableValue,_that.taxRate,_that.cgst,_that.sgst,_that.igst,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? productName,  String? hsnCode,  double quantity,  String? unitSymbol,  double rate,  double discount,  double taxableValue,  double taxRate,  double cgst,  double sgst,  double igst,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoiceLineItem() when $default != null:
return $default(_that.productName,_that.hsnCode,_that.quantity,_that.unitSymbol,_that.rate,_that.discount,_that.taxableValue,_that.taxRate,_that.cgst,_that.sgst,_that.igst,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseInvoiceLineItem implements PurchaseInvoiceLineItem {
  const _PurchaseInvoiceLineItem({this.productName, this.hsnCode, required this.quantity, this.unitSymbol, required this.rate, required this.discount, required this.taxableValue, required this.taxRate, required this.cgst, required this.sgst, required this.igst, required this.lineTotal});
  

@override final  String? productName;
@override final  String? hsnCode;
@override final  double quantity;
@override final  String? unitSymbol;
@override final  double rate;
@override final  double discount;
@override final  double taxableValue;
@override final  double taxRate;
@override final  double cgst;
@override final  double sgst;
@override final  double igst;
@override final  double lineTotal;

/// Create a copy of PurchaseInvoiceLineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseInvoiceLineItemCopyWith<_PurchaseInvoiceLineItem> get copyWith => __$PurchaseInvoiceLineItemCopyWithImpl<_PurchaseInvoiceLineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseInvoiceLineItem&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.hsnCode, hsnCode) || other.hsnCode == hsnCode)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.taxableValue, taxableValue) || other.taxableValue == taxableValue)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.cgst, cgst) || other.cgst == cgst)&&(identical(other.sgst, sgst) || other.sgst == sgst)&&(identical(other.igst, igst) || other.igst == igst)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode => Object.hash(runtimeType,productName,hsnCode,quantity,unitSymbol,rate,discount,taxableValue,taxRate,cgst,sgst,igst,lineTotal);

@override
String toString() {
  return 'PurchaseInvoiceLineItem(productName: $productName, hsnCode: $hsnCode, quantity: $quantity, unitSymbol: $unitSymbol, rate: $rate, discount: $discount, taxableValue: $taxableValue, taxRate: $taxRate, cgst: $cgst, sgst: $sgst, igst: $igst, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$PurchaseInvoiceLineItemCopyWith<$Res> implements $PurchaseInvoiceLineItemCopyWith<$Res> {
  factory _$PurchaseInvoiceLineItemCopyWith(_PurchaseInvoiceLineItem value, $Res Function(_PurchaseInvoiceLineItem) _then) = __$PurchaseInvoiceLineItemCopyWithImpl;
@override @useResult
$Res call({
 String? productName, String? hsnCode, double quantity, String? unitSymbol, double rate, double discount, double taxableValue, double taxRate, double cgst, double sgst, double igst, double lineTotal
});




}
/// @nodoc
class __$PurchaseInvoiceLineItemCopyWithImpl<$Res>
    implements _$PurchaseInvoiceLineItemCopyWith<$Res> {
  __$PurchaseInvoiceLineItemCopyWithImpl(this._self, this._then);

  final _PurchaseInvoiceLineItem _self;
  final $Res Function(_PurchaseInvoiceLineItem) _then;

/// Create a copy of PurchaseInvoiceLineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = freezed,Object? hsnCode = freezed,Object? quantity = null,Object? unitSymbol = freezed,Object? rate = null,Object? discount = null,Object? taxableValue = null,Object? taxRate = null,Object? cgst = null,Object? sgst = null,Object? igst = null,Object? lineTotal = null,}) {
  return _then(_PurchaseInvoiceLineItem(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,hsnCode: freezed == hsnCode ? _self.hsnCode : hsnCode // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitSymbol: freezed == unitSymbol ? _self.unitSymbol : unitSymbol // ignore: cast_nullable_to_non_nullable
as String?,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,taxableValue: null == taxableValue ? _self.taxableValue : taxableValue // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,cgst: null == cgst ? _self.cgst : cgst // ignore: cast_nullable_to_non_nullable
as double,sgst: null == sgst ? _self.sgst : sgst // ignore: cast_nullable_to_non_nullable
as double,igst: null == igst ? _self.igst : igst // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PurchaseInvoice {

 PurchaseInvoiceParty get business; PurchaseInvoiceParty get supplier; String get invoiceNumber; String? get supplierInvoiceNumber; DateTime get invoiceDate; String get taxType; List<PurchaseInvoiceLineItem> get items; double get subTotal; double get discountAmount; double get taxableAmount; double get cgstAmount; double get sgstAmount; double get igstAmount; double get totalTax; double get grandTotal; String? get invoiceFooterNote;
/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseInvoiceCopyWith<PurchaseInvoice> get copyWith => _$PurchaseInvoiceCopyWithImpl<PurchaseInvoice>(this as PurchaseInvoice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseInvoice&&(identical(other.business, business) || other.business == business)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.supplierInvoiceNumber, supplierInvoiceNumber) || other.supplierInvoiceNumber == supplierInvoiceNumber)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.invoiceFooterNote, invoiceFooterNote) || other.invoiceFooterNote == invoiceFooterNote));
}


@override
int get hashCode => Object.hash(runtimeType,business,supplier,invoiceNumber,supplierInvoiceNumber,invoiceDate,taxType,const DeepCollectionEquality().hash(items),subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,totalTax,grandTotal,invoiceFooterNote);

@override
String toString() {
  return 'PurchaseInvoice(business: $business, supplier: $supplier, invoiceNumber: $invoiceNumber, supplierInvoiceNumber: $supplierInvoiceNumber, invoiceDate: $invoiceDate, taxType: $taxType, items: $items, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, totalTax: $totalTax, grandTotal: $grandTotal, invoiceFooterNote: $invoiceFooterNote)';
}


}

/// @nodoc
abstract mixin class $PurchaseInvoiceCopyWith<$Res>  {
  factory $PurchaseInvoiceCopyWith(PurchaseInvoice value, $Res Function(PurchaseInvoice) _then) = _$PurchaseInvoiceCopyWithImpl;
@useResult
$Res call({
 PurchaseInvoiceParty business, PurchaseInvoiceParty supplier, String invoiceNumber, String? supplierInvoiceNumber, DateTime invoiceDate, String taxType, List<PurchaseInvoiceLineItem> items, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double totalTax, double grandTotal, String? invoiceFooterNote
});


$PurchaseInvoicePartyCopyWith<$Res> get business;$PurchaseInvoicePartyCopyWith<$Res> get supplier;

}
/// @nodoc
class _$PurchaseInvoiceCopyWithImpl<$Res>
    implements $PurchaseInvoiceCopyWith<$Res> {
  _$PurchaseInvoiceCopyWithImpl(this._self, this._then);

  final PurchaseInvoice _self;
  final $Res Function(PurchaseInvoice) _then;

/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? business = null,Object? supplier = null,Object? invoiceNumber = null,Object? supplierInvoiceNumber = freezed,Object? invoiceDate = null,Object? taxType = null,Object? items = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? totalTax = null,Object? grandTotal = null,Object? invoiceFooterNote = freezed,}) {
  return _then(_self.copyWith(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as PurchaseInvoiceParty,supplier: null == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as PurchaseInvoiceParty,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,supplierInvoiceNumber: freezed == supplierInvoiceNumber ? _self.supplierInvoiceNumber : supplierInvoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseInvoiceLineItem>,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as double,invoiceFooterNote: freezed == invoiceFooterNote ? _self.invoiceFooterNote : invoiceFooterNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseInvoicePartyCopyWith<$Res> get business {
  
  return $PurchaseInvoicePartyCopyWith<$Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseInvoicePartyCopyWith<$Res> get supplier {
  
  return $PurchaseInvoicePartyCopyWith<$Res>(_self.supplier, (value) {
    return _then(_self.copyWith(supplier: value));
  });
}
}


/// Adds pattern-matching-related methods to [PurchaseInvoice].
extension PurchaseInvoicePatterns on PurchaseInvoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseInvoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseInvoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseInvoice value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseInvoice value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseInvoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PurchaseInvoiceParty business,  PurchaseInvoiceParty supplier,  String invoiceNumber,  String? supplierInvoiceNumber,  DateTime invoiceDate,  String taxType,  List<PurchaseInvoiceLineItem> items,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double totalTax,  double grandTotal,  String? invoiceFooterNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseInvoice() when $default != null:
return $default(_that.business,_that.supplier,_that.invoiceNumber,_that.supplierInvoiceNumber,_that.invoiceDate,_that.taxType,_that.items,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.totalTax,_that.grandTotal,_that.invoiceFooterNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PurchaseInvoiceParty business,  PurchaseInvoiceParty supplier,  String invoiceNumber,  String? supplierInvoiceNumber,  DateTime invoiceDate,  String taxType,  List<PurchaseInvoiceLineItem> items,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double totalTax,  double grandTotal,  String? invoiceFooterNote)  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoice():
return $default(_that.business,_that.supplier,_that.invoiceNumber,_that.supplierInvoiceNumber,_that.invoiceDate,_that.taxType,_that.items,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.totalTax,_that.grandTotal,_that.invoiceFooterNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PurchaseInvoiceParty business,  PurchaseInvoiceParty supplier,  String invoiceNumber,  String? supplierInvoiceNumber,  DateTime invoiceDate,  String taxType,  List<PurchaseInvoiceLineItem> items,  double subTotal,  double discountAmount,  double taxableAmount,  double cgstAmount,  double sgstAmount,  double igstAmount,  double totalTax,  double grandTotal,  String? invoiceFooterNote)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseInvoice() when $default != null:
return $default(_that.business,_that.supplier,_that.invoiceNumber,_that.supplierInvoiceNumber,_that.invoiceDate,_that.taxType,_that.items,_that.subTotal,_that.discountAmount,_that.taxableAmount,_that.cgstAmount,_that.sgstAmount,_that.igstAmount,_that.totalTax,_that.grandTotal,_that.invoiceFooterNote);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseInvoice implements PurchaseInvoice {
  const _PurchaseInvoice({required this.business, required this.supplier, required this.invoiceNumber, this.supplierInvoiceNumber, required this.invoiceDate, required this.taxType, required final  List<PurchaseInvoiceLineItem> items, required this.subTotal, required this.discountAmount, required this.taxableAmount, required this.cgstAmount, required this.sgstAmount, required this.igstAmount, required this.totalTax, required this.grandTotal, this.invoiceFooterNote}): _items = items;
  

@override final  PurchaseInvoiceParty business;
@override final  PurchaseInvoiceParty supplier;
@override final  String invoiceNumber;
@override final  String? supplierInvoiceNumber;
@override final  DateTime invoiceDate;
@override final  String taxType;
 final  List<PurchaseInvoiceLineItem> _items;
@override List<PurchaseInvoiceLineItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double subTotal;
@override final  double discountAmount;
@override final  double taxableAmount;
@override final  double cgstAmount;
@override final  double sgstAmount;
@override final  double igstAmount;
@override final  double totalTax;
@override final  double grandTotal;
@override final  String? invoiceFooterNote;

/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseInvoiceCopyWith<_PurchaseInvoice> get copyWith => __$PurchaseInvoiceCopyWithImpl<_PurchaseInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseInvoice&&(identical(other.business, business) || other.business == business)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.supplierInvoiceNumber, supplierInvoiceNumber) || other.supplierInvoiceNumber == supplierInvoiceNumber)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.cgstAmount, cgstAmount) || other.cgstAmount == cgstAmount)&&(identical(other.sgstAmount, sgstAmount) || other.sgstAmount == sgstAmount)&&(identical(other.igstAmount, igstAmount) || other.igstAmount == igstAmount)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.invoiceFooterNote, invoiceFooterNote) || other.invoiceFooterNote == invoiceFooterNote));
}


@override
int get hashCode => Object.hash(runtimeType,business,supplier,invoiceNumber,supplierInvoiceNumber,invoiceDate,taxType,const DeepCollectionEquality().hash(_items),subTotal,discountAmount,taxableAmount,cgstAmount,sgstAmount,igstAmount,totalTax,grandTotal,invoiceFooterNote);

@override
String toString() {
  return 'PurchaseInvoice(business: $business, supplier: $supplier, invoiceNumber: $invoiceNumber, supplierInvoiceNumber: $supplierInvoiceNumber, invoiceDate: $invoiceDate, taxType: $taxType, items: $items, subTotal: $subTotal, discountAmount: $discountAmount, taxableAmount: $taxableAmount, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, totalTax: $totalTax, grandTotal: $grandTotal, invoiceFooterNote: $invoiceFooterNote)';
}


}

/// @nodoc
abstract mixin class _$PurchaseInvoiceCopyWith<$Res> implements $PurchaseInvoiceCopyWith<$Res> {
  factory _$PurchaseInvoiceCopyWith(_PurchaseInvoice value, $Res Function(_PurchaseInvoice) _then) = __$PurchaseInvoiceCopyWithImpl;
@override @useResult
$Res call({
 PurchaseInvoiceParty business, PurchaseInvoiceParty supplier, String invoiceNumber, String? supplierInvoiceNumber, DateTime invoiceDate, String taxType, List<PurchaseInvoiceLineItem> items, double subTotal, double discountAmount, double taxableAmount, double cgstAmount, double sgstAmount, double igstAmount, double totalTax, double grandTotal, String? invoiceFooterNote
});


@override $PurchaseInvoicePartyCopyWith<$Res> get business;@override $PurchaseInvoicePartyCopyWith<$Res> get supplier;

}
/// @nodoc
class __$PurchaseInvoiceCopyWithImpl<$Res>
    implements _$PurchaseInvoiceCopyWith<$Res> {
  __$PurchaseInvoiceCopyWithImpl(this._self, this._then);

  final _PurchaseInvoice _self;
  final $Res Function(_PurchaseInvoice) _then;

/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? business = null,Object? supplier = null,Object? invoiceNumber = null,Object? supplierInvoiceNumber = freezed,Object? invoiceDate = null,Object? taxType = null,Object? items = null,Object? subTotal = null,Object? discountAmount = null,Object? taxableAmount = null,Object? cgstAmount = null,Object? sgstAmount = null,Object? igstAmount = null,Object? totalTax = null,Object? grandTotal = null,Object? invoiceFooterNote = freezed,}) {
  return _then(_PurchaseInvoice(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as PurchaseInvoiceParty,supplier: null == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as PurchaseInvoiceParty,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,supplierInvoiceNumber: freezed == supplierInvoiceNumber ? _self.supplierInvoiceNumber : supplierInvoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseInvoiceLineItem>,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,cgstAmount: null == cgstAmount ? _self.cgstAmount : cgstAmount // ignore: cast_nullable_to_non_nullable
as double,sgstAmount: null == sgstAmount ? _self.sgstAmount : sgstAmount // ignore: cast_nullable_to_non_nullable
as double,igstAmount: null == igstAmount ? _self.igstAmount : igstAmount // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as double,invoiceFooterNote: freezed == invoiceFooterNote ? _self.invoiceFooterNote : invoiceFooterNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseInvoicePartyCopyWith<$Res> get business {
  
  return $PurchaseInvoicePartyCopyWith<$Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}/// Create a copy of PurchaseInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseInvoicePartyCopyWith<$Res> get supplier {
  
  return $PurchaseInvoicePartyCopyWith<$Res>(_self.supplier, (value) {
    return _then(_self.copyWith(supplier: value));
  });
}
}

// dart format on
