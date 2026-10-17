import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import '../../customerPayments/data/models/customer_payment.dart';
import 'models/sale.dart';
import 'models/sale_invoice.dart';
import 'models/sale_item.dart';

class SaleLineItemRequest {
  const SaleLineItemRequest({
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

class SaleApi {
  SaleApi(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Sale>> listSales({
    int page = 1,
    String? search,
    String? customerId,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/sales',
        queryParameters: {
          'page': page,
          'limit': 20,
          if (search != null && search.isNotEmpty) 'search': search,
          'customerId': ?customerId,
          if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );
      return PaginatedResponse.fromJson(response.data!, Sale.fromJson);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({Sale sale, List<SaleItem> items, List<CustomerPayment> payments})> getSale(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/sales/$id');
      final data = response.data!['data'] as Map<String, dynamic>;
      final sale = Sale.fromJson(data['sale'] as Map<String, dynamic>);
      final items = (data['items'] as List<dynamic>).map((e) => SaleItem.fromJson(e as Map<String, dynamic>)).toList();
      final payments = (data['payments'] as List<dynamic>? ?? [])
          .map((e) => CustomerPayment.fromJson(e as Map<String, dynamic>))
          .toList();
      return (sale: sale, items: items, payments: payments);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<({String saleNumber, double totalAmount, double paidAmount, double dueAmount, String paymentStatus})>
  createSale({
    required String customerId,
    required DateTime saleDate,
    required List<SaleLineItemRequest> items,
    double discountAmount = 0,
    double paidAmount = 0,
    String? paymentMethod,
    String? paymentReference,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/sales',
        data: {
          'customerId': customerId,
          'saleDate': saleDate.toIso8601String(),
          'discountAmount': discountAmount,
          'paidAmount': paidAmount,
          'paymentMethod': ?paymentMethod,
          'paymentReference': ?paymentReference,
          'notes': ?notes,
          'items': items.map((e) => e.toJson()).toList(),
        },
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      return (
        saleNumber: data['saleNumber'] as String,
        totalAmount: (data['totalAmount'] as num).toDouble(),
        paidAmount: (data['paidAmount'] as num?)?.toDouble() ?? 0,
        dueAmount: (data['dueAmount'] as num?)?.toDouble() ?? 0,
        paymentStatus: data['paymentStatus'] as String? ?? 'CREDIT',
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<SaleInvoice> getSaleInvoice(String saleId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/sales/$saleId/invoice');
      return SaleInvoice.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
