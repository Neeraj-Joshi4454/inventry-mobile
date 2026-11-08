import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/network/api_exception.dart';
import '../../bankDetails/data/bank_details.dart';

/// What the business has saved on the server (see backend
/// branding.service.ts::getBranding) — image timestamps only, no bytes.
class BrandingInfo {
  const BrandingInfo({this.imageUpdatedAt = const {}, this.bankDetails});

  /// Keyed by image kind ('upi_qr', 'business_logo'); absent = not set.
  final Map<String, DateTime> imageUpdatedAt;
  final BankDetails? bankDetails;

  factory BrandingInfo.fromJson(Map<String, dynamic> json) {
    DateTime? stamp(Object? image) =>
        image is Map && image['updatedAt'] != null ? DateTime.parse(image['updatedAt'] as String) : null;
    final bank = json['bankDetails'];
    return BrandingInfo(
      imageUpdatedAt: {'upi_qr': ?stamp(json['upiQr']), 'business_logo': ?stamp(json['businessLogo'])},
      bankDetails: bank is Map<String, dynamic> ? BankDetails.fromJson(bank) : null,
    );
  }
}

/// The business's UPI QR, logo and bank details on the server, so they're
/// the same on every phone and survive reinstalling the app.
class BrandingApi {
  BrandingApi(this._dio);

  final Dio _dio;

  static const _base = '/business-settings/branding';

  Future<BrandingInfo> getBranding() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(_base);
      return BrandingInfo.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Uint8List> downloadImage(String kind) async {
    try {
      final response = await _dio.get<List<int>>(
        '$_base/images/$kind',
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data!);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Uploads the image as the raw request body; returns the server's
  /// updatedAt for it.
  Future<DateTime> uploadImage(String kind, Uint8List bytes, String contentType) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_base/images/$kind',
        data: Stream.fromIterable([bytes]),
        options: Options(contentType: contentType, headers: {Headers.contentLengthHeader: bytes.length}),
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      return DateTime.parse(data['updatedAt'] as String);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteImage(String kind) async {
    try {
      await _dio.delete<void>('$_base/images/$kind');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> saveBankDetails(BankDetails details) async {
    try {
      await _dio.put<void>('$_base/bank-details', data: details.toJson());
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteBankDetails() async {
    try {
      await _dio.delete<void>('$_base/bank-details');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
