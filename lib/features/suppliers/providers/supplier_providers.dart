import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../../purchases/data/models/purchase.dart';
import '../data/models/supplier.dart';
import '../data/models/supplier_purchase_history.dart';
import '../data/supplier_api.dart';

final supplierApiProvider = Provider<SupplierApi>((ref) => SupplierApi(ref.watch(dioProvider)));

/// Full, unfiltered active-supplier list — used by the Create Purchase
/// screen's supplier picker, which needs every active supplier up front
/// rather than a paginated feed. The single source of truth for "what is a
/// supplier" across the app — see supplier.dart's doc comment.
final suppliersProvider = FutureProvider<List<Supplier>>((ref) async {
  final result = await ref.watch(supplierApiProvider).listSuppliers(status: 'active');
  return result.items;
});

final supplierDetailProvider = FutureProvider.family<Supplier, String>((ref, id) {
  return ref.watch(supplierApiProvider).getSupplier(id);
});

const _unset = Object();

// ---------------------------------------------------------------------------
// Supplier list (search + active/inactive filter, pagination)
// ---------------------------------------------------------------------------

class SupplierListState {
  const SupplierListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.status = 'active',
    this.page = 1,
  });

  final List<Supplier> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String status;
  final int page;

  SupplierListState copyWith({
    List<Supplier>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    String? status,
    int? page,
  }) {
    return SupplierListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}

class SupplierListNotifier extends Notifier<SupplierListState> {
  @override
  SupplierListState build() {
    Future.microtask(refresh);
    return const SupplierListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(supplierApiProvider)
          .listSuppliers(page: 1, search: state.search, status: state.status);
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
          .read(supplierApiProvider)
          .listSuppliers(page: nextPage, search: state.search, status: state.status);
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

  void setStatusFilter(String status) {
    state = state.copyWith(status: status);
    refresh();
  }

  Future<bool> setActive(String supplierId, bool isActive) async {
    try {
      await ref.read(supplierApiProvider).setSupplierStatus(supplierId, isActive);
      await refresh();
      return true;
    } on ApiException {
      return false;
    }
  }
}

final supplierListProvider = NotifierProvider<SupplierListNotifier, SupplierListState>(SupplierListNotifier.new);

// ---------------------------------------------------------------------------
// Add / Edit supplier form
// ---------------------------------------------------------------------------

class SupplierFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Supplier?> create({
    required String name,
    String? contactPerson,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    Supplier? created;
    state = await AsyncValue.guard(() async {
      created = await ref
          .read(supplierApiProvider)
          .createSupplier(
            name: name,
            contactPerson: contactPerson,
            mobileNumber: mobileNumber,
            email: email,
            gstNumber: gstNumber,
            notes: notes,
          );
    });
    if (!state.hasError) {
      ref.invalidate(suppliersProvider);
      ref.invalidate(supplierListProvider);
    }
    return created;
  }

  Future<bool> editSupplier(
    String id, {
    required String name,
    String? contactPerson,
    String? mobileNumber,
    String? email,
    String? gstNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(supplierApiProvider)
          .updateSupplier(
            id,
            name: name,
            contactPerson: contactPerson,
            mobileNumber: mobileNumber,
            email: email,
            gstNumber: gstNumber,
            notes: notes,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(suppliersProvider);
      ref.invalidate(supplierListProvider);
      ref.invalidate(supplierDetailProvider(id));
    }
    return success;
  }
}

final supplierFormControllerProvider = AsyncNotifierProvider<SupplierFormController, void>(SupplierFormController.new);

// ---------------------------------------------------------------------------
// Supplier purchase history (date range filter, pagination)
// ---------------------------------------------------------------------------

class SupplierPurchaseHistoryState {
  const SupplierPurchaseHistoryState({
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

  final SupplierPurchaseSummary? summary;
  final List<Purchase> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  bool get hasActiveFilters => fromDate != null || toDate != null;

  SupplierPurchaseHistoryState copyWith({
    Object? summary = _unset,
    List<Purchase>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return SupplierPurchaseHistoryState(
      summary: summary == _unset ? this.summary : summary as SupplierPurchaseSummary?,
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

class SupplierPurchaseHistoryNotifier extends FamilyNotifier<SupplierPurchaseHistoryState, String> {
  late String supplierId;

  @override
  SupplierPurchaseHistoryState build(String arg) {
    supplierId = arg;
    Future.microtask(refresh);
    return const SupplierPurchaseHistoryState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(supplierApiProvider)
          .getSupplierPurchaseHistory(supplierId, page: 1, fromDate: state.fromDate, toDate: state.toDate);
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
          .read(supplierApiProvider)
          .getSupplierPurchaseHistory(supplierId, page: nextPage, fromDate: state.fromDate, toDate: state.toDate);
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

final supplierPurchaseHistoryProvider =
    NotifierProvider.family<SupplierPurchaseHistoryNotifier, SupplierPurchaseHistoryState, String>(
      SupplierPurchaseHistoryNotifier.new,
    );
