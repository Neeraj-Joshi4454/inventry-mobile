import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/gst_rate_selector.dart';
import '../../../core/widgets/payment_section.dart';
import '../../inventory/widgets/product_picker_page.dart';
import '../../suppliers/data/models/supplier.dart';
import '../../suppliers/providers/supplier_providers.dart';
import '../data/models/purchase_item.dart';
import '../providers/purchase_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class CreatePurchaseScreen extends ConsumerStatefulWidget {
  const CreatePurchaseScreen({super.key});

  @override
  ConsumerState<CreatePurchaseScreen> createState() => _CreatePurchaseScreenState();
}

class _CreatePurchaseScreenState extends ConsumerState<CreatePurchaseScreen> {
  final Map<String, TextEditingController> _quantityControllers = {};
  final Map<String, TextEditingController> _rateControllers = {};
  final _discountController = TextEditingController(text: '0');
  final _notesController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _advanceController = TextEditingController();
  final _referenceController = TextEditingController();

  @override
  void dispose() {
    for (final c in _quantityControllers.values) {
      c.dispose();
    }
    for (final c in _rateControllers.values) {
      c.dispose();
    }
    _discountController.dispose();
    _notesController.dispose();
    _invoiceNumberController.dispose();
    _advanceController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  TextEditingController _quantityControllerFor(PurchaseLineDraft line) {
    return _quantityControllers.putIfAbsent(
      line.productId,
      () => TextEditingController(text: line.quantity?.toString() ?? ''),
    );
  }

  TextEditingController _rateControllerFor(PurchaseLineDraft line) {
    return _rateControllers.putIfAbsent(
      line.productId,
      () => TextEditingController(text: line.unitPrice?.toString() ?? ''),
    );
  }

  Future<void> _addProduct() async {
    final state = ref.read(createPurchaseControllerProvider);
    final existingIds = state.lines.map((l) => l.productId).toSet();
    final picked = await pickProduct(context, excludeProductIds: existingIds);
    if (picked == null) return;
    ref
        .read(createPurchaseControllerProvider.notifier)
        .addLine(
          PurchaseLineDraft(
            productId: picked.productId,
            productName: picked.name,
            unitSymbol: picked.unit.symbol,
            currentStock: picked.currentStock,
            taxRate: picked.taxRate,
          ),
        );
  }

  Future<void> _pickDate() async {
    final state = ref.read(createPurchaseControllerProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: state.purchaseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ref.read(createPurchaseControllerProvider.notifier).setPurchaseDate(picked);
    }
  }

  Future<void> _submit() async {
    final success = await ref.read(createPurchaseControllerProvider.notifier).submit();
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Purchase recorded successfully')));
      context.pop();
    } else {
      final error = ref.read(createPurchaseControllerProvider).errorMessage;
      if (error != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createPurchaseControllerProvider);
    final notifier = ref.read(createPurchaseControllerProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('New Purchase')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _SupplierPicker(selected: state.supplier),
          const SizedBox(height: 16),
          AppTextField(label: 'Invoice / Bill Number (optional)', controller: _invoiceNumberController),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('Purchase Date'),
              subtitle: Text(Formatters.date(state.purchaseDate)),
              trailing: const Icon(Icons.chevron_right),
              onTap: _pickDate,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Products', style: Theme.of(context).textTheme.titleMedium),
              TextButton.icon(onPressed: _addProduct, icon: const Icon(Icons.add), label: const Text('Add Product')),
            ],
          ),
          if (state.lines.isEmpty)
            const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Text('No products added yet.'))
          else
            for (var i = 0; i < state.lines.length; i++) _buildLineCard(state.lines[i], i),
          const SizedBox(height: 20),
          TextField(
            controller: _discountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Discount Amount'),
            onChanged: (value) => notifier.setDiscount(double.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 12),
          AppTextField(label: 'Notes (optional)', controller: _notesController),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _TotalRow(label: 'Subtotal', value: state.subTotal),
                  _TotalRow(label: 'Discount', value: -state.effectiveDiscount),
                  _TotalRow(label: 'Tax', value: state.taxAmount),
                  const Divider(height: 20),
                  _TotalRow(label: 'Grand Total', value: state.grandTotal, emphasize: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          PaymentSection(
            noun: 'purchase',
            question: 'How are you paying the supplier for this purchase?',
            directSubtitle: 'Paid in full now',
            creditSubtitle: 'Pay supplier later',
            paidLabel: 'paid',
            dueLabel: 'Amount due to supplier',
            type: state.paymentType,
            onTypeChanged: notifier.setPaymentType,
            grandTotal: state.grandTotal,
            paidAmount: state.paidAmount,
            remainingAmount: state.remainingAmount,
            previewStatus: state.previewPaymentStatus,
            advanceExceedsTotal: state.advanceExceedsTotal,
            advanceController: _advanceController,
            onAdvanceChanged: notifier.setAdvanceAmount,
            paymentMode: state.paymentMode,
            onModeChanged: notifier.setPaymentMode,
            referenceController: _referenceController,
            onReferenceChanged: notifier.setPaymentReference,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: 'Save Purchase',
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit
                ? () {
                    ref
                        .read(createPurchaseControllerProvider.notifier)
                        .setNotes(_notesController.text.trim().isEmpty ? null : _notesController.text.trim());
                    ref
                        .read(createPurchaseControllerProvider.notifier)
                        .setInvoiceNumber(
                          _invoiceNumberController.text.trim().isEmpty ? null : _invoiceNumberController.text.trim(),
                        );
                    _submit();
                  }
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildLineCard(PurchaseLineDraft line, int index) {
    final quantityController = _quantityControllerFor(line);
    final rateController = _rateControllerFor(line);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(
                        'Current stock: ${Formatters.quantity(line.currentStock)} ${line.unitSymbol}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () {
                    _quantityControllers.remove(line.productId)?.dispose();
                    _rateControllers.remove(line.productId)?.dispose();
                    ref.read(createPurchaseControllerProvider.notifier).removeLine(index);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Qty (${line.unitSymbol})'),
                    onChanged: (value) {
                      ref
                          .read(createPurchaseControllerProvider.notifier)
                          .updateLine(index, quantity: double.tryParse(value));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: rateController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Rate (₹)'),
                    onChanged: (value) {
                      ref
                          .read(createPurchaseControllerProvider.notifier)
                          .updateLine(index, unitPrice: double.tryParse(value));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GstRateSelector(
              value: line.taxRate,
              onChanged: (rate) => ref.read(createPurchaseControllerProvider.notifier).updateLine(index, taxRate: rate),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Line Total (incl. GST): ${Formatters.currency(line.lineTotal)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupplierPicker extends ConsumerWidget {
  const _SupplierPicker({required this.selected});

  final Supplier? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(suppliersProvider);

    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_shipping_outlined),
        title: const Text('Supplier'),
        subtitle: Text(selected?.name ?? 'Tap to select a supplier'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showSupplierSheet(context, ref, suppliersAsync),
      ),
    );
  }

  void _showSupplierSheet(BuildContext context, WidgetRef ref, AsyncValue<List<Supplier>> suppliersAsync) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Supplier', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                suppliersAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => Text('$error'),
                  data: (suppliers) => Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final supplier in suppliers)
                          ListTile(
                            title: Text(supplier.name),
                            trailing: PickerDeleteButton(
                              tooltip: 'Delete supplier',
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                                _deleteSupplier(context, ref, supplier);
                              },
                            ),
                            onTap: () {
                              ref.read(createPurchaseControllerProvider.notifier).setSupplier(supplier);
                              Navigator.of(sheetContext).pop();
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _showAddSupplierDialog(context, ref);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Supplier'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Deactivates rather than erases, so past purchases and the supplier's
  /// balance stay intact — the supplier just stops appearing in pickers.
  Future<void> _deleteSupplier(BuildContext context, WidgetRef ref, Supplier supplier) async {
    final deleted = await confirmAndDelete(
      context,
      title: 'Delete supplier?',
      message: '"${supplier.name}" will no longer appear in lists. Past purchases are kept.',
      successMessage: 'Supplier deleted',
      onDelete: () async {
        await ref.read(supplierApiProvider).setSupplierStatus(supplier.id, false);
        ref.invalidate(suppliersProvider);
      },
    );
    if (deleted && ref.read(createPurchaseControllerProvider).supplier?.id == supplier.id) {
      ref.read(createPurchaseControllerProvider.notifier).clearSupplier();
    }
  }

  void _showAddSupplierDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Supplier'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Supplier Name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                final navigator = Navigator.of(dialogContext);
                final supplier = await ref.read(supplierApiProvider).createSupplier(name: name);
                ref.invalidate(suppliersProvider);
                ref.read(createPurchaseControllerProvider.notifier).setSupplier(supplier);
                navigator.pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.label, required this.value, this.emphasize = false});

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: emphasize ? FontWeight.w700 : FontWeight.w400, fontSize: emphasize ? 16 : 14),
          ),
          Text(
            Formatters.currency(value),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: emphasize ? 18 : 14,
              color: emphasize ? AppColors.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
