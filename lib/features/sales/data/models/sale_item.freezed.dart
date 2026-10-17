// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaleItem {

 String get id; String get productId; String get productName; String get productSku; String get unitSymbol; double get quantity; double get unitPrice; double get taxRate; double get lineTotal;
/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleItemCopyWith<SaleItem> get copyWith => _$SaleItemCopyWithImpl<SaleItem>(this as SaleItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productSku,unitSymbol,quantity,unitPrice,taxRate,lineTotal);

@override
String toString() {
  return 'SaleItem(id: $id, productId: $productId, productName: $productName, productSku: $productSku, unitSymbol: $unitSymbol, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class $SaleItemCopyWith<$Res>  {
  factory $SaleItemCopyWith(SaleItem value, $Res Function(SaleItem) _then) = _$SaleItemCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String productName, String productSku, String unitSymbol, double quantity, double unitPrice, double taxRate, double lineTotal
});




}
/// @nodoc
class _$SaleItemCopyWithImpl<$Res>
    implements $SaleItemCopyWith<$Res> {
  _$SaleItemCopyWithImpl(this._self, this._then);

  final SaleItem _self;
  final $Res Function(SaleItem) _then;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productSku = null,Object? unitSymbol = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? lineTotal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productSku: null == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String,unitSymbol: null == unitSymbol ? _self.unitSymbol : unitSymbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleItem].
extension SaleItemPatterns on SaleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleItem value)  $default,){
final _that = this;
switch (_that) {
case _SaleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleItem value)?  $default,){
final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _SaleItem():
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc


class _SaleItem implements SaleItem {
  const _SaleItem({required this.id, required this.productId, required this.productName, required this.productSku, required this.unitSymbol, required this.quantity, required this.unitPrice, required this.taxRate, required this.lineTotal});
  

@override final  String id;
@override final  String productId;
@override final  String productName;
@override final  String productSku;
@override final  String unitSymbol;
@override final  double quantity;
@override final  double unitPrice;
@override final  double taxRate;
@override final  double lineTotal;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleItemCopyWith<_SaleItem> get copyWith => __$SaleItemCopyWithImpl<_SaleItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productSku,unitSymbol,quantity,unitPrice,taxRate,lineTotal);

@override
String toString() {
  return 'SaleItem(id: $id, productId: $productId, productName: $productName, productSku: $productSku, unitSymbol: $unitSymbol, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$SaleItemCopyWith<$Res> implements $SaleItemCopyWith<$Res> {
  factory _$SaleItemCopyWith(_SaleItem value, $Res Function(_SaleItem) _then) = __$SaleItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String productName, String productSku, String unitSymbol, double quantity, double unitPrice, double taxRate, double lineTotal
});




}
/// @nodoc
class __$SaleItemCopyWithImpl<$Res>
    implements _$SaleItemCopyWith<$Res> {
  __$SaleItemCopyWithImpl(this._self, this._then);

  final _SaleItem _self;
  final $Res Function(_SaleItem) _then;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productSku = null,Object? unitSymbol = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? lineTotal = null,}) {
  return _then(_SaleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productSku: null == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String,unitSymbol: null == unitSymbol ? _self.unitSymbol : unitSymbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
