import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import '../../purchases/data/models/purchase.dart';
import 'models/supplier.dart';
import 'models/supplier_purchase_history.dart';

class SupplierApi {
  SupplierApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Supplier>> listSuppliers({int page = 1, String? search, String status = 'active'}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/suppliers',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (search != null && search.isNotEmpty) 'search': search,
          'status': status,
        },
      );
      return PaginatedResponse.fromJson(response.data!, Supplier.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Supplier> getSupplier(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/suppliers/$id');
      return Supplier.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Supplier> createSupplier({
    required String name,
    String? contactPerson,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/suppliers',
        data: {
          'name': name,
          'contactPerson': ?contactPerson,
          'mobileNumber': ?mobileNumber,
          'email': ?email,
          'gstNumber': ?gstNumber,
          'notes': ?notes,
        },
      );
      return Supplier.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Supplier> updateSupplier(
    String id, {
    required String name,
    String? contactPerson,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/suppliers/$id',
        data: {
          'name': name,
          'contactPerson': ?contactPerson,
          'mobileNumber': ?mobileNumber,
          'email': ?email,
          'gstNumber': ?gstNumber,
          'notes': ?notes,
        },
      );
      return Supplier.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Supplier> setSupplierStatus(String id, bool isActive) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>('/suppliers/$id/status', data: {'isActive': isActive});
      return Supplier.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({SupplierPurchaseSummary summary, PaginatedResponse<Purchase> page})> getSupplierPurchaseHistory(
    String supplierId, {
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/suppliers/$supplierId/purchases',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final purchases = (data['purchases'] as List<dynamic>)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: SupplierPurchaseSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: PaginatedResponse<Purchase>(
          items: purchases,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
