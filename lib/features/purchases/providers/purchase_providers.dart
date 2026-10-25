import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/paginated_response.dart';
import '../../../core/utils/document_totals.dart';
import '../../../core/widgets/payment_section.dart';
import '../../taxes/data/models/tax_config.dart';
import '../../taxes/providers/tax_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../../inventory/providers/inventory_providers.dart';
import '../../suppliers/data/models/supplier.dart';
import '../../suppliers/providers/supplier_providers.dart';
import '../data/models/purchase.dart';
import '../data/models/purchase_invoice.dart';
import '../data/models/purchase_item.dart';
import '../data/models/supplier_payment.dart';
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
    this.search = '',
    this.supplierId,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final List<Purchase> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String? supplierId;
  final DateTime? fromDate;

  /// Inclusive: the end of the chosen last day (see setDateRange).
  final DateTime? toDate;
  final int page;

  bool get hasActiveFilters => supplierId != null || fromDate != null || toDate != null;

  PurchaseListState copyWith({
    List<Purchase>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    Object? supplierId = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return PurchaseListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      supplierId: supplierId == _unset ? this.supplierId : supplierId as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
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
      final result = await _fetch(page: 1);
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
      final result = await _fetch(page: nextPage);
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

  Future<PaginatedResponse<Purchase>> _fetch({required int page}) => ref
      .read(purchaseApiProvider)
      .listPurchases(
        page: page,
        search: state.search,
        supplierId: state.supplierId,
        fromDate: state.fromDate,
        toDate: state.toDate,
      );

  void setSearch(String value) {
    state = state.copyWith(search: value.trim());
    refresh();
  }

  void setSupplier(String? supplierId) {
    state = state.copyWith(supplierId: supplierId);
    refresh();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to == null ? null : endOfDay(to));
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(supplierId: null, fromDate: null, toDate: null);
    refresh();
  }
}

final purchaseListProvider = NotifierProvider<PurchaseListNotifier, PurchaseListState>(PurchaseListNotifier.new);

/// The end of [day] — a date-range picker returns midnight at the *start*
/// of the last day, which as an inclusive upper bound would drop everything
/// recorded later that day.
DateTime endOfDay(DateTime day) => DateTime(day.year, day.month, day.day, 23, 59, 59, 999);

// ---------------------------------------------------------------------------
// Purchase detail
// ---------------------------------------------------------------------------

final purchaseDetailProvider =
    FutureProvider.family<({Purchase purchase, List<PurchaseItem> items, List<SupplierPayment> payments}), String>(
      (ref, id) => ref.watch(purchaseApiProvider).getPurchase(id),
    );

// ---------------------------------------------------------------------------
// Pay supplier (settle an outstanding purchase)
// ---------------------------------------------------------------------------

class SupplierPaymentController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submit({
    required String purchaseId,
    String? supplierId,
    required double amount,
    required String method,
    DateTime? paymentDate,
    String? referenceNumber,
    String? notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(purchaseApiProvider)
          .recordSupplierPayment(
            purchaseId: purchaseId,
            amount: amount,
            method: method,
            paymentDate: paymentDate,
            referenceNumber: referenceNumber,
            notes: notes,
          ),
    );
    final success = !state.hasError;
    if (success) {
      // Payments never touch inventory — only the purchase's paid/due totals
      // and the supplier's outstanding balance move.
      ref.invalidate(purchaseDetailProvider(purchaseId));
      ref.invalidate(purchaseListProvider);
      if (supplierId != null) {
        ref.invalidate(supplierDetailProvider(supplierId));
        ref.invalidate(supplierPurchaseHistoryProvider(supplierId));
      }
    }
    return success;
  }
}

