// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockReportSummary {

 int get totalProducts; double get totalStockQuantity; double get totalStockValue;
/// Create a copy of StockReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockReportSummaryCopyWith<StockReportSummary> get copyWith => _$StockReportSummaryCopyWithImpl<StockReportSummary>(this as StockReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockReportSummary&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalStockQuantity, totalStockQuantity) || other.totalStockQuantity == totalStockQuantity)&&(identical(other.totalStockValue, totalStockValue) || other.totalStockValue == totalStockValue));
}


@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalStockQuantity,totalStockValue);

@override
String toString() {
  return 'StockReportSummary(totalProducts: $totalProducts, totalStockQuantity: $totalStockQuantity, totalStockValue: $totalStockValue)';
}


}

/// @nodoc
abstract mixin class $StockReportSummaryCopyWith<$Res>  {
  factory $StockReportSummaryCopyWith(StockReportSummary value, $Res Function(StockReportSummary) _then) = _$StockReportSummaryCopyWithImpl;
@useResult
$Res call({
 int totalProducts, double totalStockQuantity, double totalStockValue
});




}
/// @nodoc
class _$StockReportSummaryCopyWithImpl<$Res>
    implements $StockReportSummaryCopyWith<$Res> {
  _$StockReportSummaryCopyWithImpl(this._self, this._then);

  final StockReportSummary _self;
  final $Res Function(StockReportSummary) _then;

/// Create a copy of StockReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProducts = null,Object? totalStockQuantity = null,Object? totalStockValue = null,}) {
  return _then(_self.copyWith(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalStockQuantity: null == totalStockQuantity ? _self.totalStockQuantity : totalStockQuantity // ignore: cast_nullable_to_non_nullable
as double,totalStockValue: null == totalStockValue ? _self.totalStockValue : totalStockValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StockReportSummary].
extension StockReportSummaryPatterns on StockReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _StockReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _StockReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalProducts,  double totalStockQuantity,  double totalStockValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockReportSummary() when $default != null:
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalProducts,  double totalStockQuantity,  double totalStockValue)  $default,) {final _that = this;
switch (_that) {
case _StockReportSummary():
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalProducts,  double totalStockQuantity,  double totalStockValue)?  $default,) {final _that = this;
switch (_that) {
case _StockReportSummary() when $default != null:
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue);case _:
  return null;

}
}

}

/// @nodoc


class _StockReportSummary implements StockReportSummary {
  const _StockReportSummary({required this.totalProducts, required this.totalStockQuantity, required this.totalStockValue});
  

@override final  int totalProducts;
@override final  double totalStockQuantity;
@override final  double totalStockValue;

/// Create a copy of StockReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockReportSummaryCopyWith<_StockReportSummary> get copyWith => __$StockReportSummaryCopyWithImpl<_StockReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockReportSummary&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalStockQuantity, totalStockQuantity) || other.totalStockQuantity == totalStockQuantity)&&(identical(other.totalStockValue, totalStockValue) || other.totalStockValue == totalStockValue));
}


@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalStockQuantity,totalStockValue);

@override
String toString() {
  return 'StockReportSummary(totalProducts: $totalProducts, totalStockQuantity: $totalStockQuantity, totalStockValue: $totalStockValue)';
}


}

