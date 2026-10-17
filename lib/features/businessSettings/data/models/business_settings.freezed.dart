// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessAddress {

 String? get line1; String? get line2; String? get city; String? get state; String? get pincode;
/// Create a copy of BusinessAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessAddressCopyWith<BusinessAddress> get copyWith => _$BusinessAddressCopyWithImpl<BusinessAddress>(this as BusinessAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,pincode);

@override
String toString() {
  return 'BusinessAddress(line1: $line1, line2: $line2, city: $city, state: $state, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class $BusinessAddressCopyWith<$Res>  {
  factory $BusinessAddressCopyWith(BusinessAddress value, $Res Function(BusinessAddress) _then) = _$BusinessAddressCopyWithImpl;
@useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? pincode
});




}
/// @nodoc
class _$BusinessAddressCopyWithImpl<$Res>
    implements $BusinessAddressCopyWith<$Res> {
  _$BusinessAddressCopyWithImpl(this._self, this._then);

  final BusinessAddress _self;
  final $Res Function(BusinessAddress) _then;

/// Create a copy of BusinessAddress
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


/// Adds pattern-matching-related methods to [BusinessAddress].
extension BusinessAddressPatterns on BusinessAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessAddress value)  $default,){
final _that = this;
switch (_that) {
case _BusinessAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessAddress value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessAddress() when $default != null:
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
case _BusinessAddress() when $default != null:
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
case _BusinessAddress():
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
case _BusinessAddress() when $default != null:
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.pincode);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessAddress implements BusinessAddress {
  const _BusinessAddress({this.line1, this.line2, this.city, this.state, this.pincode});
  

@override final  String? line1;
@override final  String? line2;
@override final  String? city;
@override final  String? state;
@override final  String? pincode;

/// Create a copy of BusinessAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessAddressCopyWith<_BusinessAddress> get copyWith => __$BusinessAddressCopyWithImpl<_BusinessAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,pincode);

@override
String toString() {
  return 'BusinessAddress(line1: $line1, line2: $line2, city: $city, state: $state, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class _$BusinessAddressCopyWith<$Res> implements $BusinessAddressCopyWith<$Res> {
  factory _$BusinessAddressCopyWith(_BusinessAddress value, $Res Function(_BusinessAddress) _then) = __$BusinessAddressCopyWithImpl;
@override @useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? pincode
});




}
/// @nodoc
class __$BusinessAddressCopyWithImpl<$Res>
    implements _$BusinessAddressCopyWith<$Res> {
  __$BusinessAddressCopyWithImpl(this._self, this._then);

  final _BusinessAddress _self;
  final $Res Function(_BusinessAddress) _then;

/// Create a copy of BusinessAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,}) {
  return _then(_BusinessAddress(
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
mixin _$BusinessSettings {

 String get businessName; String get ownerName; String get mobileNumber; String? get email; String? get gstNumber; BusinessAddress? get address; String get invoicePrefix; String? get invoiceFooterNote;
/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessSettingsCopyWith<BusinessSettings> get copyWith => _$BusinessSettingsCopyWithImpl<BusinessSettings>(this as BusinessSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessSettings&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.invoicePrefix, invoicePrefix) || other.invoicePrefix == invoicePrefix)&&(identical(other.invoiceFooterNote, invoiceFooterNote) || other.invoiceFooterNote == invoiceFooterNote));
}


@override
int get hashCode => Object.hash(runtimeType,businessName,ownerName,mobileNumber,email,gstNumber,address,invoicePrefix,invoiceFooterNote);

@override
String toString() {
  return 'BusinessSettings(businessName: $businessName, ownerName: $ownerName, mobileNumber: $mobileNumber, email: $email, gstNumber: $gstNumber, address: $address, invoicePrefix: $invoicePrefix, invoiceFooterNote: $invoiceFooterNote)';
}


}

