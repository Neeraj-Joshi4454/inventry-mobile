import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/core/widgets/payment_section.dart';
import 'package:inventry_mobile/features/purchases/data/models/purchase_item.dart';
import 'package:inventry_mobile/features/purchases/providers/purchase_providers.dart';
import 'package:inventry_mobile/features/suppliers/data/models/supplier.dart';

/// A ready-to-submit purchase (supplier + one valid line, total ₹1,180 incl.
/// 18% GST) differing only in its payment choices.
CreatePurchaseState _purchase({PaymentType? type, double advance = 0, String mode = 'CASH', double discount = 0}) =>
    CreatePurchaseState(
      supplier: Supplier.fromJson(const {'_id': 's1', 'name': 'Shree Traders'}),
      lines: [
        PurchaseLineDraft(
          productId: 'p1',
          productName: 'Cement',
          unitSymbol: 'bag',
          currentStock: 0,
          quantity: 2,
          unitPrice: 500,
          taxRate: 18,
        ),
      ],
      discountAmount: discount,
      paymentType: type,
      advanceAmount: advance,
      paymentMode: mode,
    );

void main() {
  test('cannot save until the user picks direct or credit', () {
    expect(_purchase().canSubmit, isFalse);
    expect(_purchase(type: PaymentType.direct).canSubmit, isTrue);
    expect(_purchase(type: PaymentType.credit).canSubmit, isTrue);
  });

  test('direct purchase is paid in full in the chosen mode', () {
    final p = _purchase(type: PaymentType.direct, mode: 'BANK_TRANSFER');
    expect(p.paidAmount, closeTo(1180, 0.001));
    expect(p.paymentMethod, 'BANK_TRANSFER');
    expect(p.remainingAmount, 0);
    expect(p.previewPaymentStatus, 'PAID');
  });

  test('credit purchase without advance is UNPAID with the full amount due', () {
    final p = _purchase(type: PaymentType.credit, mode: 'UPI');
    expect(p.paidAmount, 0);
    expect(p.paymentMethod, 'CREDIT');
    expect(p.previewPaymentStatus, 'UNPAID');
    expect(p.remainingAmount, closeTo(1180, 0.001));
  });

  test('credit purchase with an advance is PARTIAL', () {
    final p = _purchase(type: PaymentType.credit, advance: 180, mode: 'UPI');
    expect(p.paymentMethod, 'UPI');
    expect(p.previewPaymentStatus, 'PARTIAL');
    expect(p.remainingAmount, closeTo(1000, 0.001));
  });

  test('discount is applied before GST, matching the backend total', () {
    final p = _purchase(type: PaymentType.direct, discount: 100);
    expect(p.grandTotal, closeTo(1062, 0.001));
    expect(p.paidAmount, closeTo(1062, 0.001));
  });
}
