import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/document_totals.dart';
import '../../../core/widgets/payment_section.dart';
import '../../auth/providers/auth_provider.dart';
import '../../customerPayments/data/models/customer_payment.dart';
import '../../customers/providers/customer_providers.dart';
import '../../inventory/providers/inventory_providers.dart';
import '../../taxes/data/models/tax_config.dart';
import '../../taxes/providers/tax_providers.dart';
import '../data/models/sale.dart';
import '../data/models/sale_invoice.dart';
import '../data/models/sale_item.dart';
import '../data/sale_api.dart';

final saleApiProvider = Provider<SaleApi>((ref) => SaleApi(ref.watch(dioProvider)));

// ---------------------------------------------------------------------------
// Sales list (search + customer + date-range filters, pagination)
// ---------------------------------------------------------------------------

class SaleListState {
  const SaleListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.search = '',
    this.customerId,
    this.fromDate,
    this.toDate,
    this.page = 1,
  });

  final List<Sale> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String search;
  final String? customerId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int page;

  SaleListState copyWith({
    List<Sale>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    String? search,
    Object? customerId = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    int? page,
  }) {
    return SaleListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      search: search ?? this.search,
      customerId: customerId == _unset ? this.customerId : customerId as String?,
      fromDate: fromDate == _unset ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _unset ? this.toDate : toDate as DateTime?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();


class SaleListNotifier extends Notifier<SaleListState> {
  @override
  SaleListState build() {
    Future.microtask(refresh);
    return const SaleListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref
          .read(saleApiProvider)
          .listSales(
            page: 1,
            search: state.search,
            customerId: state.customerId,
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
          .read(saleApiProvider)
          .listSales(
            page: nextPage,
            search: state.search,
            customerId: state.customerId,
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

  void setCustomer(String? customerId) {
    state = state.copyWith(customerId: customerId);
    refresh();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    // Inclusive of the whole last day — the picker gives its midnight start.
    state = state.copyWith(
      fromDate: from,
      toDate: to == null ? null : DateTime(to.year, to.month, to.day, 23, 59, 59, 999),
    );
    refresh();
  }

  void clearFilters() {
    state = state.copyWith(customerId: null, fromDate: null, toDate: null);
    refresh();
  }
}

final saleListProvider = NotifierProvider<SaleListNotifier, SaleListState>(SaleListNotifier.new);

// ---------------------------------------------------------------------------
// Sale detail
// ---------------------------------------------------------------------------

final saleDetailProvider =
    FutureProvider.family<({Sale sale, List<SaleItem> items, List<CustomerPayment> payments}), String>(
      (ref, id) => ref.watch(saleApiProvider).getSale(id),
    );

final saleInvoiceProvider = FutureProvider.family<SaleInvoice, String>(
  (ref, id) => ref.watch(saleApiProvider).getSaleInvoice(id),
);

// ---------------------------------------------------------------------------
// Create Sale form
// ---------------------------------------------------------------------------

/// How the customer is settling this sale — shared with purchases (see
/// core/widgets/payment_section.dart).
typedef SaleType = PaymentType;

const salePaymentModes = paymentModes;

class CreateSaleState {
  const CreateSaleState({
    this.customerId,
    this.customerName,
    DateTime? saleDate,
    this.lines = const [],
    this.discountAmount = 0,
    this.saleType,
    this.paymentMode = 'CASH',
    this.advanceAmount = 0,
    this.paymentReference,
    this.notes,
    this.isSubmitting = false,
    this.errorMessage,
    this.lastResult,
    this.gstEnabled = true,
  }) : _saleDate = saleDate;

  /// The tenant's GST switch (false also for taxType NO_TAX) — when off the
  /// backend ignores every line's taxRate.
  final bool gstEnabled;

  final String? customerId;
  final String? customerName;
  final DateTime? _saleDate;
  final List<SaleLineDraft> lines;
  final double discountAmount;
  final SaleType? saleType;
  final String paymentMode;
  final double advanceAmount;
  final String? paymentReference;
  final String? notes;
  final bool isSubmitting;
  final String? errorMessage;
  final CreatedSaleSummary? lastResult;

  DateTime get saleDate => _saleDate ?? DateTime.now();

  DocumentTotals get _totals => computeDocumentTotals(
    [for (final l in lines) (quantity: l.quantity ?? 0, unitPrice: l.unitPrice ?? 0, taxRate: l.taxRate)],
    discountAmount: discountAmount,
    gstEnabled: gstEnabled,
  );

  double get subTotal => _totals.subTotal;
  double get effectiveDiscount => _totals.discount;
  double get taxAmount => _totals.tax;
  double get grandTotal => _totals.total;

  /// Money received now: the full total for a direct sale, the advance
  /// (possibly zero) for a credit sale.
  double get paidAmount => paidNow(saleType, grandTotal: grandTotal, advance: advanceAmount);

  /// What the backend stores as the sale's payment method: the mode money
  /// was received in, or CREDIT when nothing was received.
  String get paymentMethod => paidAmount > 0 ? paymentMode : 'CREDIT';

  double get remainingAmount => (grandTotal - paidAmount).clamp(0, double.infinity);

  /// Live preview of what the backend will compute — mirrors
  /// sale.service.ts::createSale's status logic so the screen shows the
  /// same PAID/PARTIAL/CREDIT the sale will actually be saved with.
  String get previewPaymentStatus =>
      previewStatusFor(paid: paidAmount, remaining: remainingAmount, unpaidStatus: 'CREDIT');

  bool get advanceExceedsTotal => saleType == SaleType.credit && advanceAmount > grandTotal + 0.005;

  bool get canSubmit =>
      customerId != null &&
      lines.isNotEmpty &&
      lines.every((l) => l.isValid) &&
      saleType != null &&
      !advanceExceedsTotal &&
      !isSubmitting;

  CreateSaleState copyWith({
    Object? customerId = _unset,
    Object? customerName = _unset,
    DateTime? saleDate,
    List<SaleLineDraft>? lines,
    double? discountAmount,
    Object? saleType = _unset,
    String? paymentMode,
    double? advanceAmount,
    Object? paymentReference = _unset,
    Object? notes = _unset,
    bool? isSubmitting,
    Object? errorMessage = _unset,
    Object? lastResult = _unset,
    bool? gstEnabled,
  }) {
    return CreateSaleState(
      gstEnabled: gstEnabled ?? this.gstEnabled,
      customerId: customerId == _unset ? this.customerId : customerId as String?,
      customerName: customerName == _unset ? this.customerName : customerName as String?,
      saleDate: saleDate ?? _saleDate,
      lines: lines ?? this.lines,
      discountAmount: discountAmount ?? this.discountAmount,
      saleType: saleType == _unset ? this.saleType : saleType as SaleType?,
      paymentMode: paymentMode ?? this.paymentMode,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      paymentReference: paymentReference == _unset ? this.paymentReference : paymentReference as String?,
      notes: notes == _unset ? this.notes : notes as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      lastResult: lastResult == _unset ? this.lastResult : lastResult as CreatedSaleSummary?,
    );
  }
}

/// What the "Sale created successfully" confirmation needs to show —
/// captured at submit time rather than re-fetched, so it reads correctly
/// even if the sale/inventory providers refresh in the background right
/// after.
class CreatedSaleSummary {
  const CreatedSaleSummary({
    required this.saleNumber,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.updatedStock,
  });

  final String saleNumber;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String paymentStatus;

  /// CASH / UPI / BANK_TRANSFER / CARD, or CREDIT when nothing was paid.
  final String paymentMethod;

  /// productName -> resulting stock, for every product sold.
  final Map<String, double> updatedStock;
}

class CreateSaleController extends AutoDisposeNotifier<CreateSaleState> {
  @override
  CreateSaleState build() {
    // listen, not watch: the config loading must not rebuild (and so wipe)
    // a half-filled form.
    ref.listen<AsyncValue<TaxConfig>>(taxConfigProvider, (_, next) {
      final config = next.valueOrNull;
      if (config != null) state = state.copyWith(gstEnabled: _isGstOn(config));
    });
    final config = ref.read(taxConfigProvider).valueOrNull;
    return CreateSaleState(gstEnabled: config == null || _isGstOn(config));
  }

  static bool _isGstOn(TaxConfig config) => config.gstEnabled && config.taxType != 'NO_TAX';

  void setCustomer(String id, String name) {
    state = state.copyWith(customerId: id, customerName: name);
  }

  void clearCustomer() {
    state = state.copyWith(customerId: null, customerName: null);
  }

  void setSaleDate(DateTime date) {
    state = state.copyWith(saleDate: date);
  }

  void setDiscount(double amount) {
    state = state.copyWith(discountAmount: amount);
  }

  void setSaleType(SaleType type) {
    state = state.copyWith(saleType: type);
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

  void setNotes(String? notes) {
    state = state.copyWith(notes: notes);
  }

  void addLine(SaleLineDraft line) {
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
    state = const CreateSaleState();
  }

  Future<bool> submit() async {
    if (!state.canSubmit) return false;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      final result = await ref
          .read(saleApiProvider)
          .createSale(
            customerId: state.customerId!,
            saleDate: state.saleDate,
            discountAmount: state.discountAmount,
            paidAmount: state.paidAmount,
            paymentMethod: state.paymentMethod,
            // A reference only means something when money changed hands.
            paymentReference: state.paidAmount > 0 ? state.paymentReference : null,
            notes: state.notes,
            items: state.lines
                .map(
                  (l) => SaleLineItemRequest(
                    productId: l.productId,
                    quantity: l.quantity!,
                    unitPrice: l.unitPrice!,
                    taxRate: l.taxRate,
                  ),
                )
                .toList(),
          );

      final updatedStock = {for (final line in state.lines) line.productName: line.availableStock - line.quantity!};
      state = state.copyWith(
        isSubmitting: false,
        lastResult: CreatedSaleSummary(
          saleNumber: result.saleNumber,
          totalAmount: result.totalAmount,
          paidAmount: result.paidAmount,
          dueAmount: result.dueAmount,
          paymentStatus: result.paymentStatus,
          paymentMethod: state.paymentMethod,
          updatedStock: updatedStock,
        ),
      );

      // Stock levels for these products just changed on the backend —
      // invalidate every cached view of them so the next read is fresh
      // (see purchase_providers.dart::submit for why this is necessary).
      ref.invalidate(inventoryListProvider);
      for (final line in state.lines) {
        ref.invalidate(productStockDetailProvider(line.productId));
        ref.invalidate(ledgerProvider(line.productId));
      }
      ref.invalidate(customersProvider);

      return true;
    } on ApiException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      // e.g. an unexpected response shape — without this the button would
      // stay stuck on its spinner with no feedback.
      state = state.copyWith(isSubmitting: false, errorMessage: 'Could not create the sale. Please try again.');
      return false;
    }
  }
}

/// Auto-disposed: the form's state lives only while the New Sale screen is
/// open, so every visit starts empty however the screen was reached.
final createSaleControllerProvider = NotifierProvider.autoDispose<CreateSaleController, CreateSaleState>(
  CreateSaleController.new,
);

// ---------------------------------------------------------------------------
// Sale returns
// ---------------------------------------------------------------------------
