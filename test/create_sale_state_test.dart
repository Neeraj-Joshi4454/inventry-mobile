import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/features/sales/data/models/sale_item.dart';
import 'package:inventry_mobile/features/sales/providers/sale_providers.dart';

/// A ready-to-submit sale (customer + one valid line, total ₹1,180 incl.
/// 18% GST) differing only in its payment choices.
CreateSaleState _sale({SaleType? type, double advance = 0, String mode = 'CASH'}) => CreateSaleState(
  customerId: 'c1',
  customerName: 'Ravi',
  lines: [
    SaleLineDraft(
      productId: 'p1',
      productName: 'Cement',
      unitSymbol: 'bag',
      availableStock: 50,
      quantity: 2,
      unitPrice: 500,
      taxRate: 18,
    ),
  ],
  saleType: type,
  advanceAmount: advance,
  paymentMode: mode,
);

void main() {
  test('cannot submit until the user picks direct or credit', () {
    expect(_sale().canSubmit, isFalse);
    expect(_sale(type: SaleType.direct).canSubmit, isTrue);
    expect(_sale(type: SaleType.credit).canSubmit, isTrue);
  });

  test('direct sale is paid in full in the chosen mode', () {
    final sale = _sale(type: SaleType.direct, mode: 'UPI');
    expect(sale.grandTotal, closeTo(1180, 0.001));
    expect(sale.paidAmount, closeTo(1180, 0.001));
    expect(sale.remainingAmount, 0);
    expect(sale.paymentMethod, 'UPI');
    expect(sale.previewPaymentStatus, 'PAID');
  });

  test('credit sale without advance is sent as CREDIT with the full amount due', () {
    final sale = _sale(type: SaleType.credit, mode: 'UPI');
    expect(sale.paidAmount, 0);
    expect(sale.paymentMethod, 'CREDIT');
    expect(sale.remainingAmount, closeTo(1180, 0.001));
    expect(sale.previewPaymentStatus, 'CREDIT');
  });

  test('credit sale with an advance records it in the chosen mode', () {
    final sale = _sale(type: SaleType.credit, advance: 200, mode: 'BANK_TRANSFER');
    expect(sale.paidAmount, 200);
    expect(sale.paymentMethod, 'BANK_TRANSFER');
    expect(sale.remainingAmount, closeTo(980, 0.001));
    expect(sale.previewPaymentStatus, 'PARTIAL');
  });

  test('an advance above the grand total blocks submission', () {
    final sale = _sale(type: SaleType.credit, advance: 5000);
    expect(sale.advanceExceedsTotal, isTrue);
    expect(sale.canSubmit, isFalse);
  });
}
