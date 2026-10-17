import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../../inventory/providers/inventory_providers.dart';
import '../data/models/category.dart';
import '../data/models/product.dart';
import '../data/models/unit.dart';
import '../data/product_api.dart';

final productApiProvider = Provider<ProductApi>((ref) => ProductApi(ref.watch(dioProvider)));

final categoriesProvider = FutureProvider<List<ProductCategory>>((ref) {
  return ref.watch(productApiProvider).listCategories();
});

final unitsProvider = FutureProvider<List<ProductUnit>>((ref) {
  return ref.watch(productApiProvider).listUnits();
});

class ProductListState {
  const ProductListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.categoryId,
    this.page = 1,
  });

  final List<Product> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String? categoryId;
  final int page;

  ProductListState copyWith({
    List<Product>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    Object? categoryId = _unset,
    int? page,
  }) {
    return ProductListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      categoryId: categoryId == _unset ? this.categoryId : categoryId as String?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class ProductListNotifier extends Notifier<ProductListState> {
  // Bumped on every refresh. Responses carrying an older number are
  // dropped, so a slow earlier search/filter request (or an in-flight
  // loadMore) can never overwrite results for the current filters.
  int _generation = 0;
  Timer? _searchDebounce;

  @override
  ProductListState build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    Future.microtask(refresh);
    return const ProductListState();
  }

  Future<void> refresh() async {
    final generation = ++_generation;
    state = state.copyWith(isLoading: true, isLoadingMore: false, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(productApiProvider)
          .listProducts(page: 1, search: state.search, categoryId: state.categoryId);
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
          .read(productApiProvider)
          .listProducts(page: nextPage, search: state.search, categoryId: state.categoryId);
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
}

final productListProvider = NotifierProvider<ProductListNotifier, ProductListState>(ProductListNotifier.new);

// ---------------------------------------------------------------------------
// Add / Edit product form
// ---------------------------------------------------------------------------

class ProductFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Product?> create({
    required String name,
    required String sku,
    required String categoryId,
    required String unitId,
    required double lowStockThreshold,
    double? purchasePrice,
    double? sellingPrice,
    String? description,
    String? hsnCode,
  }) async {
    state = const AsyncLoading();
    Product? created;
    state = await AsyncValue.guard(() async {
      created = await ref
          .read(productApiProvider)
          .createProduct(
            name: name,
            sku: sku,
            categoryId: categoryId,
            unitId: unitId,
            lowStockThreshold: lowStockThreshold,
            purchasePrice: purchasePrice,
            sellingPrice: sellingPrice,
            description: description,
            hsnCode: hsnCode,
          );
    });
    if (!state.hasError) {
      ref.invalidate(productListProvider);
      // A brand-new product needs an Inventory row (currentStock: 0) that
      // the Inventory tab must show immediately — see inventory_providers.dart.
      ref.invalidate(inventoryListProvider);
    }
    return created;
  }

  Future<bool> editProduct(
    String id, {
    required String name,
    required String sku,
    required String categoryId,
    required String unitId,
    required double lowStockThreshold,
    double? purchasePrice,
    double? sellingPrice,
    String? description,
    String? hsnCode,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(productApiProvider)
          .updateProduct(
            id,
            name: name,
            sku: sku,
            categoryId: categoryId,
            unitId: unitId,
            lowStockThreshold: lowStockThreshold,
            purchasePrice: purchasePrice,
            sellingPrice: sellingPrice,
            description: description,
            hsnCode: hsnCode,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(productListProvider);
      ref.invalidate(inventoryListProvider);
      ref.invalidate(productStockDetailProvider(id));
    }
    return success;
  }
}

final productFormControllerProvider = AsyncNotifierProvider<ProductFormController, void>(ProductFormController.new);

// ---------------------------------------------------------------------------
// Inline "Add Category" / "Add Unit" (used from the Add Product form)
// ---------------------------------------------------------------------------

class CategoryFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<ProductCategory?> create(String name) async {
    state = const AsyncLoading();
    ProductCategory? created;
    state = await AsyncValue.guard(() async {
      created = await ref.read(productApiProvider).createCategory(name);
    });
    if (!state.hasError) {
      ref.invalidate(categoriesProvider);
    }
    return created;
  }
}

final categoryFormControllerProvider = AsyncNotifierProvider<CategoryFormController, void>(CategoryFormController.new);

class UnitFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<ProductUnit?> create({required String name, required String symbol}) async {
    state = const AsyncLoading();
    ProductUnit? created;
    state = await AsyncValue.guard(() async {
      created = await ref.read(productApiProvider).createUnit(name: name, symbol: symbol);
    });
    if (!state.hasError) {
      ref.invalidate(unitsProvider);
    }
    return created;
  }
}

final unitFormControllerProvider = AsyncNotifierProvider<UnitFormController, void>(UnitFormController.new);
