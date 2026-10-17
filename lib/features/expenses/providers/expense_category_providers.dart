import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/expense_category_api.dart';
import '../data/models/expense_category.dart';

final expenseCategoryApiProvider = Provider<ExpenseCategoryApi>((ref) => ExpenseCategoryApi(ref.watch(dioProvider)));

/// Full active-category list — used by the Add/Edit Expense screen's
/// category picker.
final activeExpenseCategoriesProvider = FutureProvider<List<ExpenseCategory>>((ref) async {
  return ref.watch(expenseCategoryApiProvider).listCategories(status: 'active');
});

// ---------------------------------------------------------------------------
// Expense categories management screen (list incl. inactive, status filter)
// ---------------------------------------------------------------------------

class ExpenseCategoryListState {
  const ExpenseCategoryListState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage,
    this.status = 'all',
  });

  final List<ExpenseCategory> items;
  final bool isLoading;
  final String? errorMessage;
  final String status;

  ExpenseCategoryListState copyWith({
    List<ExpenseCategory>? items,
    bool? isLoading,
    Object? errorMessage = _unset,
    String? status,
  }) {
    return ExpenseCategoryListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      status: status ?? this.status,
    );
  }
}

const _unset = Object();

class ExpenseCategoryListNotifier extends Notifier<ExpenseCategoryListState> {
  @override
  ExpenseCategoryListState build() {
    Future.microtask(refresh);
    return const ExpenseCategoryListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await ref.read(expenseCategoryApiProvider).listCategories(status: state.status);
      state = state.copyWith(items: items, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  void setStatusFilter(String status) {
    state = state.copyWith(status: status);
    refresh();
  }

  Future<bool> setActive(String id, bool isActive) async {
    try {
      await ref.read(expenseCategoryApiProvider).setCategoryStatus(id, isActive);
      await refresh();
      ref.invalidate(activeExpenseCategoriesProvider);
      return true;
    } on ApiException {
      return false;
    }
  }
}

final expenseCategoryListProvider = NotifierProvider<ExpenseCategoryListNotifier, ExpenseCategoryListState>(
  ExpenseCategoryListNotifier.new,
);

// ---------------------------------------------------------------------------
// Add / Edit category form — AsyncNotifier so the form screen can surface
// a real error message (e.g. duplicate name) rather than a flat bool.
// ---------------------------------------------------------------------------

class ExpenseCategoryFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> create({required String name, String? description}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(expenseCategoryApiProvider).createCategory(name: name, description: description),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(activeExpenseCategoriesProvider);
      ref.read(expenseCategoryListProvider.notifier).refresh();
    }
    return success;
  }

  Future<bool> editCategory(String id, {String? name, String? description}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(expenseCategoryApiProvider).updateCategory(id, name: name, description: description),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(activeExpenseCategoriesProvider);
      ref.read(expenseCategoryListProvider.notifier).refresh();
    }
    return success;
  }
}

final expenseCategoryFormControllerProvider = AsyncNotifierProvider<ExpenseCategoryFormController, void>(
  ExpenseCategoryFormController.new,
);
