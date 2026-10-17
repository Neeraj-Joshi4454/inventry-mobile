import 'package:freezed_annotation/freezed_annotation.dart';

part 'outstanding_customers_report.freezed.dart';

@freezed
abstract class OutstandingCustomersSummary with _$OutstandingCustomersSummary {
  const factory OutstandingCustomersSummary({
    required int totalOutstandingCustomers,
    required double totalOutstandingAmount,
  }) = _OutstandingCustomersSummary;

  factory OutstandingCustomersSummary.fromJson(Map<String, dynamic> json) {
    return OutstandingCustomersSummary(
      totalOutstandingCustomers: (json['totalOutstandingCustomers'] as num).toInt(),
      totalOutstandingAmount: (json['totalOutstandingAmount'] as num).toDouble(),
    );
  }
}

@freezed
abstract class OutstandingCustomerRow with _$OutstandingCustomerRow {
  const factory OutstandingCustomerRow({
    required String customerId,
    required String customerName,
    String? mobileNumber,
    required double totalSales,
    required double paidAmount,
    required double outstandingAmount,
    DateTime? lastTransactionDate,
  }) = _OutstandingCustomerRow;

  factory OutstandingCustomerRow.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'] as Map<String, dynamic>?;
    return OutstandingCustomerRow(
      customerId: (customer?['id']).toString(),
      customerName: customer?['name'] as String? ?? 'Unknown',
      mobileNumber: customer?['mobileNumber'] as String?,
      totalSales: (json['totalSales'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      outstandingAmount: (json['outstandingAmount'] as num).toDouble(),
      lastTransactionDate: json['lastTransactionDate'] != null
          ? DateTime.parse(json['lastTransactionDate'] as String)
          : null,
    );
  }
}
