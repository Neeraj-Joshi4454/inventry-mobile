import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import '../../sales/data/models/sale.dart';
import 'models/customer.dart';
import 'models/customer_sales_summary.dart';

class CustomerApi {
  CustomerApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Customer>> listCustomers({int page = 1, String? search}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/customers',
        queryParameters: {'page': page, 'limit': 20, if (search != null && search.isNotEmpty) 'search': search},
      );
      return PaginatedResponse.fromJson(response.data!, Customer.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Customer> getCustomer(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/customers/$id');
      return Customer.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Customer> createCustomer({
    required String name,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/customers',
        data: {'name': name, 'mobileNumber': ?mobileNumber, 'email': ?email, 'gstNumber': ?gstNumber, 'notes': ?notes},
      );
      return Customer.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Customer> updateCustomer(
    String id, {
    required String name,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/customers/$id',
        data: {'name': name, 'mobileNumber': ?mobileNumber, 'email': ?email, 'gstNumber': ?gstNumber, 'notes': ?notes},
      );
      return Customer.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Customer> setCustomerStatus(String id, bool isActive) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>('/customers/$id/status', data: {'isActive': isActive});
      return Customer.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({CustomerSalesSummary summary, PaginatedResponse<Sale> page})> getCustomerSalesHistory(
    String customerId, {
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/customers/$customerId/sales',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final sales = (data['sales'] as List<dynamic>).map((e) => Sale.fromJson(e as Map<String, dynamic>)).toList();
      return (
        summary: CustomerSalesSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: PaginatedResponse(
          items: sales,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
