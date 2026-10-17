// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuditLogEntry {

 String get id; String get action; String get entityType; String get actorRole; DateTime get createdAt;
/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogEntryCopyWith<AuditLogEntry> get copyWith => _$AuditLogEntryCopyWithImpl<AuditLogEntry>(this as AuditLogEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.actorRole, actorRole) || other.actorRole == actorRole)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,entityType,actorRole,createdAt);

@override
String toString() {
  return 'AuditLogEntry(id: $id, action: $action, entityType: $entityType, actorRole: $actorRole, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditLogEntryCopyWith<$Res>  {
  factory $AuditLogEntryCopyWith(AuditLogEntry value, $Res Function(AuditLogEntry) _then) = _$AuditLogEntryCopyWithImpl;
@useResult
$Res call({
 String id, String action, String entityType, String actorRole, DateTime createdAt
});




}
/// @nodoc
class _$AuditLogEntryCopyWithImpl<$Res>
    implements $AuditLogEntryCopyWith<$Res> {
  _$AuditLogEntryCopyWithImpl(this._self, this._then);

  final AuditLogEntry _self;
  final $Res Function(AuditLogEntry) _then;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? entityType = null,Object? actorRole = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,actorRole: null == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogEntry].
extension AuditLogEntryPatterns on AuditLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  String entityType,  String actorRole,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
return $default(_that.id,_that.action,_that.entityType,_that.actorRole,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  String entityType,  String actorRole,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntry():
return $default(_that.id,_that.action,_that.entityType,_that.actorRole,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  String entityType,  String actorRole,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
return $default(_that.id,_that.action,_that.entityType,_that.actorRole,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _AuditLogEntry implements AuditLogEntry {
  const _AuditLogEntry({required this.id, required this.action, required this.entityType, required this.actorRole, required this.createdAt});
  

@override final  String id;
@override final  String action;
@override final  String entityType;
@override final  String actorRole;
@override final  DateTime createdAt;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogEntryCopyWith<_AuditLogEntry> get copyWith => __$AuditLogEntryCopyWithImpl<_AuditLogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.actorRole, actorRole) || other.actorRole == actorRole)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,entityType,actorRole,createdAt);

@override
String toString() {
  return 'AuditLogEntry(id: $id, action: $action, entityType: $entityType, actorRole: $actorRole, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogEntryCopyWith<$Res> implements $AuditLogEntryCopyWith<$Res> {
  factory _$AuditLogEntryCopyWith(_AuditLogEntry value, $Res Function(_AuditLogEntry) _then) = __$AuditLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, String entityType, String actorRole, DateTime createdAt
});




}
/// @nodoc
class __$AuditLogEntryCopyWithImpl<$Res>
    implements _$AuditLogEntryCopyWith<$Res> {
  __$AuditLogEntryCopyWithImpl(this._self, this._then);

  final _AuditLogEntry _self;
  final $Res Function(_AuditLogEntry) _then;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? entityType = null,Object? actorRole = null,Object? createdAt = null,}) {
  return _then(_AuditLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,actorRole: null == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
