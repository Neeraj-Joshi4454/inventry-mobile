import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import 'models/expense_category.dart';

class ExpenseCategoryApi {
  ExpenseCategoryApi(this._dio);

  final Dio _dio;

  Future<List<ExpenseCategory>> listCategories({String status = 'active'}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/expense-categories', queryParameters: {'status': status});
      final data = response.data!['data'] as List<dynamic>;
      return data.map((e) => ExpenseCategory.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ExpenseCategory> createCategory({required String name, String? description}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/expense-categories',
        data: {'name': name, 'description': ?description},
      );
      return ExpenseCategory.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ExpenseCategory> updateCategory(String id, {String? name, String? description}) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/expense-categories/$id',
        data: {'name': ?name, 'description': ?description},
      );
      return ExpenseCategory.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ExpenseCategory> setCategoryStatus(String id, bool isActive) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/expense-categories/$id/status',
        data: {'isActive': isActive},
      );
      return ExpenseCategory.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
