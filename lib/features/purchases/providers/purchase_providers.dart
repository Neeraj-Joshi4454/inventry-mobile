import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../../inventory/providers/inventory_providers.dart';
import '../../suppliers/data/models/supplier.dart';
import '../data/models/purchase.dart';
import '../data/models/purchase_invoice.dart';
import '../data/models/purchase_item.dart';
import '../data/purchase_api.dart';

final purchaseApiProvider = Provider<PurchaseApi>((ref) => PurchaseApi(ref.watch(dioProvider)));

// ---------------------------------------------------------------------------
// Purchases list
// ---------------------------------------------------------------------------

class PurchaseListState {
  const PurchaseListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.page = 1,
  });

  final List<Purchase> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final int page;

  PurchaseListState copyWith({
    List<Purchase>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    int? page,
  }) {
    return PurchaseListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class PurchaseListNotifier extends Notifier<PurchaseListState> {
  @override
  PurchaseListState build() {
    Future.microtask(refresh);
    return const PurchaseListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref.read(purchaseApiProvider).listPurchases(page: 1);
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
      final result = await ref.read(purchaseApiProvider).listPurchases(page: nextPage);
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
}

final purchaseListProvider = NotifierProvider<PurchaseListNotifier, PurchaseListState>(PurchaseListNotifier.new);

// ---------------------------------------------------------------------------
// Purchase detail
// ---------------------------------------------------------------------------

final purchaseDetailProvider = FutureProvider.family<({Purchase purchase, List<PurchaseItem> items}), String>(
  (ref, id) => ref.watch(purchaseApiProvider).getPurchase(id),
);

final purchaseInvoiceProvider = FutureProvider.family<PurchaseInvoice, String>(
  (ref, id) => ref.watch(purchaseApiProvider).getPurchaseInvoice(id),
);

// ---------------------------------------------------------------------------
// Create Purchase form
// ---------------------------------------------------------------------------

class CreatePurchaseState {
  const CreatePurchaseState({
    this.supplier,
    this.invoiceNumber,
    DateTime? purchaseDate,
    this.lines = const [],
    this.discountAmount = 0,
    this.notes,
    this.isSubmitting = false,
    this.errorMessage,
  }) : _purchaseDate = purchaseDate;

  final Supplier? supplier;
  final String? invoiceNumber;
  final DateTime? _purchaseDate;
  final List<PurchaseLineDraft> lines;
  final double discountAmount;
  final String? notes;
  final bool isSubmitting;
  final String? errorMessage;

  DateTime get purchaseDate => _purchaseDate ?? DateTime.now();

  double get subTotal => lines.fold(0, (sum, line) => sum + line.lineSubTotal);
  double get taxAmount => lines.fold(0, (sum, line) => sum + line.lineTax);
  double get grandTotal => subTotal + taxAmount - discountAmount;

  bool get canSubmit => supplier != null && lines.isNotEmpty && lines.every((l) => l.isValid) && !isSubmitting;

  CreatePurchaseState copyWith({
    Object? supplier = _unset,
    Object? invoiceNumber = _unset,
    DateTime? purchaseDate,
    List<PurchaseLineDraft>? lines,
    double? discountAmount,
    Object? notes = _unset,
    bool? isSubmitting,
    Object? errorMessage = _unset,
  }) {
    return CreatePurchaseState(
      supplier: supplier == _unset ? this.supplier : supplier as Supplier?,
      invoiceNumber: invoiceNumber == _unset ? this.invoiceNumber : invoiceNumber as String?,
      purchaseDate: purchaseDate ?? _purchaseDate,
      lines: lines ?? this.lines,
      discountAmount: discountAmount ?? this.discountAmount,
      notes: notes == _unset ? this.notes : notes as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
    );
  }
}

class CreatePurchaseController extends AutoDisposeNotifier<CreatePurchaseState> {
  @override
  CreatePurchaseState build() => const CreatePurchaseState();

  void setSupplier(Supplier supplier) {
    state = state.copyWith(supplier: supplier);
  }

  void clearSupplier() {
    state = state.copyWith(supplier: null);
  }

  void setInvoiceNumber(String? invoiceNumber) {
    state = state.copyWith(invoiceNumber: invoiceNumber);
  }

  void setPurchaseDate(DateTime date) {
    state = state.copyWith(purchaseDate: date);
  }

  void setDiscount(double amount) {
    state = state.copyWith(discountAmount: amount);
  }

  void setNotes(String? notes) {
    state = state.copyWith(notes: notes);
  }

  void addLine(PurchaseLineDraft line) {
    if (state.lines.any((l) => l.productId == line.productId)) return;
    state = state.copyWith(lines: [...state.lines, line]);
  }

  void updateLine(int index, {double? quantity, double? unitPrice, double? taxRate}) {
    final lines = [...state.lines];
    final line = lines[index];
    if (quantity != null) line.quantity = quantity;
    if (unitPrice != null) line.unitPrice = unitPrice;
    if (taxRate != null) line.taxRate = taxRate;
    state = state.copyWith(lines: lines);
  }

  void removeLine(int index) {
    final lines = [...state.lines]..removeAt(index);
    state = state.copyWith(lines: lines);
  }

  void reset() {
    state = const CreatePurchaseState();
  }

  Future<bool> submit() async {
    if (!state.canSubmit) return false;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref
          .read(purchaseApiProvider)
          .createPurchase(
            supplierId: state.supplier!.id,
            invoiceNumber: state.invoiceNumber,
            purchaseDate: state.purchaseDate,
            discountAmount: state.discountAmount,
            notes: state.notes,
            items: state.lines
                .map(
                  (l) => PurchaseLineItemRequest(
                    productId: l.productId,
                    quantity: l.quantity!,
                    unitPrice: l.unitPrice!,
                    taxRate: l.taxRate,
                  ),
                )
                .toList(),
          );
      state = state.copyWith(isSubmitting: false);
      // Stock levels for these products just changed on the backend —
      // invalidate every cached view of them so the next read is fresh.
      ref.invalidate(inventoryListProvider);
      for (final line in state.lines) {
        ref.invalidate(productStockDetailProvider(line.productId));
        ref.invalidate(ledgerProvider(line.productId));
      }
      return true;
    } on ApiException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    }
  }
}

/// Auto-disposed: the form's state lives only while the New Purchase screen
/// is open, so every visit starts empty however the screen was reached.
final createPurchaseControllerProvider = NotifierProvider.autoDispose<CreatePurchaseController, CreatePurchaseState>(
  CreatePurchaseController.new,
);

// ---------------------------------------------------------------------------
// Purchase returns
// ---------------------------------------------------------------------------
