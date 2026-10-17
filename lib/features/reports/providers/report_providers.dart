import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/models/dashboard_summary.dart';
import '../data/models/expense_report.dart';
import '../data/models/ledger_report.dart';
import '../data/models/outstanding_customers_report.dart';
import '../data/models/profit_summary.dart';
import '../data/models/purchase_report.dart';
import '../data/models/sales_report.dart';
import '../data/models/stock_report.dart';
import '../data/report_api.dart';

final reportApiProvider = Provider<ReportApi>((ref) => ReportApi(ref.watch(dioProvider)));

const _unset = Object();

// ---------------------------------------------------------------------------
// Dashboard summary
// ---------------------------------------------------------------------------

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) {
  return ref.watch(reportApiProvider).getDashboardSummary();
});

// ---------------------------------------------------------------------------
// Sales report
// ---------------------------------------------------------------------------

class SalesReportState {
  const SalesReportState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.fromDate,
    this.toDate,
    this.customerId,
    this.productId,
    this.page = 1,
  });

  final SalesReportSummary? summary;
  final List<SalesReportRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? customerId;
  final String? productId;
  final int page;

  SalesReportState copyWith({
    Object? summary = _unset,
    List<SalesReportRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    Object? customerId = _unset,
    Object? productId = _unset,
    int? page,
  }) {
    return SalesReportState(
      summary: summary == _unset ? this.summary : summary as SalesReportSummary?,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      customerId: customerId == _unset ? this.customerId : customerId as String?,
      productId: productId == _unset ? this.productId : productId as String?,
      page: page ?? this.page,
    );
  }

  bool get hasActiveFilters => fromDate != null || toDate != null || customerId != null || productId != null;
}

class SalesReportNotifier extends Notifier<SalesReportState> {
  @override
  SalesReportState build() {
    Future.microtask(refresh);
    return const SalesReportState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(reportApiProvider)
          .getSalesReport(
            page: 1,
            fromDate: state.fromDate,
            toDate: state.toDate,
            customerId: state.customerId,
            productId: state.productId,
          );
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
          .read(reportApiProvider)
          .getSalesReport(
            page: nextPage,
            fromDate: state.fromDate,
            toDate: state.toDate,
            customerId: state.customerId,
            productId: state.productId,
          );
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

  void setCustomer(String? customerId) {
    state = state.copyWith(customerId: customerId);
    refresh();
  }

  void setProduct(String? productId) {
    state = state.copyWith(productId: productId);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(fromDate: null, toDate: null, customerId: null, productId: null);
    refresh();
  }
}

final salesReportProvider = NotifierProvider<SalesReportNotifier, SalesReportState>(SalesReportNotifier.new);

// ---------------------------------------------------------------------------
// Purchase report
// ---------------------------------------------------------------------------

class PurchaseReportState {
  const PurchaseReportState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.fromDate,
    this.toDate,
    this.supplierId,
    this.productId,
    this.page = 1,
  });

  final PurchaseReportSummary? summary;
  final List<PurchaseReportRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? supplierId;
  final String? productId;
  final int page;

  PurchaseReportState copyWith({
    Object? summary = _unset,
    List<PurchaseReportRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    Object? supplierId = _unset,
    Object? productId = _unset,
    int? page,
  }) {
    return PurchaseReportState(
      summary: summary == _unset ? this.summary : summary as PurchaseReportSummary?,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      supplierId: supplierId == _unset ? this.supplierId : supplierId as String?,
      productId: productId == _unset ? this.productId : productId as String?,
      page: page ?? this.page,
    );
  }

  bool get hasActiveFilters => fromDate != null || toDate != null || supplierId != null || productId != null;
}

