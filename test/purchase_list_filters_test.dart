import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/core/network/paginated_response.dart';
import 'package:inventry_mobile/features/purchases/data/models/purchase.dart';
import 'package:inventry_mobile/features/purchases/data/purchase_api.dart';
import 'package:inventry_mobile/features/purchases/providers/purchase_providers.dart';

class _RecordingPurchaseApi extends PurchaseApi {
  _RecordingPurchaseApi() : super(Dio());

  final calls = <Map<String, Object?>>[];

  @override
  Future<PaginatedResponse<Purchase>> listPurchases({
    int page = 1,
    String? search,
    String? supplierId,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    calls.add({'page': page, 'search': search, 'supplierId': supplierId, 'fromDate': fromDate, 'toDate': toDate});
    return const PaginatedResponse(items: [], page: 1, totalPages: 1);
  }
}

void main() {
  late _RecordingPurchaseApi api;
  late ProviderContainer container;

  setUp(() {
    api = _RecordingPurchaseApi();
    container = ProviderContainer(overrides: [purchaseApiProvider.overrideWithValue(api)]);
  });

  tearDown(() => container.dispose());

  Future<PurchaseListNotifier> notifier() async {
    final n = container.read(purchaseListProvider.notifier);
    await Future<void>.delayed(Duration.zero); // initial refresh
    return n;
  }

  test('supplier and search filters are sent to the API', () async {
    final n = await notifier();
    n.setSupplier('s1');
    n.setSearch(' PO-0002 ');
    await Future<void>.delayed(Duration.zero);

    expect(api.calls.last, containsPair('supplierId', 's1'));
    expect(api.calls.last, containsPair('search', 'PO-0002'));
    expect(container.read(purchaseListProvider).hasActiveFilters, isTrue);
  });

  test('the date range includes the whole last day', () async {
    final n = await notifier();
    n.setDateRange(DateTime(2026, 10, 1), DateTime(2026, 10, 17));
    await Future<void>.delayed(Duration.zero);

    expect(api.calls.last['fromDate'], DateTime(2026, 10, 1));
    expect(api.calls.last['toDate'], DateTime(2026, 10, 17, 23, 59, 59, 999));
  });

  test('clearing removes supplier and dates but keeps the search', () async {
    final n = await notifier();
    n.setSearch('PO');
    n.setSupplier('s1');
    n.setDateRange(DateTime(2026, 10, 1), DateTime(2026, 10, 17));
    n.clearFilters();
    await Future<void>.delayed(Duration.zero);

    final state = container.read(purchaseListProvider);
    expect(state.hasActiveFilters, isFalse);
    expect(api.calls.last, {'page': 1, 'search': 'PO', 'supplierId': null, 'fromDate': null, 'toDate': null});
  });
}
