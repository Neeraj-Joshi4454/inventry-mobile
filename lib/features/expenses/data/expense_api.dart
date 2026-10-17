import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/expense.dart';
import 'models/expense_summary.dart';

class ExpenseApi {
  ExpenseApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Expense>> listExpenses({
    int page = 1,
    String? search,
    String? categoryId,
    String? paymentMethod,
    DateTime? fromDate,
    DateTime? toDate,
    String? status,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/expenses',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (search != null && search.isNotEmpty) 'search': search,
          'categoryId': ?categoryId,
          'paymentMethod': ?paymentMethod,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
          'status': ?status,
        },
      );
      return PaginatedResponse.fromJson(response.data!, Expense.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Expense> getExpense(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/expenses/$id');
      return Expense.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Expense> createExpense({
    required String title,
    required String categoryId,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    String? attachmentUrl,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/expenses',
        data: {
          'title': title,
          'categoryId': categoryId,
          'amount': amount,
          'expenseDate': expenseDate.toIso8601String(),
          'paymentMethod': paymentMethod,
          'referenceNumber': ?referenceNumber,
          'notes': ?notes,
          'attachmentUrl': ?attachmentUrl,
        },
      );
      return Expense.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Expense> updateExpense(
    String id, {
    required String title,
    required String categoryId,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    String? attachmentUrl,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/expenses/$id',
        data: {
          'title': title,
          'categoryId': categoryId,
          'amount': amount,
          'expenseDate': expenseDate.toIso8601String(),
          'paymentMethod': paymentMethod,
          'referenceNumber': ?referenceNumber,
          'notes': ?notes,
          'attachmentUrl': ?attachmentUrl,
        },
      );
      return Expense.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Expense> setExpenseStatus(String id, String status) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>('/expenses/$id/status', data: {'status': status});
      return Expense.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ExpenseSummary> getExpenseSummary() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/expenses/summary');
      return ExpenseSummary.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