class PurchaseReportNotifier extends Notifier<PurchaseReportState> {
  @override
  PurchaseReportState build() {
    Future.microtask(refresh);
    return const PurchaseReportState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(reportApiProvider)
          .getPurchaseReport(
            page: 1,
            fromDate: state.fromDate,
            toDate: state.toDate,
            supplierId: state.supplierId,
            productId: state.productId,
          );
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
          .read(reportApiProvider)
          .getPurchaseReport(
            page: nextPage,
            fromDate: state.fromDate,
            toDate: state.toDate,
            supplierId: state.supplierId,
            productId: state.productId,
          );
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

  void setSupplier(String? supplierId) {
    state = state.copyWith(supplierId: supplierId);
    refresh();
  }

  void setProduct(String? productId) {
    state = state.copyWith(productId: productId);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(fromDate: null, toDate: null, supplierId: null, productId: null);
    refresh();
  }
}

final purchaseReportProvider = NotifierProvider<PurchaseReportNotifier, PurchaseReportState>(
  PurchaseReportNotifier.new,
);

// ---------------------------------------------------------------------------
// Stock report
// ---------------------------------------------------------------------------

class StockReportState {
  const StockReportState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.categoryId,
    this.status,
    this.search = '',
    this.page = 1,
  });

  final StockReportSummary? summary;
  final List<StockReportRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String? categoryId;
  final String? status;
  final String search;
  final int page;

  StockReportState copyWith({
    Object? summary = _unset,
    List<StockReportRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? categoryId = _unset,
    Object? status = _unset,
    String? search,
    int? page,
  }) {
    return StockReportState(
      summary: summary == _unset ? this.summary : summary as StockReportSummary?,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      categoryId: categoryId == _unset ? this.categoryId : categoryId as String?,
      status: status == _unset ? this.status : status as String?,
      search: search ?? this.search,
      page: page ?? this.page,
    );
  }
}

class StockReportNotifier extends Notifier<StockReportState> {
  @override
  StockReportState build() {
    Future.microtask(refresh);
    return const StockReportState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(reportApiProvider)
          .getStockReport(page: 1, categoryId: state.categoryId, status: state.status, search: state.search);
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
          .read(reportApiProvider)
          .getStockReport(page: nextPage, categoryId: state.categoryId, status: state.status, search: state.search);
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

  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
    refresh();
  }

  void setStatus(String? status) {
    state = state.copyWith(status: status);
    refresh();
  }

  void setSearch(String value) {
    state = state.copyWith(search: value);
    refresh();
  }
}

final stockReportProvider = NotifierProvider<StockReportNotifier, StockReportState>(StockReportNotifier.new);

// ---------------------------------------------------------------------------
// Inventory ledger report
// ---------------------------------------------------------------------------

class LedgerReportState {
  const LedgerReportState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.fromDate,
    this.toDate,
    this.productId,
    this.type,
    this.page = 1,
  });

  final LedgerReportSummary? summary;
  final List<LedgerReportRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? productId;
  final String? type;
  final int page;

  LedgerReportState copyWith({
    Object? summary = _unset,
    List<LedgerReportRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    Object? productId = _unset,
    Object? type = _unset,
    int? page,
  }) {
    return LedgerReportState(
      summary: summary == _unset ? this.summary : summary as LedgerReportSummary?,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      productId: productId == _unset ? this.productId : productId as String?,
      type: type == _unset ? this.type : type as String?,
      page: page ?? this.page,
    );
  }

  bool get hasActiveFilters => fromDate != null || toDate != null || productId != null || type != null;
}

class LedgerReportNotifier extends Notifier<LedgerReportState> {
  @override
  LedgerReportState build() {
    Future.microtask(refresh);
    return const LedgerReportState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(reportApiProvider)
          .getInventoryLedgerReport(
            page: 1,
            fromDate: state.fromDate,
            toDate: state.toDate,
            productId: state.productId,
            type: state.type,
          );
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
          .read(reportApiProvider)
          .getInventoryLedgerReport(
            page: nextPage,
            fromDate: state.fromDate,
            toDate: state.toDate,
            productId: state.productId,
            type: state.type,
          );
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

  void setProduct(String? productId) {
    state = state.copyWith(productId: productId);
    refresh();
  }

  void setType(String? type) {
    state = state.copyWith(type: type);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(fromDate: null, toDate: null, productId: null, type: null);
    refresh();
  }
}

final ledgerReportProvider = NotifierProvider<LedgerReportNotifier, LedgerReportState>(LedgerReportNotifier.new);

// ---------------------------------------------------------------------------
// Profit summary
// ---------------------------------------------------------------------------

class ProfitSummaryState {
  const ProfitSummaryState({this.data, this.isLoading = false, this.errorMessage, this.fromDate, this.toDate});

  final ProfitSummary? data;
  final bool isLoading;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;

