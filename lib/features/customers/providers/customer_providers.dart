import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../../sales/data/models/sale.dart';
import '../data/customer_api.dart';
import '../data/models/customer.dart';
import '../data/models/customer_sales_summary.dart';

final customerApiProvider = Provider<CustomerApi>((ref) => CustomerApi(ref.watch(dioProvider)));

/// Full, unfiltered customer list — used by the Create Sale customer
/// picker, which needs every active customer up front rather than a
/// paginated feed.
final customersProvider = FutureProvider<List<Customer>>((ref) async {
  final result = await ref.watch(customerApiProvider).listCustomers();
  return result.items.where((c) => c.isActive).toList();
});

final customerDetailProvider = FutureProvider.family<Customer, String>((ref, id) {
  return ref.watch(customerApiProvider).getCustomer(id);
});

class CustomerListState {
  const CustomerListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.page = 1,
  });

  final List<Customer> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final int page;

  CustomerListState copyWith({
    List<Customer>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    int? page,
  }) {
    return CustomerListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class CustomerListNotifier extends Notifier<CustomerListState> {
  @override
  CustomerListState build() {
    Future.microtask(refresh);
    return const CustomerListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref.read(customerApiProvider).listCustomers(page: 1, search: state.search);
      state = state.copyWith(items: result.items, isLoading: false, hasMore: result.hasNextPage, page: 1);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final result = await ref.read(customerApiProvider).listCustomers(page: nextPage, search: state.search);
      state = state.copyWith(
        items: [...state.items, ...result.items],
        isLoadingMore: false,
        hasMore: result.hasNextPage,
        page: nextPage,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }

  void setSearch(String value) {
    state = state.copyWith(search: value);
    refresh();
  }

  Future<bool> setStatus(String customerId, bool isActive) async {
    try {
      await ref.read(customerApiProvider).setCustomerStatus(customerId, isActive);
      await refresh();
      return true;
    } on ApiException {
      return false;
    }
  }
}

final customerListProvider = NotifierProvider<CustomerListNotifier, CustomerListState>(CustomerListNotifier.new);

class CustomerFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Customer?> create({
    required String name,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    Customer? created;
    state = await AsyncValue.guard(() async {
      created = await ref
          .read(customerApiProvider)
          .createCustomer(name: name, mobileNumber: mobileNumber, email: email, gstNumber: gstNumber, notes: notes);
    });
    if (!state.hasError) {
      ref.invalidate(customersProvider);
      ref.invalidate(customerListProvider);
    }
    return created;
  }

  Future<bool> editCustomer(
    String id, {
    required String name,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(customerApiProvider)
          .updateCustomer(id, name: name, mobileNumber: mobileNumber, email: email, gstNumber: gstNumber, notes: notes),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(customersProvider);
      ref.invalidate(customerListProvider);
      ref.invalidate(customerDetailProvider(id));
    }
    return success;
  }
}

final customerFormControllerProvider = AsyncNotifierProvider<CustomerFormController, void>(CustomerFormController.new);

// ---------------------------------------------------------------------------
// Customer sales history (date-range filter, pagination) — total sold,
// total paid, total outstanding, last sale/payment, unpaid/partial count.
// ---------------------------------------------------------------------------

class CustomerSalesHistoryState {
  const CustomerSalesHistoryState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final CustomerSalesSummary? summary;
  final List<Sale> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  bool get hasActiveFilters => fromDate != null || toDate != null;

  CustomerSalesHistoryState copyWith({
    Object? summary = _unset,
    List<Sale>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return CustomerSalesHistoryState(
      summary: summary == _unset ? this.summary : summary as CustomerSalesSummary?,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      page: page ?? this.page,
    );
  }
}

class CustomerSalesHistoryNotifier extends FamilyNotifier<CustomerSalesHistoryState, String> {
  late String customerId;

  @override
  CustomerSalesHistoryState build(String arg) {
    customerId = arg;
    Future.microtask(refresh);
    return const CustomerSalesHistoryState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(customerApiProvider)
          .getCustomerSalesHistory(customerId, page: 1, fromDate: state.fromDate, toDate: state.toDate);
      state = state.copyWith(
        summary: result.summary,
        items: result.page.items,
        isLoading: false,
        hasMore: result.page.hasNextPage,
        page: 1,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final result = await ref
          .read(customerApiProvider)
          .getCustomerSalesHistory(customerId, page: nextPage, fromDate: state.fromDate, toDate: state.toDate);
      state = state.copyWith(
        items: [...state.items, ...result.page.items],
        isLoadingMore: false,
        hasMore: result.page.hasNextPage,
        page: nextPage,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(fromDate: null, toDate: null);
    refresh();
  }
}

final customerSalesHistoryProvider =
    NotifierProvider.family<CustomerSalesHistoryNotifier, CustomerSalesHistoryState, String>(
      CustomerSalesHistoryNotifier.new,
    );
