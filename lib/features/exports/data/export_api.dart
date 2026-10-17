import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';

class ExportApi {
  ExportApi(this._dio);

  final Dio _dio;

  Future<String> exportCsv(String type, {DateTime? fromDate, DateTime? toDate}) async {
    try {
      final response = await _dio.get<String>(
        '/exports/$type',
        queryParameters: {
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
        options: Options(responseType: ResponseType.plain),
      );
      return response.data ?? '';
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
