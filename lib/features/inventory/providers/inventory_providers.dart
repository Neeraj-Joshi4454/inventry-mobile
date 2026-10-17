import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/inventory_api.dart';
import '../data/models/inventory_item.dart';
import '../data/models/inventory_transaction.dart';
import '../data/models/stock_status.dart';

final inventoryApiProvider = Provider<InventoryApi>((ref) => InventoryApi(ref.watch(dioProvider)));

// ---------------------------------------------------------------------------
// Inventory list (search + category + status filters, pagination)
// ---------------------------------------------------------------------------

class InventoryListState {
  const InventoryListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.categoryId,
    this.status,
    this.page = 1,
  });

  final List<InventoryItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String? categoryId;
  final StockStatus? status;
  final int page;

  InventoryListState copyWith({
    List<InventoryItem>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    Object? categoryId = _unset,
    Object? status = _unset,
    int? page,
  }) {
    return InventoryListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      categoryId: categoryId == _unset ? this.categoryId : categoryId as String?,
      status: status == _unset ? this.status : status as StockStatus?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class InventoryListNotifier extends Notifier<InventoryListState> {
  // Bumped on every refresh. Responses carrying an older number are
  // dropped, so a slow earlier search/filter request (or an in-flight
  // loadMore) can never overwrite results for the current filters.
  int _generation = 0;
  Timer? _searchDebounce;

  @override
  InventoryListState build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    Future.microtask(refresh);
    return const InventoryListState();
  }

  Future<void> refresh() async {
    final generation = ++_generation;
    state = state.copyWith(isLoading: true, isLoadingMore: false, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(inventoryApiProvider)
          .listInventory(page: 1, search: state.search, categoryId: state.categoryId, status: state.status);
      if (generation != _generation) return;
      state = state.copyWith(items: result.items, isLoading: false, hasMore: result.hasNextPage, page: 1);
    } on ApiException catch (e) {
      if (generation != _generation) return;
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    final generation = _generation;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final result = await ref
          .read(inventoryApiProvider)
          .listInventory(page: nextPage, search: state.search, categoryId: state.categoryId, status: state.status);
      if (generation != _generation) return;
      state = state.copyWith(
        items: [...state.items, ...result.items],
        isLoadingMore: false,
        hasMore: result.hasNextPage,
        page: nextPage,
      );
    } on ApiException catch (e) {
      if (generation != _generation) return;
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }

  /// Debounced: typing fires one request after a short pause, not one per keystroke.
  void setSearch(String value) {
    state = state.copyWith(search: value);
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), refresh);
  }

  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
    refresh();
  }

  void setStatus(StockStatus? status) {
    state = state.copyWith(status: status);
    refresh();
  }
}

final inventoryListProvider = NotifierProvider<InventoryListNotifier, InventoryListState>(InventoryListNotifier.new);

// ---------------------------------------------------------------------------
// Single product stock detail
// ---------------------------------------------------------------------------

final productStockDetailProvider = FutureProvider.family<InventoryItem, String>((ref, productId) {
  return ref.watch(inventoryApiProvider).getInventory(productId);
});

// ---------------------------------------------------------------------------
// Ledger (per product, with type + date-range filters, pagination)
// ---------------------------------------------------------------------------

class LedgerState {
  const LedgerState({
    this.productName,
    this.productSku,
    this.entries = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.type,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final String? productName;
  final String? productSku;
  final List<InventoryLedgerEntry> entries;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final InventoryTransactionType? type;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  LedgerState copyWith({
    String? productName,
    String? productSku,
    List<InventoryLedgerEntry>? entries,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? type = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return LedgerState(
      productName: productName ?? this.productName,
      productSku: productSku ?? this.productSku,
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      type: type == _unset ? this.type : type as InventoryTransactionType?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      page: page ?? this.page,
    );
  }
}

class LedgerNotifier extends FamilyNotifier<LedgerState, String> {
  late String productId;

  @override
  LedgerState build(String arg) {
    productId = arg;
    Future.microtask(refresh);
    return const LedgerState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(inventoryApiProvider)
          .listTransactions(productId, page: 1, type: state.type, fromDate: state.fromDate, toDate: state.toDate);
      state = state.copyWith(
        productName: result.productName,
        productSku: result.productSku,
        entries: result.page.items,
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
          .read(inventoryApiProvider)
          .listTransactions(
            productId,
            page: nextPage,
            type: state.type,
            fromDate: state.fromDate,
            toDate: state.toDate,
          );
      state = state.copyWith(
        entries: [...state.entries, ...result.page.items],
        isLoadingMore: false,
        hasMore: result.page.hasNextPage,
        page: nextPage,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }

  void setType(InventoryTransactionType? type) {
    state = state.copyWith(type: type);
    refresh();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(type: null, fromDate: null, toDate: null);
    refresh();
  }
}

final ledgerProvider = NotifierProvider.family<LedgerNotifier, LedgerState, String>(LedgerNotifier.new);

// ---------------------------------------------------------------------------
// Stock adjustment submission
// ---------------------------------------------------------------------------

class StockAdjustmentController extends AsyncNotifier<double?> {
  @override
  Future<double?> build() async => null;

  /// Returns the resulting stock on success (used by the confirmation
  /// screen), or null on failure — check `state.hasError` for the message.
  Future<double?> submit({
    required String productId,
    required String type,
    required double quantity,
    required String reason,
    String? notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(inventoryApiProvider)
          .createAdjustment(productId: productId, type: type, quantity: quantity, reason: reason, notes: notes),
    );
    if (!state.hasError) {
      ref.invalidate(inventoryListProvider);
      ref.invalidate(productStockDetailProvider(productId));
      ref.invalidate(ledgerProvider(productId));
    }
    return state.valueOrNull;
  }
}

final stockAdjustmentControllerProvider = AsyncNotifierProvider<StockAdjustmentController, double?>(
  StockAdjustmentController.new,
);
