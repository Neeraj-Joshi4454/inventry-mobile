// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryItem {

 String get productId; String get name; String get sku; ProductCategory get category; ProductUnit get unit; double get currentStock; double get lowStockThreshold; StockStatus get status; double get taxRate; bool get isPriceInclusive;
/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryItemCopyWith<InventoryItem> get copyWith => _$InventoryItemCopyWithImpl<InventoryItem>(this as InventoryItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.category, category) || other.category == category)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.lowStockThreshold, lowStockThreshold) || other.lowStockThreshold == lowStockThreshold)&&(identical(other.status, status) || other.status == status)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isPriceInclusive, isPriceInclusive) || other.isPriceInclusive == isPriceInclusive));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,sku,category,unit,currentStock,lowStockThreshold,status,taxRate,isPriceInclusive);

@override
String toString() {
  return 'InventoryItem(productId: $productId, name: $name, sku: $sku, category: $category, unit: $unit, currentStock: $currentStock, lowStockThreshold: $lowStockThreshold, status: $status, taxRate: $taxRate, isPriceInclusive: $isPriceInclusive)';
}


}

/// @nodoc
abstract mixin class $InventoryItemCopyWith<$Res>  {
  factory $InventoryItemCopyWith(InventoryItem value, $Res Function(InventoryItem) _then) = _$InventoryItemCopyWithImpl;
@useResult
$Res call({
 String productId, String name, String sku, ProductCategory category, ProductUnit unit, double currentStock, double lowStockThreshold, StockStatus status, double taxRate, bool isPriceInclusive
});


$ProductCategoryCopyWith<$Res> get category;$ProductUnitCopyWith<$Res> get unit;

}
/// @nodoc
class _$InventoryItemCopyWithImpl<$Res>
    implements $InventoryItemCopyWith<$Res> {
  _$InventoryItemCopyWithImpl(this._self, this._then);

  final InventoryItem _self;
  final $Res Function(InventoryItem) _then;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? sku = null,Object? category = null,Object? unit = null,Object? currentStock = null,Object? lowStockThreshold = null,Object? status = null,Object? taxRate = null,Object? isPriceInclusive = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProductCategory,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as ProductUnit,currentStock: null == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double,lowStockThreshold: null == lowStockThreshold ? _self.lowStockThreshold : lowStockThreshold // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,isPriceInclusive: null == isPriceInclusive ? _self.isPriceInclusive : isPriceInclusive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCategoryCopyWith<$Res> get category {
  
  return $ProductCategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductUnitCopyWith<$Res> get unit {
  
  return $ProductUnitCopyWith<$Res>(_self.unit, (value) {
    return _then(_self.copyWith(unit: value));
  });
}
}


/// Adds pattern-matching-related methods to [InventoryItem].
extension InventoryItemPatterns on InventoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryItem value)  $default,){
final _that = this;
switch (_that) {
case _InventoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String name,  String sku,  ProductCategory category,  ProductUnit unit,  double currentStock,  double lowStockThreshold,  StockStatus status,  double taxRate,  bool isPriceInclusive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that.productId,_that.name,_that.sku,_that.category,_that.unit,_that.currentStock,_that.lowStockThreshold,_that.status,_that.taxRate,_that.isPriceInclusive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String name,  String sku,  ProductCategory category,  ProductUnit unit,  double currentStock,  double lowStockThreshold,  StockStatus status,  double taxRate,  bool isPriceInclusive)  $default,) {final _that = this;
switch (_that) {
case _InventoryItem():
return $default(_that.productId,_that.name,_that.sku,_that.category,_that.unit,_that.currentStock,_that.lowStockThreshold,_that.status,_that.taxRate,_that.isPriceInclusive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String name,  String sku,  ProductCategory category,  ProductUnit unit,  double currentStock,  double lowStockThreshold,  StockStatus status,  double taxRate,  bool isPriceInclusive)?  $default,) {final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that.productId,_that.name,_that.sku,_that.category,_that.unit,_that.currentStock,_that.lowStockThreshold,_that.status,_that.taxRate,_that.isPriceInclusive);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryItem implements InventoryItem {
  const _InventoryItem({required this.productId, required this.name, required this.sku, required this.category, required this.unit, required this.currentStock, required this.lowStockThreshold, required this.status, this.taxRate = 0, this.isPriceInclusive = false});
  

@override final  String productId;
@override final  String name;
@override final  String sku;
@override final  ProductCategory category;
@override final  ProductUnit unit;
@override final  double currentStock;
@override final  double lowStockThreshold;
@override final  StockStatus status;
@override@JsonKey() final  double taxRate;
@override@JsonKey() final  bool isPriceInclusive;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryItemCopyWith<_InventoryItem> get copyWith => __$InventoryItemCopyWithImpl<_InventoryItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.category, category) || other.category == category)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.lowStockThreshold, lowStockThreshold) || other.lowStockThreshold == lowStockThreshold)&&(identical(other.status, status) || other.status == status)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isPriceInclusive, isPriceInclusive) || other.isPriceInclusive == isPriceInclusive));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,sku,category,unit,currentStock,lowStockThreshold,status,taxRate,isPriceInclusive);

@override
String toString() {
  return 'InventoryItem(productId: $productId, name: $name, sku: $sku, category: $category, unit: $unit, currentStock: $currentStock, lowStockThreshold: $lowStockThreshold, status: $status, taxRate: $taxRate, isPriceInclusive: $isPriceInclusive)';
}


}

/// @nodoc
abstract mixin class _$InventoryItemCopyWith<$Res> implements $InventoryItemCopyWith<$Res> {
  factory _$InventoryItemCopyWith(_InventoryItem value, $Res Function(_InventoryItem) _then) = __$InventoryItemCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, String sku, ProductCategory category, ProductUnit unit, double currentStock, double lowStockThreshold, StockStatus status, double taxRate, bool isPriceInclusive
});


@override $ProductCategoryCopyWith<$Res> get category;@override $ProductUnitCopyWith<$Res> get unit;

}
/// @nodoc
class __$InventoryItemCopyWithImpl<$Res>
    implements _$InventoryItemCopyWith<$Res> {
  __$InventoryItemCopyWithImpl(this._self, this._then);

  final _InventoryItem _self;
  final $Res Function(_InventoryItem) _then;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? sku = null,Object? category = null,Object? unit = null,Object? currentStock = null,Object? lowStockThreshold = null,Object? status = null,Object? taxRate = null,Object? isPriceInclusive = null,}) {
  return _then(_InventoryItem(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProductCategory,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as ProductUnit,currentStock: null == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double,lowStockThreshold: null == lowStockThreshold ? _self.lowStockThreshold : lowStockThreshold // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,isPriceInclusive: null == isPriceInclusive ? _self.isPriceInclusive : isPriceInclusive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCategoryCopyWith<$Res> get category {
  
  return $ProductCategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductUnitCopyWith<$Res> get unit {
  
  return $ProductUnitCopyWith<$Res>(_self.unit, (value) {
    return _then(_self.copyWith(unit: value));
  });
}
}

// dart format on
