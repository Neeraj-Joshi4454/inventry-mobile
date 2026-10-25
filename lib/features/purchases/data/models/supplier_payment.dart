import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_payment.freezed.dart';

/// One payment made to a supplier against a purchase — the purchase-side
/// twin of CustomerPayment (see backend supplierPayment.model.ts).
@freezed
abstract class SupplierPayment with _$SupplierPayment {
  const factory SupplierPayment({
    required String id,
    required String purchaseId,
    required double amount,
    required String method,
    required DateTime paymentDate,
    String? referenceNumber,
    String? notes,
    String? recordedByName,
  }) = _SupplierPayment;

  factory SupplierPayment.fromJson(Map<String, dynamic> json) {
    final purchase = json['purchaseId'];
    final recordedBy = json['recordedBy'];
    return SupplierPayment(
      id: (json['_id'] ?? json['id']).toString(),
      purchaseId: purchase is Map ? (purchase['_id'] ?? purchase['id']).toString() : purchase.toString(),
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      referenceNumber: json['referenceNumber'] as String?,
      notes: json['notes'] as String?,
      recordedByName: recordedBy is Map ? recordedBy['name'] as String? : null,
    );
  }
}