/// @nodoc
abstract mixin class $BusinessSettingsCopyWith<$Res>  {
  factory $BusinessSettingsCopyWith(BusinessSettings value, $Res Function(BusinessSettings) _then) = _$BusinessSettingsCopyWithImpl;
@useResult
$Res call({
 String businessName, String ownerName, String mobileNumber, String? email, String? gstNumber, BusinessAddress? address, String invoicePrefix, String? invoiceFooterNote
});


$BusinessAddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$BusinessSettingsCopyWithImpl<$Res>
    implements $BusinessSettingsCopyWith<$Res> {
  _$BusinessSettingsCopyWithImpl(this._self, this._then);

  final BusinessSettings _self;
  final $Res Function(BusinessSettings) _then;

/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessName = null,Object? ownerName = null,Object? mobileNumber = null,Object? email = freezed,Object? gstNumber = freezed,Object? address = freezed,Object? invoicePrefix = null,Object? invoiceFooterNote = freezed,}) {
  return _then(_self.copyWith(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as BusinessAddress?,invoicePrefix: null == invoicePrefix ? _self.invoicePrefix : invoicePrefix // ignore: cast_nullable_to_non_nullable
as String,invoiceFooterNote: freezed == invoiceFooterNote ? _self.invoiceFooterNote : invoiceFooterNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $BusinessAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [BusinessSettings].
extension BusinessSettingsPatterns on BusinessSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessSettings value)  $default,){
final _that = this;
switch (_that) {
case _BusinessSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String businessName,  String ownerName,  String mobileNumber,  String? email,  String? gstNumber,  BusinessAddress? address,  String invoicePrefix,  String? invoiceFooterNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessSettings() when $default != null:
return $default(_that.businessName,_that.ownerName,_that.mobileNumber,_that.email,_that.gstNumber,_that.address,_that.invoicePrefix,_that.invoiceFooterNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String businessName,  String ownerName,  String mobileNumber,  String? email,  String? gstNumber,  BusinessAddress? address,  String invoicePrefix,  String? invoiceFooterNote)  $default,) {final _that = this;
switch (_that) {
case _BusinessSettings():
return $default(_that.businessName,_that.ownerName,_that.mobileNumber,_that.email,_that.gstNumber,_that.address,_that.invoicePrefix,_that.invoiceFooterNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String businessName,  String ownerName,  String mobileNumber,  String? email,  String? gstNumber,  BusinessAddress? address,  String invoicePrefix,  String? invoiceFooterNote)?  $default,) {final _that = this;
switch (_that) {
case _BusinessSettings() when $default != null:
return $default(_that.businessName,_that.ownerName,_that.mobileNumber,_that.email,_that.gstNumber,_that.address,_that.invoicePrefix,_that.invoiceFooterNote);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessSettings implements BusinessSettings {
  const _BusinessSettings({required this.businessName, required this.ownerName, required this.mobileNumber, this.email, this.gstNumber, this.address, required this.invoicePrefix, this.invoiceFooterNote});
  

@override final  String businessName;
@override final  String ownerName;
@override final  String mobileNumber;
@override final  String? email;
@override final  String? gstNumber;
@override final  BusinessAddress? address;
@override final  String invoicePrefix;
@override final  String? invoiceFooterNote;

/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessSettingsCopyWith<_BusinessSettings> get copyWith => __$BusinessSettingsCopyWithImpl<_BusinessSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessSettings&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.invoicePrefix, invoicePrefix) || other.invoicePrefix == invoicePrefix)&&(identical(other.invoiceFooterNote, invoiceFooterNote) || other.invoiceFooterNote == invoiceFooterNote));
}


@override
int get hashCode => Object.hash(runtimeType,businessName,ownerName,mobileNumber,email,gstNumber,address,invoicePrefix,invoiceFooterNote);

@override
String toString() {
  return 'BusinessSettings(businessName: $businessName, ownerName: $ownerName, mobileNumber: $mobileNumber, email: $email, gstNumber: $gstNumber, address: $address, invoicePrefix: $invoicePrefix, invoiceFooterNote: $invoiceFooterNote)';
}


}

/// @nodoc
abstract mixin class _$BusinessSettingsCopyWith<$Res> implements $BusinessSettingsCopyWith<$Res> {
  factory _$BusinessSettingsCopyWith(_BusinessSettings value, $Res Function(_BusinessSettings) _then) = __$BusinessSettingsCopyWithImpl;
@override @useResult
$Res call({
 String businessName, String ownerName, String mobileNumber, String? email, String? gstNumber, BusinessAddress? address, String invoicePrefix, String? invoiceFooterNote
});


@override $BusinessAddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$BusinessSettingsCopyWithImpl<$Res>
    implements _$BusinessSettingsCopyWith<$Res> {
  __$BusinessSettingsCopyWithImpl(this._self, this._then);

  final _BusinessSettings _self;
  final $Res Function(_BusinessSettings) _then;

/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessName = null,Object? ownerName = null,Object? mobileNumber = null,Object? email = freezed,Object? gstNumber = freezed,Object? address = freezed,Object? invoicePrefix = null,Object? invoiceFooterNote = freezed,}) {
  return _then(_BusinessSettings(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as BusinessAddress?,invoicePrefix: null == invoicePrefix ? _self.invoicePrefix : invoicePrefix // ignore: cast_nullable_to_non_nullable
as String,invoiceFooterNote: freezed == invoiceFooterNote ? _self.invoiceFooterNote : invoiceFooterNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BusinessSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $BusinessAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
