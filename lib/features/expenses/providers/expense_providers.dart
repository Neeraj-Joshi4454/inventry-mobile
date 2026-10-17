import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/expense_api.dart';
import '../data/models/expense.dart';
import '../data/models/expense_summary.dart';

final expenseApiProvider = Provider<ExpenseApi>((ref) => ExpenseApi(ref.watch(dioProvider)));

final expenseSummaryProvider = FutureProvider<ExpenseSummary>((ref) {
  return ref.watch(expenseApiProvider).getExpenseSummary();
});

final expenseDetailProvider = FutureProvider.family<Expense, String>((ref, id) {
  return ref.watch(expenseApiProvider).getExpense(id);
});

// ---------------------------------------------------------------------------
// Expense list (search + category/method/date filters, pagination)
// ---------------------------------------------------------------------------

class ExpenseListState {
  const ExpenseListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.categoryId,
    this.paymentMethod,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final List<Expense> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String? categoryId;
  final String? paymentMethod;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  bool get hasActiveFilters => categoryId != null || paymentMethod != null || fromDate != null || toDate != null;

  ExpenseListState copyWith({
    List<Expense>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    Object? categoryId = _unset,
    Object? paymentMethod = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return ExpenseListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      categoryId: categoryId == _unset ? this.categoryId : categoryId as String?,
      paymentMethod: paymentMethod == _unset ? this.paymentMethod : paymentMethod as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class ExpenseListNotifier extends Notifier<ExpenseListState> {
  @override
  ExpenseListState build() {
    Future.microtask(refresh);
    return const ExpenseListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(expenseApiProvider)
          .listExpenses(
            page: 1,
            search: state.search,
            categoryId: state.categoryId,
            paymentMethod: state.paymentMethod,
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
          .read(expenseApiProvider)
          .listExpenses(
            page: nextPage,
            search: state.search,
            categoryId: state.categoryId,
            paymentMethod: state.paymentMethod,
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

  void setSearch(String value) {
    state = state.copyWith(search: value);
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

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(categoryId: null, paymentMethod: null, fromDate: null, toDate: null);
    refresh();
  }
}

final expenseListProvider = NotifierProvider<ExpenseListNotifier, ExpenseListState>(ExpenseListNotifier.new);

// ---------------------------------------------------------------------------
// Add / Edit expense form
// ---------------------------------------------------------------------------

class ExpenseFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> create({
    required String title,
    required String categoryId,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    String? attachmentUrl,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(expenseApiProvider)
          .createExpense(
            title: title,
            categoryId: categoryId,
            amount: amount,
            expenseDate: expenseDate,
            paymentMethod: paymentMethod,
            referenceNumber: referenceNumber,
            notes: notes,
            attachmentUrl: attachmentUrl,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(expenseSummaryProvider);
      ref.read(expenseListProvider.notifier).refresh();
    }
    return success;
  }

  Future<bool> editExpense(
    String id, {
    required String title,
    required String categoryId,
    required double amount,
    required DateTime expenseDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    String? attachmentUrl,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(expenseApiProvider)
          .updateExpense(
            id,
            title: title,
            categoryId: categoryId,
            amount: amount,
            expenseDate: expenseDate,
            paymentMethod: paymentMethod,
            referenceNumber: referenceNumber,
            notes: notes,
            attachmentUrl: attachmentUrl,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(expenseSummaryProvider);
      ref.invalidate(expenseDetailProvider(id));
      ref.read(expenseListProvider.notifier).refresh();
    }
    return success;
  }

  Future<bool> setStatus(String id, String status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(expenseApiProvider).setExpenseStatus(id, status));
    final success = !state.hasError;
    if (success) {
      ref.invalidate(expenseSummaryProvider);
      ref.invalidate(expenseDetailProvider(id));
      ref.read(expenseListProvider.notifier).refresh();
    }
    return success;
  }
}

final expenseFormControllerProvider = AsyncNotifierProvider<ExpenseFormController, void>(ExpenseFormController.new);
