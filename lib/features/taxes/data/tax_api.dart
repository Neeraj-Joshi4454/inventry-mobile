import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import 'models/tax_config.dart';

class TaxApi {
  TaxApi(this._dio);

  final Dio _dio;

  Future<TaxConfig> getTaxConfig() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/taxes');
      return TaxConfig.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<TaxConfig> updateTaxConfig({
    bool? gstEnabled,
    String? gstin,
    String? state,
    double? defaultTaxRate,
    String? taxType,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/taxes',
        data: {
          'gstEnabled': ?gstEnabled,
          'gstin': ?gstin,
          'state': ?state,
          'defaultTaxRate': ?defaultTaxRate,
          'taxType': ?taxType,
        },
      );
      return TaxConfig.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
