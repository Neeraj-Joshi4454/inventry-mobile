import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/features/bankDetails/data/bank_details.dart';
import 'package:inventry_mobile/features/bankDetails/data/bank_details_store.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  const details = BankDetails(
    accountHolderName: 'Joshi Building Materials',
    bankName: 'HDFC Bank',
    accountNumber: '50100123456789',
    ifsc: 'HDFC0001234',
    branch: 'Pune Camp',
  );

  test('IFSC format check', () {
    expect(BankDetails.ifscPattern.hasMatch('HDFC0001234'), isTrue);
    expect(BankDetails.ifscPattern.hasMatch('SBIN0ABC123'), isTrue);
    expect(BankDetails.ifscPattern.hasMatch('HDFC1001234'), isFalse); // 5th char must be 0
    expect(BankDetails.ifscPattern.hasMatch('HDF0001234'), isFalse); // too short
  });

  test('save, load and remove, kept separate per business', () async {
    final store = BankDetailsStore();
    expect(await store.load('tenantA'), isNull);

    await store.save('tenantA', details);
    final loaded = (await store.load('tenantA'))!;
    expect(loaded.accountNumber, '50100123456789');
    expect(loaded.ifsc, 'HDFC0001234');
    expect(loaded.branch, 'Pune Camp');
    expect(await store.load('tenantB'), isNull);

    await store.remove('tenantA');
    expect(await store.load('tenantA'), isNull);
  });
}