  ProfitSummaryState copyWith({
    Object? data = _unset,
    bool? isLoading,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
  }) {
    return ProfitSummaryState(
      data: data == _unset ? this.data : data as ProfitSummary?,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
    );
  }
}

class ProfitSummaryNotifier extends Notifier<ProfitSummaryState> {
  @override
  ProfitSummaryState build() {
    Future.microtask(refresh);
    return const ProfitSummaryState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await ref.read(reportApiProvider).getProfitSummary(fromDate: state.fromDate, toDate: state.toDate);
      state = state.copyWith(data: result, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
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

final profitSummaryProvider = NotifierProvider<ProfitSummaryNotifier, ProfitSummaryState>(ProfitSummaryNotifier.new);

// ---------------------------------------------------------------------------
// Outstanding customers report (search + pagination)
// ---------------------------------------------------------------------------

class OutstandingCustomersState {
  const OutstandingCustomersState({
    this.summary,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.page = 1,
  });

  final OutstandingCustomersSummary? summary;
  final List<OutstandingCustomerRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final int page;

  OutstandingCustomersState copyWith({
    Object? summary = _unset,
    List<OutstandingCustomerRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    int? page,
  }) {
    return OutstandingCustomersState(
      summary: summary == _unset ? this.summary : summary as OutstandingCustomersSummary?,
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

class OutstandingCustomersNotifier extends Notifier<OutstandingCustomersState> {
  @override
  OutstandingCustomersState build() {
    Future.microtask(refresh);
    return const OutstandingCustomersState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref.read(reportApiProvider).getOutstandingCustomersReport(page: 1, search: state.search);
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
          .read(reportApiProvider)
          .getOutstandingCustomersReport(page: nextPage, search: state.search);
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

  void setSearch(String value) {
    state = state.copyWith(search: value);
    refresh();
  }
}

final outstandingCustomersProvider = NotifierProvider<OutstandingCustomersNotifier, OutstandingCustomersState>(
  OutstandingCustomersNotifier.new,
);

// ---------------------------------------------------------------------------
// Expense report (category + payment-method + date range filters, pagination)
// ---------------------------------------------------------------------------

class ExpenseReportState {
  const ExpenseReportState({
    this.summary,
    this.categoryBreakdown = const [],
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.fromDate,
    this.toDate,
    this.categoryId,
    this.paymentMethod,
    this.page = 1,
  });

  final ExpenseReportSummary? summary;
  final List<ExpenseCategoryBreakdown> categoryBreakdown;
  final List<ExpenseReportRow> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? categoryId;
  final String? paymentMethod;
  final int page;

  bool get hasActiveFilters => fromDate != null || toDate != null || categoryId != null || paymentMethod != null;

  ExpenseReportState copyWith({
    Object? summary = _unset,
    List<ExpenseCategoryBreakdown>? categoryBreakdown,
    List<ExpenseReportRow>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    Object? categoryId = _unset,
    Object? paymentMethod = _unset,
    int? page,
  }) {
    return ExpenseReportState(
      summary: summary == _unset ? this.summary : summary as ExpenseReportSummary?,
      categoryBreakdown: categoryBreakdown ?? this.categoryBreakdown,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      categoryId: categoryId == _unset ? this.categoryId : categoryId as String?,
      paymentMethod: paymentMethod == _unset ? this.paymentMethod : paymentMethod as String?,
      page: page ?? this.page,
    );
  }
}

class ExpenseReportNotifier extends Notifier<ExpenseReportState> {
  @override
  ExpenseReportState build() {
    Future.microtask(refresh);
    return const ExpenseReportState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(reportApiProvider)
          .getExpenseReport(
            page: 1,
            fromDate: state.fromDate,
            toDate: state.toDate,
            categoryId: state.categoryId,
            paymentMethod: state.paymentMethod,
          );
      state = state.copyWith(
        summary: result.summary,
        categoryBreakdown: result.categoryBreakdown,
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
          .read(reportApiProvider)
          .getExpenseReport(
            page: nextPage,
            fromDate: state.fromDate,
            toDate: state.toDate,
            categoryId: state.categoryId,
            paymentMethod: state.paymentMethod,
          );
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

  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
    refresh();
  }

  void setPaymentMethod(String? paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(fromDate: null, toDate: null, categoryId: null, paymentMethod: null);
    refresh();
  }
}

final expenseReportProvider = NotifierProvider<ExpenseReportNotifier, ExpenseReportState>(ExpenseReportNotifier.new);
