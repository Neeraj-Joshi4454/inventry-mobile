// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryLedgerEntry {

 String get id; InventoryTransactionType get type; double get quantity; double get previousStock; double get resultingStock; String get referenceType; String get referenceId; DateTime get createdAt; String? get notes; String? get reason;
/// Create a copy of InventoryLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryLedgerEntryCopyWith<InventoryLedgerEntry> get copyWith => _$InventoryLedgerEntryCopyWithImpl<InventoryLedgerEntry>(this as InventoryLedgerEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,quantity,previousStock,resultingStock,referenceType,referenceId,createdAt,notes,reason);

@override
String toString() {
  return 'InventoryLedgerEntry(id: $id, type: $type, quantity: $quantity, previousStock: $previousStock, resultingStock: $resultingStock, referenceType: $referenceType, referenceId: $referenceId, createdAt: $createdAt, notes: $notes, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $InventoryLedgerEntryCopyWith<$Res>  {
  factory $InventoryLedgerEntryCopyWith(InventoryLedgerEntry value, $Res Function(InventoryLedgerEntry) _then) = _$InventoryLedgerEntryCopyWithImpl;
@useResult
$Res call({
 String id, InventoryTransactionType type, double quantity, double previousStock, double resultingStock, String referenceType, String referenceId, DateTime createdAt, String? notes, String? reason
});




}
/// @nodoc
class _$InventoryLedgerEntryCopyWithImpl<$Res>
    implements $InventoryLedgerEntryCopyWith<$Res> {
  _$InventoryLedgerEntryCopyWithImpl(this._self, this._then);

  final InventoryLedgerEntry _self;
  final $Res Function(InventoryLedgerEntry) _then;

/// Create a copy of InventoryLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? quantity = null,Object? previousStock = null,Object? resultingStock = null,Object? referenceType = null,Object? referenceId = null,Object? createdAt = null,Object? notes = freezed,Object? reason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InventoryTransactionType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,previousStock: null == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double,resultingStock: null == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryLedgerEntry].
extension InventoryLedgerEntryPatterns on InventoryLedgerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryLedgerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryLedgerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryLedgerEntry value)  $default,){
final _that = this;
switch (_that) {
case _InventoryLedgerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryLedgerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryLedgerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InventoryTransactionType type,  double quantity,  double previousStock,  double resultingStock,  String referenceType,  String referenceId,  DateTime createdAt,  String? notes,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryLedgerEntry() when $default != null:
return $default(_that.id,_that.type,_that.quantity,_that.previousStock,_that.resultingStock,_that.referenceType,_that.referenceId,_that.createdAt,_that.notes,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InventoryTransactionType type,  double quantity,  double previousStock,  double resultingStock,  String referenceType,  String referenceId,  DateTime createdAt,  String? notes,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _InventoryLedgerEntry():
return $default(_that.id,_that.type,_that.quantity,_that.previousStock,_that.resultingStock,_that.referenceType,_that.referenceId,_that.createdAt,_that.notes,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InventoryTransactionType type,  double quantity,  double previousStock,  double resultingStock,  String referenceType,  String referenceId,  DateTime createdAt,  String? notes,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _InventoryLedgerEntry() when $default != null:
return $default(_that.id,_that.type,_that.quantity,_that.previousStock,_that.resultingStock,_that.referenceType,_that.referenceId,_that.createdAt,_that.notes,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryLedgerEntry implements InventoryLedgerEntry {
  const _InventoryLedgerEntry({required this.id, required this.type, required this.quantity, required this.previousStock, required this.resultingStock, required this.referenceType, required this.referenceId, required this.createdAt, this.notes, this.reason});
  

@override final  String id;
@override final  InventoryTransactionType type;
@override final  double quantity;
@override final  double previousStock;
@override final  double resultingStock;
@override final  String referenceType;
@override final  String referenceId;
@override final  DateTime createdAt;
@override final  String? notes;
@override final  String? reason;

/// Create a copy of InventoryLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryLedgerEntryCopyWith<_InventoryLedgerEntry> get copyWith => __$InventoryLedgerEntryCopyWithImpl<_InventoryLedgerEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.previousStock, previousStock) || other.previousStock == previousStock)&&(identical(other.resultingStock, resultingStock) || other.resultingStock == resultingStock)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,quantity,previousStock,resultingStock,referenceType,referenceId,createdAt,notes,reason);

@override
String toString() {
  return 'InventoryLedgerEntry(id: $id, type: $type, quantity: $quantity, previousStock: $previousStock, resultingStock: $resultingStock, referenceType: $referenceType, referenceId: $referenceId, createdAt: $createdAt, notes: $notes, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$InventoryLedgerEntryCopyWith<$Res> implements $InventoryLedgerEntryCopyWith<$Res> {
  factory _$InventoryLedgerEntryCopyWith(_InventoryLedgerEntry value, $Res Function(_InventoryLedgerEntry) _then) = __$InventoryLedgerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, InventoryTransactionType type, double quantity, double previousStock, double resultingStock, String referenceType, String referenceId, DateTime createdAt, String? notes, String? reason
});




}
/// @nodoc
class __$InventoryLedgerEntryCopyWithImpl<$Res>
    implements _$InventoryLedgerEntryCopyWith<$Res> {
  __$InventoryLedgerEntryCopyWithImpl(this._self, this._then);

  final _InventoryLedgerEntry _self;
  final $Res Function(_InventoryLedgerEntry) _then;

/// Create a copy of InventoryLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? quantity = null,Object? previousStock = null,Object? resultingStock = null,Object? referenceType = null,Object? referenceId = null,Object? createdAt = null,Object? notes = freezed,Object? reason = freezed,}) {
  return _then(_InventoryLedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InventoryTransactionType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,previousStock: null == previousStock ? _self.previousStock : previousStock // ignore: cast_nullable_to_non_nullable
as double,resultingStock: null == resultingStock ? _self.resultingStock : resultingStock // ignore: cast_nullable_to_non_nullable
as double,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
