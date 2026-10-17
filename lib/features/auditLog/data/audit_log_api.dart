import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/audit_log_entry.dart';

class AuditLogApi {
  AuditLogApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<AuditLogEntry>> listAuditLogs({int page = 1}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/audit-logs',
        queryParameters: {'page': page, 'limit': 20},
      );
      return PaginatedResponse.fromJson(response.data!, AuditLogEntry.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
