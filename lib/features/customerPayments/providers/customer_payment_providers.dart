import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../../customers/providers/customer_providers.dart';
import '../../sales/providers/sale_providers.dart';
import '../data/customer_payment_api.dart';
import '../data/models/customer_payment.dart';

final customerPaymentApiProvider = Provider<CustomerPaymentApi>((ref) => CustomerPaymentApi(ref.watch(dioProvider)));

// ---------------------------------------------------------------------------
// Add Payment form
// ---------------------------------------------------------------------------

class AddPaymentController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submit({
    required String saleId,
    required String customerId,
    required double amount,
    required String method,
    DateTime? paymentDate,
    String? referenceNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(customerPaymentApiProvider)
          .recordPayment(
            saleId: saleId,
            amount: amount,
            method: method,
            paymentDate: paymentDate,
            referenceNumber: referenceNumber,
            notes: notes,
          ),
    );
    final success = !state.hasError;
    if (success) {
      // Payments never touch inventory — only the sale's running totals and
      // the customer's outstanding balance change, so only those caches are
      // invalidated (contrast with sale/purchase submit(), which also
      // invalidates inventoryListProvider/ledgerProvider).
      ref.invalidate(saleDetailProvider(saleId));
      ref.invalidate(saleListProvider);
      if (customerId.isNotEmpty) {
        ref.invalidate(customerDetailProvider(customerId));
        ref.invalidate(customerSalesHistoryProvider(customerId));
        ref.invalidate(customerPaymentHistoryProvider(customerId));
      }
    }
    return success;
  }
}

final addPaymentControllerProvider = AsyncNotifierProvider<AddPaymentController, void>(AddPaymentController.new);

// ---------------------------------------------------------------------------
// Customer payment history (date + method filter, pagination)
// ---------------------------------------------------------------------------

class CustomerPaymentHistoryState {
  const CustomerPaymentHistoryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.method,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final List<CustomerPayment> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String? method;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  bool get hasActiveFilters => method != null || fromDate != null || toDate != null;

  CustomerPaymentHistoryState copyWith({
    List<CustomerPayment>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? method = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return CustomerPaymentHistoryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      method: method == _unset ? this.method : method as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class CustomerPaymentHistoryNotifier extends FamilyNotifier<CustomerPaymentHistoryState, String> {
  late String customerId;

  @override
  CustomerPaymentHistoryState build(String arg) {
    customerId = arg;
    Future.microtask(refresh);
    return const CustomerPaymentHistoryState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(customerPaymentApiProvider)
          .listPayments(
            page: 1,
            customerId: customerId,
            method: state.method,
            fromDate: state.fromDate,
            toDate: state.toDate,
          );
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
      final result = await ref
          .read(customerPaymentApiProvider)
          .listPayments(
            page: nextPage,
            customerId: customerId,
            method: state.method,
            fromDate: state.fromDate,
            toDate: state.toDate,
          );
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

  void setMethod(String? method) {
    state = state.copyWith(method: method);
    refresh();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(method: null, fromDate: null, toDate: null);
    refresh();
  }
}

final customerPaymentHistoryProvider =
    NotifierProvider.family<CustomerPaymentHistoryNotifier, CustomerPaymentHistoryState, String>(
      CustomerPaymentHistoryNotifier.new,
    );
