// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupplierAddress {

 String? get line1; String? get line2; String? get city; String? get state; String? get pincode;
/// Create a copy of SupplierAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplierAddressCopyWith<SupplierAddress> get copyWith => _$SupplierAddressCopyWithImpl<SupplierAddress>(this as SupplierAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupplierAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,pincode);

@override
String toString() {
  return 'SupplierAddress(line1: $line1, line2: $line2, city: $city, state: $state, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class $SupplierAddressCopyWith<$Res>  {
  factory $SupplierAddressCopyWith(SupplierAddress value, $Res Function(SupplierAddress) _then) = _$SupplierAddressCopyWithImpl;
@useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? pincode
});




}
/// @nodoc
class _$SupplierAddressCopyWithImpl<$Res>
    implements $SupplierAddressCopyWith<$Res> {
  _$SupplierAddressCopyWithImpl(this._self, this._then);

  final SupplierAddress _self;
  final $Res Function(SupplierAddress) _then;

/// Create a copy of SupplierAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line1 = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,}) {
  return _then(_self.copyWith(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupplierAddress].
extension SupplierAddressPatterns on SupplierAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupplierAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupplierAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupplierAddress value)  $default,){
final _that = this;
switch (_that) {
case _SupplierAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupplierAddress value)?  $default,){
final _that = this;
switch (_that) {
case _SupplierAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? line1,  String? line2,  String? city,  String? state,  String? pincode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupplierAddress() when $default != null:
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.pincode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? line1,  String? line2,  String? city,  String? state,  String? pincode)  $default,) {final _that = this;
switch (_that) {
case _SupplierAddress():
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.pincode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? line1,  String? line2,  String? city,  String? state,  String? pincode)?  $default,) {final _that = this;
switch (_that) {
case _SupplierAddress() when $default != null:
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.pincode);case _:
  return null;

}
}

}

/// @nodoc


class _SupplierAddress implements SupplierAddress {
  const _SupplierAddress({this.line1, this.line2, this.city, this.state, this.pincode});
  

@override final  String? line1;
@override final  String? line2;
@override final  String? city;
@override final  String? state;
@override final  String? pincode;

/// Create a copy of SupplierAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplierAddressCopyWith<_SupplierAddress> get copyWith => __$SupplierAddressCopyWithImpl<_SupplierAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupplierAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,pincode);

@override
String toString() {
  return 'SupplierAddress(line1: $line1, line2: $line2, city: $city, state: $state, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class _$SupplierAddressCopyWith<$Res> implements $SupplierAddressCopyWith<$Res> {
  factory _$SupplierAddressCopyWith(_SupplierAddress value, $Res Function(_SupplierAddress) _then) = __$SupplierAddressCopyWithImpl;
@override @useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? pincode
});




}
/// @nodoc
class __$SupplierAddressCopyWithImpl<$Res>
    implements _$SupplierAddressCopyWith<$Res> {
  __$SupplierAddressCopyWithImpl(this._self, this._then);

  final _SupplierAddress _self;
  final $Res Function(_SupplierAddress) _then;

/// Create a copy of SupplierAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,}) {
  return _then(_SupplierAddress(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Supplier {

 String get id; String get name; String? get contactPerson; String? get mobileNumber; String? get email; SupplierAddress? get address; String? get gstNumber; String? get notes; bool get isActive;
/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplierCopyWith<Supplier> get copyWith => _$SupplierCopyWithImpl<Supplier>(this as Supplier, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Supplier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contactPerson, contactPerson) || other.contactPerson == contactPerson)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,contactPerson,mobileNumber,email,address,gstNumber,notes,isActive);

@override
String toString() {
  return 'Supplier(id: $id, name: $name, contactPerson: $contactPerson, mobileNumber: $mobileNumber, email: $email, address: $address, gstNumber: $gstNumber, notes: $notes, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SupplierCopyWith<$Res>  {
  factory $SupplierCopyWith(Supplier value, $Res Function(Supplier) _then) = _$SupplierCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? contactPerson, String? mobileNumber, String? email, SupplierAddress? address, String? gstNumber, String? notes, bool isActive
});


$SupplierAddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$SupplierCopyWithImpl<$Res>
    implements $SupplierCopyWith<$Res> {
  _$SupplierCopyWithImpl(this._self, this._then);

  final Supplier _self;
  final $Res Function(Supplier) _then;

/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? contactPerson = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? address = freezed,Object? gstNumber = freezed,Object? notes = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contactPerson: freezed == contactPerson ? _self.contactPerson : contactPerson // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as SupplierAddress?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupplierAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $SupplierAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [Supplier].
extension SupplierPatterns on Supplier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Supplier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Supplier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Supplier value)  $default,){
final _that = this;
switch (_that) {
case _Supplier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Supplier value)?  $default,){
final _that = this;
switch (_that) {
case _Supplier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? contactPerson,  String? mobileNumber,  String? email,  SupplierAddress? address,  String? gstNumber,  String? notes,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Supplier() when $default != null:
return $default(_that.id,_that.name,_that.contactPerson,_that.mobileNumber,_that.email,_that.address,_that.gstNumber,_that.notes,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? contactPerson,  String? mobileNumber,  String? email,  SupplierAddress? address,  String? gstNumber,  String? notes,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _Supplier():
return $default(_that.id,_that.name,_that.contactPerson,_that.mobileNumber,_that.email,_that.address,_that.gstNumber,_that.notes,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? contactPerson,  String? mobileNumber,  String? email,  SupplierAddress? address,  String? gstNumber,  String? notes,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _Supplier() when $default != null:
return $default(_that.id,_that.name,_that.contactPerson,_that.mobileNumber,_that.email,_that.address,_that.gstNumber,_that.notes,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _Supplier implements Supplier {
  const _Supplier({required this.id, required this.name, this.contactPerson, this.mobileNumber, this.email, this.address, this.gstNumber, this.notes, required this.isActive});
  

@override final  String id;
@override final  String name;
@override final  String? contactPerson;
@override final  String? mobileNumber;
@override final  String? email;
@override final  SupplierAddress? address;
@override final  String? gstNumber;
@override final  String? notes;
@override final  bool isActive;

/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplierCopyWith<_Supplier> get copyWith => __$SupplierCopyWithImpl<_Supplier>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Supplier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contactPerson, contactPerson) || other.contactPerson == contactPerson)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,contactPerson,mobileNumber,email,address,gstNumber,notes,isActive);

@override
String toString() {
  return 'Supplier(id: $id, name: $name, contactPerson: $contactPerson, mobileNumber: $mobileNumber, email: $email, address: $address, gstNumber: $gstNumber, notes: $notes, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SupplierCopyWith<$Res> implements $SupplierCopyWith<$Res> {
  factory _$SupplierCopyWith(_Supplier value, $Res Function(_Supplier) _then) = __$SupplierCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? contactPerson, String? mobileNumber, String? email, SupplierAddress? address, String? gstNumber, String? notes, bool isActive
});


@override $SupplierAddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$SupplierCopyWithImpl<$Res>
    implements _$SupplierCopyWith<$Res> {
  __$SupplierCopyWithImpl(this._self, this._then);

  final _Supplier _self;
  final $Res Function(_Supplier) _then;

/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? contactPerson = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? address = freezed,Object? gstNumber = freezed,Object? notes = freezed,Object? isActive = null,}) {
  return _then(_Supplier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contactPerson: freezed == contactPerson ? _self.contactPerson : contactPerson // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as SupplierAddress?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Supplier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupplierAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $SupplierAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
