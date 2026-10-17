import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/category.dart';
import 'models/product.dart';
import 'models/unit.dart';

class ProductApi {
  ProductApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Product>> listProducts({int page = 1, String? search, String? categoryId}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/products',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (search != null && search.isNotEmpty) 'search': search,
          'categoryId': ?categoryId,
        },
      );
      return PaginatedResponse.fromJson(response.data!, Product.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Product> getProduct(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/products/$id');
      return Product.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Product> createProduct({
    required String name,
    required String sku,
    required String categoryId,
    required String unitId,
    required double lowStockThreshold,
    double? purchasePrice,
    double? sellingPrice,
    String? description,
    String? hsnCode,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/products',
        data: {
          'name': name,
          'sku': sku,
          'categoryId': categoryId,
          'unitId': unitId,
          'lowStockThreshold': lowStockThreshold,
          'purchasePrice': ?purchasePrice,
          'sellingPrice': ?sellingPrice,
          'description': ?description,
          'hsnCode': ?hsnCode,
        },
      );
      return Product.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Product> updateProduct(
    String id, {
    required String name,
    required String sku,
    required String categoryId,
    required String unitId,
    required double lowStockThreshold,
    double? purchasePrice,
    double? sellingPrice,
    String? description,
    String? hsnCode,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/products/$id',
        data: {
          'name': name,
          'sku': sku,
          'categoryId': categoryId,
          'unitId': unitId,
          'lowStockThreshold': lowStockThreshold,
          'purchasePrice': ?purchasePrice,
          'sellingPrice': ?sellingPrice,
          'description': ?description,
          'hsnCode': ?hsnCode,
        },
      );
      return Product.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<ProductCategory>> listCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/categories');
      final data = response.data!['data'] as List<dynamic>;
      return data.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ProductCategory> createCategory(String name) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>('/categories', data: {'name': name});
      return ProductCategory.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _dio.delete<Map<String, dynamic>>('/categories/$id');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<ProductUnit>> listUnits() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/units');
      final data = response.data!['data'] as List<dynamic>;
      return data.map((e) => ProductUnit.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ProductUnit> createUnit({required String name, required String symbol}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>('/units', data: {'name': name, 'symbol': symbol});
      return ProductUnit.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteUnit(String id) async {
    try {
      await _dio.delete<Map<String, dynamic>>('/units/$id');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
