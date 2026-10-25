import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/customer_payment.dart';

class CustomerPaymentApi {
  CustomerPaymentApi(this._dio);

  final Dio _dio;

  Future<CustomerPayment> recordPayment({
    required String saleId,
    required double amount,
    required String method,
    DateTime? paymentDate,
    String? referenceNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/customer-payments',
        data: {
          'saleId': saleId,
          'amount': amount,
          'method': method,
          if (paymentDate != null) 'paymentDate': paymentDate.toIso8601String(),
          'referenceNumber': ?referenceNumber,
          'notes': ?notes,
        },
      );
      return CustomerPayment.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<PaginatedResponse<CustomerPayment>> listPayments({
    int page = 1,
    String? customerId,
    String? saleId,
    String? method,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/customer-payments',
        queryParameters: {
          'page': page,
          'limit': 20,
          'customerId': ?customerId,
          'saleId': ?saleId,
          'method': ?method,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      return PaginatedResponse.fromJson(response.data!, CustomerPayment.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<CustomerPayment> getPayment(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/customer-payments/$id');
      return CustomerPayment.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
