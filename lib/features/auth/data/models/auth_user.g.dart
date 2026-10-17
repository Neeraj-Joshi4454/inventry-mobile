// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTenant _$AuthTenantFromJson(Map<String, dynamic> json) =>
    _AuthTenant(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$AuthTenantToJson(_AuthTenant instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  name: json['name'] as String,
  mobileNumber: json['mobileNumber'] as String,
  role: json['role'] as String,
  tenant: json['tenant'] == null ? null : AuthTenant.fromJson(json['tenant'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'mobileNumber': instance.mobileNumber,
  'role': instance.role,
  'tenant': instance.tenant,
};
