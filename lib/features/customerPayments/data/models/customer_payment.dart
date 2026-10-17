import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_payment.freezed.dart';

@freezed
abstract class CustomerPayment with _$CustomerPayment {
  const factory CustomerPayment({
    required String id,
    required String customerId,
    String? customerName,
    required String saleId,
    String? saleNumber,
    required double amount,
    required String method,
    required DateTime paymentDate,
    String? referenceNumber,
    String? notes,
    String? recordedByName,
  }) = _CustomerPayment;

  factory CustomerPayment.fromJson(Map<String, dynamic> json) {
    final customer = json['customerId'];
    final sale = json['saleId'];
    final recordedBy = json['recordedBy'];
    return CustomerPayment(
      id: (json['_id'] ?? json['id']).toString(),
      customerId: customer is Map ? (customer['_id'] ?? customer['id']).toString() : customer.toString(),
      customerName: customer is Map ? customer['name'] as String? : null,
      saleId: sale is Map ? (sale['_id'] ?? sale['id']).toString() : sale.toString(),
      saleNumber: sale is Map ? sale['saleNumber'] as String? : null,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      referenceNumber: json['referenceNumber'] as String?,
      notes: json['notes'] as String?,
      recordedByName: recordedBy is Map ? recordedBy['name'] as String? : null,
    );
  }
}
