import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/features/purchases/providers/purchase_providers.dart';
import 'package:inventry_mobile/features/sales/providers/sale_providers.dart';

/// Opening a form = a listener subscribing; leaving it = the listener
/// closing. After that, reopening must start from an empty form.
void main() {
  test('New Sale form starts empty each time it is opened', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final firstVisit = container.listen(createSaleControllerProvider, (_, _) {});
    container.read(createSaleControllerProvider.notifier)
      ..setCustomer('c1', 'Ravi')
      ..setSaleType(SaleType.direct)
      ..setDiscount(50);
    expect(container.read(createSaleControllerProvider).customerId, 'c1');
    firstVisit.close();
    await container.pump();

    final secondVisit = container.listen(createSaleControllerProvider, (_, _) {});
    final state = container.read(createSaleControllerProvider);
    expect(state.customerId, isNull);
    expect(state.saleType, isNull);
    expect(state.discountAmount, 0);
    expect(state.lines, isEmpty);
    secondVisit.close();
  });

  test('New Purchase form starts empty each time it is opened', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final firstVisit = container.listen(createPurchaseControllerProvider, (_, _) {});
    container.read(createPurchaseControllerProvider.notifier)
      ..setInvoiceNumber('INV-9')
      ..setDiscount(25);
    expect(container.read(createPurchaseControllerProvider).invoiceNumber, 'INV-9');
    firstVisit.close();
    await container.pump();

    final secondVisit = container.listen(createPurchaseControllerProvider, (_, _) {});
    final state = container.read(createPurchaseControllerProvider);
    expect(state.invoiceNumber, isNull);
    expect(state.discountAmount, 0);
    expect(state.lines, isEmpty);
    secondVisit.close();
  });
}
