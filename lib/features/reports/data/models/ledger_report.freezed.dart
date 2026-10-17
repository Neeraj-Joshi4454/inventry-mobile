// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerReportSummary {

 double get totalIn; double get totalOut;
/// Create a copy of LedgerReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerReportSummaryCopyWith<LedgerReportSummary> get copyWith => _$LedgerReportSummaryCopyWithImpl<LedgerReportSummary>(this as LedgerReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerReportSummary&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut));
}


@override
int get hashCode => Object.hash(runtimeType,totalIn,totalOut);

@override
String toString() {
  return 'LedgerReportSummary(totalIn: $totalIn, totalOut: $totalOut)';
}


}

/// @nodoc
abstract mixin class $LedgerReportSummaryCopyWith<$Res>  {
  factory $LedgerReportSummaryCopyWith(LedgerReportSummary value, $Res Function(LedgerReportSummary) _then) = _$LedgerReportSummaryCopyWithImpl;
@useResult
$Res call({
 double totalIn, double totalOut
});




}
/// @nodoc
class _$LedgerReportSummaryCopyWithImpl<$Res>
    implements $LedgerReportSummaryCopyWith<$Res> {
  _$LedgerReportSummaryCopyWithImpl(this._self, this._then);

  final LedgerReportSummary _self;
  final $Res Function(LedgerReportSummary) _then;

/// Create a copy of LedgerReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalIn = null,Object? totalOut = null,}) {
  return _then(_self.copyWith(
totalIn: null == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as double,totalOut: null == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerReportSummary].
extension LedgerReportSummaryPatterns on LedgerReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _LedgerReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalIn,  double totalOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerReportSummary() when $default != null:
return $default(_that.totalIn,_that.totalOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalIn,  double totalOut)  $default,) {final _that = this;
switch (_that) {
case _LedgerReportSummary():
return $default(_that.totalIn,_that.totalOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalIn,  double totalOut)?  $default,) {final _that = this;
switch (_that) {
case _LedgerReportSummary() when $default != null:
return $default(_that.totalIn,_that.totalOut);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerReportSummary implements LedgerReportSummary {
  const _LedgerReportSummary({required this.totalIn, required this.totalOut});
  

@override final  double totalIn;
@override final  double totalOut;

/// Create a copy of LedgerReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerReportSummaryCopyWith<_LedgerReportSummary> get copyWith => __$LedgerReportSummaryCopyWithImpl<_LedgerReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerReportSummary&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut));
}


@override
int get hashCode => Object.hash(runtimeType,totalIn,totalOut);

@override
String toString() {
  return 'LedgerReportSummary(totalIn: $totalIn, totalOut: $totalOut)';
}


}

/// @nodoc
abstract mixin class _$LedgerReportSummaryCopyWith<$Res> implements $LedgerReportSummaryCopyWith<$Res> {
  factory _$LedgerReportSummaryCopyWith(_LedgerReportSummary value, $Res Function(_LedgerReportSummary) _then) = __$LedgerReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 double totalIn, double totalOut
});




}
/// @nodoc
class __$LedgerReportSummaryCopyWithImpl<$Res>
    implements _$LedgerReportSummaryCopyWith<$Res> {
  __$LedgerReportSummaryCopyWithImpl(this._self, this._then);

  final _LedgerReportSummary _self;
  final $Res Function(_LedgerReportSummary) _then;

/// Create a copy of LedgerReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalIn = null,Object? totalOut = null,}) {
  return _then(_LedgerReportSummary(
totalIn: null == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as double,totalOut: null == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$LedgerReportRow {

 String get id; InventoryTransactionType get type; String get productName; String get productSku; double get inQuantity; double get outQuantity; double get previousStock; double get resultingStock; String? get referenceNumber; String? get createdByName; String? get reason; DateTime get createdAt;
/// Create a copy of LedgerReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerReportRowCopyWith<LedgerReportRow> get copyWith => _$LedgerReportRowCopyWithImpl<LedgerReportRow>(this as LedgerReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.inQuantity, inQuantity) || other.inQuantity == inQuantity)&&(identical(other.outQuantity, outQuantity) || other.outQuantity == outQuantity)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,productName,productSku,inQuantity,outQuantity,previousStock,resultingStock,referenceNumber,createdByName,reason,createdAt);

@override
String toString() {
  return 'LedgerReportRow(id: $id, type: $type, productName: $productName, productSku: $productSku, inQuantity: $inQuantity, outQuantity: $outQuantity, previousStock: $previousStock, resultingStock: $resultingStock, referenceNumber: $referenceNumber, createdByName: $createdByName, reason: $reason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LedgerReportRowCopyWith<$Res>  {
  factory $LedgerReportRowCopyWith(LedgerReportRow value, $Res Function(LedgerReportRow) _then) = _$LedgerReportRowCopyWithImpl;
@useResult
$Res call({
 String id, InventoryTransactionType type, String productName, String productSku, double inQuantity, double outQuantity, double previousStock, double resultingStock, String? referenceNumber, String? createdByName, String? reason, DateTime createdAt
});




}
/// @nodoc
class _$LedgerReportRowCopyWithImpl<$Res>
    implements $LedgerReportRowCopyWith<$Res> {
  _$LedgerReportRowCopyWithImpl(this._self, this._then);

  final LedgerReportRow _self;
  final $Res Function(LedgerReportRow) _then;

/// Create a copy of LedgerReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? productName = null,Object? productSku = null,Object? inQuantity = null,Object? outQuantity = null,Object? previousStock = null,Object? resultingStock = null,Object? referenceNumber = freezed,Object? createdByName = freezed,Object? reason = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InventoryTransactionType,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productSku: null == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String,inQuantity: null == inQuantity ? _self.inQuantity : inQuantity // ignore: cast_nullable_to_non_nullable
as double,outQuantity: null == outQuantity ? _self.outQuantity : outQuantity // ignore: cast_nullable_to_non_nullable
as double,previousStock: null == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double,resultingStock: null == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerReportRow].
extension LedgerReportRowPatterns on LedgerReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerReportRow value)  $default,){
final _that = this;
switch (_that) {
case _LedgerReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InventoryTransactionType type,  String productName,  String productSku,  double inQuantity,  double outQuantity,  double previousStock,  double resultingStock,  String? referenceNumber,  String? createdByName,  String? reason,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerReportRow() when $default != null:
return $default(_that.id,_that.type,_that.productName,_that.productSku,_that.inQuantity,_that.outQuantity,_that.previousStock,_that.resultingStock,_that.referenceNumber,_that.createdByName,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InventoryTransactionType type,  String productName,  String productSku,  double inQuantity,  double outQuantity,  double previousStock,  double resultingStock,  String? referenceNumber,  String? createdByName,  String? reason,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LedgerReportRow():
return $default(_that.id,_that.type,_that.productName,_that.productSku,_that.inQuantity,_that.outQuantity,_that.previousStock,_that.resultingStock,_that.referenceNumber,_that.createdByName,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InventoryTransactionType type,  String productName,  String productSku,  double inQuantity,  double outQuantity,  double previousStock,  double resultingStock,  String? referenceNumber,  String? createdByName,  String? reason,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LedgerReportRow() when $default != null:
return $default(_that.id,_that.type,_that.productName,_that.productSku,_that.inQuantity,_that.outQuantity,_that.previousStock,_that.resultingStock,_that.referenceNumber,_that.createdByName,_that.reason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerReportRow implements LedgerReportRow {
  const _LedgerReportRow({required this.id, required this.type, required this.productName, required this.productSku, required this.inQuantity, required this.outQuantity, required this.previousStock, required this.resultingStock, this.referenceNumber, this.createdByName, this.reason, required this.createdAt});
  

@override final  String id;
@override final  InventoryTransactionType type;
@override final  String productName;
@override final  String productSku;
@override final  double inQuantity;
@override final  double outQuantity;
@override final  double previousStock;
@override final  double resultingStock;
@override final  String? referenceNumber;
@override final  String? createdByName;
@override final  String? reason;
@override final  DateTime createdAt;

/// Create a copy of LedgerReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerReportRowCopyWith<_LedgerReportRow> get copyWith => __$LedgerReportRowCopyWithImpl<_LedgerReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.inQuantity, inQuantity) || other.inQuantity == inQuantity)&&(identical(other.outQuantity, outQuantity) || other.outQuantity == outQuantity)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,productName,productSku,inQuantity,outQuantity,previousStock,resultingStock,referenceNumber,createdByName,reason,createdAt);

@override
String toString() {
  return 'LedgerReportRow(id: $id, type: $type, productName: $productName, productSku: $productSku, inQuantity: $inQuantity, outQuantity: $outQuantity, previousStock: $previousStock, resultingStock: $resultingStock, referenceNumber: $referenceNumber, createdByName: $createdByName, reason: $reason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LedgerReportRowCopyWith<$Res> implements $LedgerReportRowCopyWith<$Res> {
  factory _$LedgerReportRowCopyWith(_LedgerReportRow value, $Res Function(_LedgerReportRow) _then) = __$LedgerReportRowCopyWithImpl;
@override @useResult
$Res call({
 String id, InventoryTransactionType type, String productName, String productSku, double inQuantity, double outQuantity, double previousStock, double resultingStock, String? referenceNumber, String? createdByName, String? reason, DateTime createdAt
});




}
/// @nodoc
class __$LedgerReportRowCopyWithImpl<$Res>
    implements _$LedgerReportRowCopyWith<$Res> {
  __$LedgerReportRowCopyWithImpl(this._self, this._then);

  final _LedgerReportRow _self;
  final $Res Function(_LedgerReportRow) _then;

/// Create a copy of LedgerReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? productName = null,Object? productSku = null,Object? inQuantity = null,Object? outQuantity = null,Object? previousStock = null,Object? resultingStock = null,Object? referenceNumber = freezed,Object? createdByName = freezed,Object? reason = freezed,Object? createdAt = null,}) {
  return _then(_LedgerReportRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InventoryTransactionType,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productSku: null == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String,inQuantity: null == inQuantity ? _self.inQuantity : inQuantity // ignore: cast_nullable_to_non_nullable
as double,outQuantity: null == outQuantity ? _self.outQuantity : outQuantity // ignore: cast_nullable_to_non_nullable
as double,previousStock: null == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double,resultingStock: null == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
