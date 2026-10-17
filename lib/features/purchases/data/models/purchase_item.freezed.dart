// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseItem {

 String get id; String get productId; String get productName; String get productSku; String get unitSymbol; double get quantity; double get unitPrice; double get taxRate; double get lineTotal; double? get previousStock; double? get resultingStock;
/// Create a copy of PurchaseItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseItemCopyWith<PurchaseItem> get copyWith => _$PurchaseItemCopyWithImpl<PurchaseItem>(this as PurchaseItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productSku,unitSymbol,quantity,unitPrice,taxRate,lineTotal,previousStock,resultingStock);

@override
String toString() {
  return 'PurchaseItem(id: $id, productId: $productId, productName: $productName, productSku: $productSku, unitSymbol: $unitSymbol, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, lineTotal: $lineTotal, previousStock: $previousStock, resultingStock: $resultingStock)';
}


}

/// @nodoc
abstract mixin class $PurchaseItemCopyWith<$Res>  {
  factory $PurchaseItemCopyWith(PurchaseItem value, $Res Function(PurchaseItem) _then) = _$PurchaseItemCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String productName, String productSku, String unitSymbol, double quantity, double unitPrice, double taxRate, double lineTotal, double? previousStock, double? resultingStock
});




}
/// @nodoc
class _$PurchaseItemCopyWithImpl<$Res>
    implements $PurchaseItemCopyWith<$Res> {
  _$PurchaseItemCopyWithImpl(this._self, this._then);

  final PurchaseItem _self;
  final $Res Function(PurchaseItem) _then;

/// Create a copy of PurchaseItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productSku = null,Object? unitSymbol = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? lineTotal = null,Object? previousStock = freezed,Object? resultingStock = freezed,}) {
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
as double,previousStock: freezed == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double?,resultingStock: freezed == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseItem].
extension PurchaseItemPatterns on PurchaseItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseItem value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseItem value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal,  double? previousStock,  double? resultingStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseItem() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal,_that.previousStock,_that.resultingStock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal,  double? previousStock,  double? resultingStock)  $default,) {final _that = this;
switch (_that) {
case _PurchaseItem():
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal,_that.previousStock,_that.resultingStock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String productName,  String productSku,  String unitSymbol,  double quantity,  double unitPrice,  double taxRate,  double lineTotal,  double? previousStock,  double? resultingStock)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseItem() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productSku,_that.unitSymbol,_that.quantity,_that.unitPrice,_that.taxRate,_that.lineTotal,_that.previousStock,_that.resultingStock);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseItem implements PurchaseItem {
  const _PurchaseItem({required this.id, required this.productId, required this.productName, required this.productSku, required this.unitSymbol, required this.quantity, required this.unitPrice, required this.taxRate, required this.lineTotal, this.previousStock, this.resultingStock});
  

@override final  String id;
@override final  String productId;
@override final  String productName;
@override final  String productSku;
@override final  String unitSymbol;
@override final  double quantity;
@override final  double unitPrice;
@override final  double taxRate;
@override final  double lineTotal;
@override final  double? previousStock;
@override final  double? resultingStock;

/// Create a copy of PurchaseItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseItemCopyWith<_PurchaseItem> get copyWith => __$PurchaseItemCopyWithImpl<_PurchaseItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.unitSymbol, unitSymbol) || other.unitSymbol == unitSymbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productSku,unitSymbol,quantity,unitPrice,taxRate,lineTotal,previousStock,resultingStock);

@override
String toString() {
  return 'PurchaseItem(id: $id, productId: $productId, productName: $productName, productSku: $productSku, unitSymbol: $unitSymbol, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, lineTotal: $lineTotal, previousStock: $previousStock, resultingStock: $resultingStock)';
}


}

/// @nodoc
abstract mixin class _$PurchaseItemCopyWith<$Res> implements $PurchaseItemCopyWith<$Res> {
  factory _$PurchaseItemCopyWith(_PurchaseItem value, $Res Function(_PurchaseItem) _then) = __$PurchaseItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String productName, String productSku, String unitSymbol, double quantity, double unitPrice, double taxRate, double lineTotal, double? previousStock, double? resultingStock
});




}
/// @nodoc
class __$PurchaseItemCopyWithImpl<$Res>
    implements _$PurchaseItemCopyWith<$Res> {
  __$PurchaseItemCopyWithImpl(this._self, this._then);

  final _PurchaseItem _self;
  final $Res Function(_PurchaseItem) _then;

/// Create a copy of PurchaseItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productSku = null,Object? unitSymbol = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? lineTotal = null,Object? previousStock = freezed,Object? resultingStock = freezed,}) {
  return _then(_PurchaseItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productSku: null == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String,unitSymbol: null == unitSymbol ? _self.unitSymbol : unitSymbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,previousStock: freezed == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double?,resultingStock: freezed == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