final supplierPaymentControllerProvider = AsyncNotifierProvider<SupplierPaymentController, void>(
  SupplierPaymentController.new,
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
    this.paymentType,
    this.paymentMode = 'CASH',
    this.advanceAmount = 0,
    this.paymentReference,
    this.notes,
    this.isSubmitting = false,
    this.errorMessage,
    this.gstEnabled = true,
  }) : _purchaseDate = purchaseDate;

  final Supplier? supplier;
  final String? invoiceNumber;
  final DateTime? _purchaseDate;
  final List<PurchaseLineDraft> lines;
  final double discountAmount;

  /// Paid to the supplier in full now (direct) or later (credit).
  final PaymentType? paymentType;
  final String paymentMode;
  final double advanceAmount;
  final String? paymentReference;
  final String? notes;
  final bool isSubmitting;
  final String? errorMessage;

  /// The tenant's GST switch (false also for taxType NO_TAX) — when off the
  /// backend ignores every line's taxRate.
  final bool gstEnabled;

  DateTime get purchaseDate => _purchaseDate ?? DateTime.now();

  DocumentTotals get _totals => computeDocumentTotals(
    [for (final l in lines) (quantity: l.quantity ?? 0, unitPrice: l.unitPrice ?? 0, taxRate: l.taxRate)],
    discountAmount: discountAmount,
    gstEnabled: gstEnabled,
  );

  double get subTotal => _totals.subTotal;
  double get effectiveDiscount => _totals.discount;
  double get taxAmount => _totals.tax;
  double get grandTotal => _totals.total;

  double get paidAmount => paidNow(paymentType, grandTotal: grandTotal, advance: advanceAmount);

  /// The mode the supplier was paid in, or CREDIT when nothing was paid.
  String get paymentMethod => paidAmount > 0 ? paymentMode : 'CREDIT';

  double get remainingAmount => (grandTotal - paidAmount).clamp(0, double.infinity);

  /// Mirrors purchase.service.ts::createPurchase's status logic.
  String get previewPaymentStatus =>
      previewStatusFor(paid: paidAmount, remaining: remainingAmount, unpaidStatus: 'UNPAID');

  bool get advanceExceedsTotal => paymentType == PaymentType.credit && advanceAmount > grandTotal + 0.005;

  bool get canSubmit =>
      supplier != null &&
      lines.isNotEmpty &&
      lines.every((l) => l.isValid) &&
      paymentType != null &&
      !advanceExceedsTotal &&
      !isSubmitting;

  CreatePurchaseState copyWith({
    Object? supplier = _unset,
    Object? invoiceNumber = _unset,
    DateTime? purchaseDate,
    List<PurchaseLineDraft>? lines,
    double? discountAmount,
    Object? paymentType = _unset,
    String? paymentMode,
    double? advanceAmount,
    Object? paymentReference = _unset,
    Object? notes = _unset,
    bool? isSubmitting,
    Object? errorMessage = _unset,
    bool? gstEnabled,
  }) {
    return CreatePurchaseState(
      paymentType: paymentType == _unset ? this.paymentType : paymentType as PaymentType?,
      paymentMode: paymentMode ?? this.paymentMode,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      paymentReference: paymentReference == _unset ? this.paymentReference : paymentReference as String?,
      gstEnabled: gstEnabled ?? this.gstEnabled,
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
  CreatePurchaseState build() {
    // listen, not watch: the config loading must not rebuild (and so wipe)
    // a half-filled form.
    ref.listen<AsyncValue<TaxConfig>>(taxConfigProvider, (_, next) {
      final config = next.valueOrNull;
      if (config != null) state = state.copyWith(gstEnabled: _isGstOn(config));
    });
    final config = ref.read(taxConfigProvider).valueOrNull;
    return CreatePurchaseState(gstEnabled: config == null || _isGstOn(config));
  }

  static bool _isGstOn(TaxConfig config) => config.gstEnabled && config.taxType != 'NO_TAX';

  void setPaymentType(PaymentType type) {
    state = state.copyWith(paymentType: type);
  }

  void setPaymentMode(String mode) {
    state = state.copyWith(paymentMode: mode);
  }

  void setAdvanceAmount(double amount) {
    state = state.copyWith(advanceAmount: amount);
  }

  void setPaymentReference(String? reference) {
    final trimmed = reference?.trim();
    state = state.copyWith(paymentReference: trimmed == null || trimmed.isEmpty ? null : trimmed);
  }

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
            paidAmount: state.paidAmount,
            paymentMethod: state.paymentMethod,
            // A reference only means something when money changed hands.
            paymentReference: state.paidAmount > 0 ? state.paymentReference : null,
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
    } catch (_) {
      state = state.copyWith(isSubmitting: false, errorMessage: 'Could not save the purchase. Please try again.');
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