/// @nodoc
abstract mixin class _$StockReportSummaryCopyWith<$Res> implements $StockReportSummaryCopyWith<$Res> {
  factory _$StockReportSummaryCopyWith(_StockReportSummary value, $Res Function(_StockReportSummary) _then) = __$StockReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalProducts, double totalStockQuantity, double totalStockValue
});




}
/// @nodoc
class __$StockReportSummaryCopyWithImpl<$Res>
    implements _$StockReportSummaryCopyWith<$Res> {
  __$StockReportSummaryCopyWithImpl(this._self, this._then);

  final _StockReportSummary _self;
  final $Res Function(_StockReportSummary) _then;

/// Create a copy of StockReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProducts = null,Object? totalStockQuantity = null,Object? totalStockValue = null,}) {
  return _then(_StockReportSummary(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalStockQuantity: null == totalStockQuantity ? _self.totalStockQuantity : totalStockQuantity // ignore: cast_nullable_to_non_nullable
as double,totalStockValue: null == totalStockValue ? _self.totalStockValue : totalStockValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$StockReportRow {

 String get productId; String get name; String get sku; String get categoryName; double get currentStock; double get lowStockThreshold; double get purchasePrice; double get sellingPrice; double get stockValue; StockStatus get status;
/// Create a copy of StockReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockReportRowCopyWith<StockReportRow> get copyWith => _$StockReportRowCopyWithImpl<StockReportRow>(this as StockReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockReportRow&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.lowStockThreshold, lowStockThreshold) || other.lowStockThreshold == lowStockThreshold)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&(identical(other.stockValue, stockValue) || other.stockValue == stockValue)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,sku,categoryName,currentStock,lowStockThreshold,purchasePrice,sellingPrice,stockValue,status);

@override
String toString() {
  return 'StockReportRow(productId: $productId, name: $name, sku: $sku, categoryName: $categoryName, currentStock: $currentStock, lowStockThreshold: $lowStockThreshold, purchasePrice: $purchasePrice, sellingPrice: $sellingPrice, stockValue: $stockValue, status: $status)';
}


}

/// @nodoc
abstract mixin class $StockReportRowCopyWith<$Res>  {
  factory $StockReportRowCopyWith(StockReportRow value, $Res Function(StockReportRow) _then) = _$StockReportRowCopyWithImpl;
@useResult
$Res call({
 String productId, String name, String sku, String categoryName, double currentStock, double lowStockThreshold, double purchasePrice, double sellingPrice, double stockValue, StockStatus status
});




}
/// @nodoc
class _$StockReportRowCopyWithImpl<$Res>
    implements $StockReportRowCopyWith<$Res> {
  _$StockReportRowCopyWithImpl(this._self, this._then);

  final StockReportRow _self;
  final $Res Function(StockReportRow) _then;

/// Create a copy of StockReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? sku = null,Object? categoryName = null,Object? currentStock = null,Object? lowStockThreshold = null,Object? purchasePrice = null,Object? sellingPrice = null,Object? stockValue = null,Object? status = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,currentStock: null == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double,lowStockThreshold: null == lowStockThreshold ? _self.lowStockThreshold : lowStockThreshold // ignore: cast_nullable_to_non_nullable
as double,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,stockValue: null == stockValue ? _self.stockValue : stockValue // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [StockReportRow].
extension StockReportRowPatterns on StockReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockReportRow value)  $default,){
final _that = this;
switch (_that) {
case _StockReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _StockReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String name,  String sku,  String categoryName,  double currentStock,  double lowStockThreshold,  double purchasePrice,  double sellingPrice,  double stockValue,  StockStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockReportRow() when $default != null:
return $default(_that.productId,_that.name,_that.sku,_that.categoryName,_that.currentStock,_that.lowStockThreshold,_that.purchasePrice,_that.sellingPrice,_that.stockValue,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String name,  String sku,  String categoryName,  double currentStock,  double lowStockThreshold,  double purchasePrice,  double sellingPrice,  double stockValue,  StockStatus status)  $default,) {final _that = this;
switch (_that) {
case _StockReportRow():
return $default(_that.productId,_that.name,_that.sku,_that.categoryName,_that.currentStock,_that.lowStockThreshold,_that.purchasePrice,_that.sellingPrice,_that.stockValue,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String name,  String sku,  String categoryName,  double currentStock,  double lowStockThreshold,  double purchasePrice,  double sellingPrice,  double stockValue,  StockStatus status)?  $default,) {final _that = this;
switch (_that) {
case _StockReportRow() when $default != null:
return $default(_that.productId,_that.name,_that.sku,_that.categoryName,_that.currentStock,_that.lowStockThreshold,_that.purchasePrice,_that.sellingPrice,_that.stockValue,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _StockReportRow implements StockReportRow {
  const _StockReportRow({required this.productId, required this.name, required this.sku, required this.categoryName, required this.currentStock, required this.lowStockThreshold, required this.purchasePrice, required this.sellingPrice, required this.stockValue, required this.status});
  

@override final  String productId;
@override final  String name;
@override final  String sku;
@override final  String categoryName;
@override final  double currentStock;
@override final  double lowStockThreshold;
@override final  double purchasePrice;
@override final  double sellingPrice;
@override final  double stockValue;
@override final  StockStatus status;

/// Create a copy of StockReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockReportRowCopyWith<_StockReportRow> get copyWith => __$StockReportRowCopyWithImpl<_StockReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockReportRow&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.lowStockThreshold, lowStockThreshold) || other.lowStockThreshold == lowStockThreshold)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&(identical(other.stockValue, stockValue) || other.stockValue == stockValue)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,sku,categoryName,currentStock,lowStockThreshold,purchasePrice,sellingPrice,stockValue,status);

@override
String toString() {
  return 'StockReportRow(productId: $productId, name: $name, sku: $sku, categoryName: $categoryName, currentStock: $currentStock, lowStockThreshold: $lowStockThreshold, purchasePrice: $purchasePrice, sellingPrice: $sellingPrice, stockValue: $stockValue, status: $status)';
}


}

/// @nodoc
abstract mixin class _$StockReportRowCopyWith<$Res> implements $StockReportRowCopyWith<$Res> {
  factory _$StockReportRowCopyWith(_StockReportRow value, $Res Function(_StockReportRow) _then) = __$StockReportRowCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, String sku, String categoryName, double currentStock, double lowStockThreshold, double purchasePrice, double sellingPrice, double stockValue, StockStatus status
});




}
/// @nodoc
class __$StockReportRowCopyWithImpl<$Res>
    implements _$StockReportRowCopyWith<$Res> {
  __$StockReportRowCopyWithImpl(this._self, this._then);

  final _StockReportRow _self;
  final $Res Function(_StockReportRow) _then;

/// Create a copy of StockReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? sku = null,Object? categoryName = null,Object? currentStock = null,Object? lowStockThreshold = null,Object? purchasePrice = null,Object? sellingPrice = null,Object? stockValue = null,Object? status = null,}) {
  return _then(_StockReportRow(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,currentStock: null == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double,lowStockThreshold: null == lowStockThreshold ? _self.lowStockThreshold : lowStockThreshold // ignore: cast_nullable_to_non_nullable
as double,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,stockValue: null == stockValue ? _self.stockValue : stockValue // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,
  ));
}


}

// dart format on
