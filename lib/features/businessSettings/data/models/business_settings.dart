import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_settings.freezed.dart';

@freezed
abstract class BusinessAddress with _$BusinessAddress {
  const factory BusinessAddress({String? line1, String? line2, String? city, String? state, String? pincode}) =
      _BusinessAddress;

  factory BusinessAddress.fromJson(Map<String, dynamic> json) {
    return BusinessAddress(
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
    );
  }
}

@freezed
abstract class BusinessSettings with _$BusinessSettings {
  const factory BusinessSettings({
    required String businessName,
    required String ownerName,
    required String mobileNumber,
    String? email,
    String? gstNumber,
    BusinessAddress? address,
    required String invoicePrefix,
    String? invoiceFooterNote,
  }) = _BusinessSettings;

  factory BusinessSettings.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    return BusinessSettings(
      businessName: json['businessName'] as String,
      ownerName: json['ownerName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String?,
      gstNumber: json['gstNumber'] as String?,
      address: address is Map ? BusinessAddress.fromJson(address as Map<String, dynamic>) : null,
      invoicePrefix: json['invoicePrefix'] as String? ?? 'INV',
      invoiceFooterNote: json['invoiceFooterNote'] as String?,
    );
  }
}
