import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';

@freezed
abstract class SupplierAddress with _$SupplierAddress {
  const factory SupplierAddress({String? line1, String? line2, String? city, String? state, String? pincode}) =
      _SupplierAddress;

  factory SupplierAddress.fromJson(Map<String, dynamic> json) {
    return SupplierAddress(
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
    );
  }
}

/// The single Supplier model for the whole app — the Create Purchase
/// screen's supplier picker uses this same type (via suppliersProvider in
/// supplier_providers.dart), not a separate minimal one, so there is only
/// ever one source of truth for what a supplier is.
@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    required String id,
    required String name,
    String? contactPerson,
    String? mobileNumber,
    String? email,
    SupplierAddress? address,
    String? gstNumber,
    String? notes,
    required bool isActive,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    return Supplier(
      id: (json['_id'] ?? json['id']).toString(),
      name: json['name'] as String,
      contactPerson: json['contactPerson'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      address: address is Map ? SupplierAddress.fromJson(address as Map<String, dynamic>) : null,
      gstNumber: json['gstNumber'] as String?,
      notes: json['notes'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
