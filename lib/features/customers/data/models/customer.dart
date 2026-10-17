import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

@freezed
abstract class CustomerAddress with _$CustomerAddress {
  const factory CustomerAddress({String? line1, String? line2, String? city, String? state, String? pincode}) =
      _CustomerAddress;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) {
    return CustomerAddress(
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
    );
  }
}

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String name,
    String? mobileNumber,
    String? email,
    CustomerAddress? address,
    String? gstNumber,
    String? notes,
    required bool isActive,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    return Customer(
      id: (json['_id'] ?? json['id']).toString(),
      name: json['name'] as String,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      address: address is Map ? CustomerAddress.fromJson(address as Map<String, dynamic>) : null,
      gstNumber: json['gstNumber'] as String?,
      notes: json['notes'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
