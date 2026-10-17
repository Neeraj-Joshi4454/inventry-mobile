import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import 'models/business_settings.dart';

class BusinessSettingsApi {
  BusinessSettingsApi(this._dio);

  final Dio _dio;

  Future<BusinessSettings> getSettings() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/business-settings');
      return BusinessSettings.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<BusinessSettings> updateSettings({
    String? businessName,
    String? ownerName,
    String? businessMobileNumber,
    String? email,
    String? gstNumber,
    Map<String, String?>? address,
    String? invoicePrefix,
    String? invoiceFooterNote,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/business-settings',
        data: {
          'businessName': ?businessName,
          'ownerName': ?ownerName,
          'businessMobileNumber': ?businessMobileNumber,
          'email': ?email,
          'gstNumber': ?gstNumber,
          'address': ?address,
          'invoicePrefix': ?invoicePrefix,
          'invoiceFooterNote': ?invoiceFooterNote,
        },
      );
      return BusinessSettings.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
