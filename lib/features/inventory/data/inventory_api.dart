import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/inventory_item.dart';
import 'models/inventory_transaction.dart';
import 'models/stock_status.dart';

class InventoryApi {
  InventoryApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<InventoryItem>> listInventory({
    int page = 1,
    String? search,
    String? categoryId,
    StockStatus? status,
    bool inStockOnly = false,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/inventory',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (search != null && search.isNotEmpty) 'search': search,
          'categoryId': ?categoryId,
          if (status != null) 'status': status.wireValue,
          if (inStockOnly) 'inStock': 'true',
        },
      );
      return PaginatedResponse.fromJson(response.data!, InventoryItem.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<InventoryItem> getInventory(String productId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/inventory/$productId');
      return InventoryItem.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({String productName, String productSku, PaginatedResponse<InventoryLedgerEntry> page})> listTransactions(
    String productId, {
    int page = 1,
    InventoryTransactionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/inventory/$productId/transactions',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (type != null) 'type': type.wireValue,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      final body = response.data!;
      final data = body['data'] as Map<String, dynamic>;
      final product = data['product'] as Map<String, dynamic>;
      final transactionsJson = data['transactions'] as List<dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;

      final entries = transactionsJson.map((e) => InventoryLedgerEntry.fromJson(e as Map<String, dynamic>)).toList();

      return (
        productName: product['name'] as String,
        productSku: product['sku'] as String,
        page: PaginatedResponse<InventoryLedgerEntry>(
          items: entries,
          page: (meta['page'] as num).toInt(),
          totalPages: (meta['totalPages'] as num).toInt(),
        ),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Returns the resulting stock so the confirmation screen can show it
  /// without a second round trip.
  Future<double> createAdjustment({
    required String productId,
    required String type, // 'IN' | 'OUT'
    required double quantity,
    required String reason,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/inventory/adjustments',
        data: {'productId': productId, 'type': type, 'quantity': quantity, 'reason': reason, 'notes': ?notes},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final inventory = data['inventory'] as Map<String, dynamic>;
      return (inventory['currentStock'] as num).toDouble();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
