import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import 'models/dashboard_summary.dart';
import 'models/expense_report.dart';
import 'models/ledger_report.dart';
import 'models/outstanding_customers_report.dart';
import 'models/profit_summary.dart';
import 'models/purchase_report.dart';
import 'models/sales_report.dart';
import 'models/stock_report.dart';

class ReportPage<T> {
  const ReportPage({required this.items, required this.page, required this.totalPages});

  final List<T> items;
  final int page;
  final int totalPages;

  bool get hasNextPage => page < totalPages;
}

class ReportApi {
  ReportApi(this._dio);

  final Dio _dio;

  Future<DashboardSummary> getDashboardSummary() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/reports/dashboard');
      return DashboardSummary.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({SalesReportSummary summary, ReportPage<SalesReportRow> page})> getSalesReport({
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
    String? customerId,
    String? productId,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/sales',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
          'customerId': ?customerId,
          'productId': ?productId,
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['sales'] as List<dynamic>)
          .map((e) => SalesReportRow.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: SalesReportSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({PurchaseReportSummary summary, ReportPage<PurchaseReportRow> page})> getPurchaseReport({
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
    String? supplierId,
    String? productId,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/purchases',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
          'supplierId': ?supplierId,
          'productId': ?productId,
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['purchases'] as List<dynamic>)
          .map((e) => PurchaseReportRow.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: PurchaseReportSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({StockReportSummary summary, ReportPage<StockReportRow> page})> getStockReport({
    int page = 1,
    String? categoryId,
    String? status,
    String? search,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/stock',
        queryParameters: {
          'page': page,
          'limit': 20,
          'categoryId': ?categoryId,
          'status': ?status,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['items'] as List<dynamic>)
          .map((e) => StockReportRow.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: StockReportSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({LedgerReportSummary summary, ReportPage<LedgerReportRow> page})> getInventoryLedgerReport({
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
    String? productId,
    String? type,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/inventory-ledger',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
          'productId': ?productId,
          'type': ?type,
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['transactions'] as List<dynamic>)
          .map((e) => LedgerReportRow.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: LedgerReportSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({OutstandingCustomersSummary summary, ReportPage<OutstandingCustomerRow> page})>
  getOutstandingCustomersReport({int page = 1, String? search}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/outstanding-customers',
        queryParameters: {'page': page, 'limit': 20, if (search != null && search.isNotEmpty) 'search': search},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['items'] as List<dynamic>)
          .map((e) => OutstandingCustomerRow.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: OutstandingCustomersSummary.fromJson(data['summary'] as Map<String, dynamic>),
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<
    ({
      ExpenseReportSummary summary,
      List<ExpenseCategoryBreakdown> categoryBreakdown,
      ReportPage<ExpenseReportRow> page,
    })
  >
  getExpenseReport({
    int page = 1,
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    String? paymentMethod,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/expenses',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
          'categoryId': ?categoryId,
          'paymentMethod': ?paymentMethod,
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;
      final rows = (data['expenses'] as List<dynamic>)
          .map((e) => ExpenseReportRow.fromJson(e as Map<String, dynamic>))
          .toList();
      final breakdown = (data['categoryBreakdown'] as List<dynamic>)
          .map((e) => ExpenseCategoryBreakdown.fromJson(e as Map<String, dynamic>))
          .toList();
      return (
        summary: ExpenseReportSummary.fromJson(data['summary'] as Map<String, dynamic>),
        categoryBreakdown: breakdown,
        page: ReportPage(
          items: rows,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ProfitSummary> getProfitSummary({DateTime? fromDate, DateTime? toDate}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/reports/profit',
        queryParameters: {
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      return ProfitSummary.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
