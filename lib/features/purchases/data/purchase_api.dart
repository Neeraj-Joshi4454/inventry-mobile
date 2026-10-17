import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import 'models/purchase.dart';
import 'models/purchase_invoice.dart';
import 'models/purchase_item.dart';

class PurchaseLineItemRequest {
  const PurchaseLineItemRequest({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    this.taxRate = 0,
  });

  final String productId;
  final double quantity;
  final double unitPrice;
  final double taxRate;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'taxRate': taxRate,
    // The rate entered on the line excludes GST; GST is added on top.
    'isPriceInclusive': false,
  };
}

class PurchaseApi {
  PurchaseApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Purchase>> listPurchases({int page = 1}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/purchases', queryParameters: {'page': page, 'limit': 20});
      return PaginatedResponse.fromJson(response.data!, Purchase.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({Purchase purchase, List<PurchaseItem> items})> getPurchase(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/purchases/$id');
      final data = response.data!['data'] as Map<String, dynamic>;
      final purchase = Purchase.fromJson(data['purchase'] as Map<String, dynamic>);
      final items = (data['items'] as List<dynamic>)
          .map((e) => PurchaseItem.fromJson(e as Map<String, dynamic>))
          .toList();
      return (purchase: purchase, items: items);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> createPurchase({
    required String supplierId,
    String? invoiceNumber,
    required DateTime purchaseDate,
    required List<PurchaseLineItemRequest> items,
    double discountAmount = 0,
    String? notes,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/purchases',
        data: {
          'supplierId': supplierId,
          'invoiceNumber': ?invoiceNumber,
          'purchaseDate': purchaseDate.toIso8601String(),
          'discountAmount': discountAmount,
          'notes': ?notes,
          'items': items.map((e) => e.toJson()).toList(),
        },
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<PurchaseInvoice> getPurchaseInvoice(String purchaseId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/purchases/$purchaseId/invoice');
      return PurchaseInvoice.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
