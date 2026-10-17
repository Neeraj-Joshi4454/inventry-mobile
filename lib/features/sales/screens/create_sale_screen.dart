import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/filter_chip_bar.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/gst_rate_selector.dart';
import '../../../core/widgets/status_badge.dart';
import '../../customers/data/models/customer.dart';
import '../../customers/providers/customer_providers.dart';
import '../../inventory/widgets/product_picker_page.dart';
import '../data/models/sale_item.dart';
import '../providers/sale_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../bankDetails/widgets/bank_details_panel.dart';
import '../../upiQr/widgets/upi_qr_panel.dart';

class CreateSaleScreen extends ConsumerStatefulWidget {
  const CreateSaleScreen({super.key});

  @override
  ConsumerState<CreateSaleScreen> createState() => _CreateSaleScreenState();
}

class _CreateSaleScreenState extends ConsumerState<CreateSaleScreen> {
  final Map<String, TextEditingController> _quantityControllers = {};
  final Map<String, TextEditingController> _rateControllers = {};
  final _discountController = TextEditingController(text: '0');
  final _advanceController = TextEditingController();
  final _referenceController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    for (final c in _quantityControllers.values) {
      c.dispose();
    }
    for (final c in _rateControllers.values) {
      c.dispose();
    }
    _discountController.dispose();
    _advanceController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  TextEditingController _quantityControllerFor(SaleLineDraft line) {
    return _quantityControllers.putIfAbsent(
      line.productId,
      () => TextEditingController(text: line.quantity?.toString() ?? ''),
    );
  }

  TextEditingController _rateControllerFor(SaleLineDraft line) {
    return _rateControllers.putIfAbsent(
      line.productId,
      () => TextEditingController(text: line.unitPrice?.toString() ?? ''),
    );
  }

  Future<void> _addProduct() async {
    final state = ref.read(createSaleControllerProvider);
    final existingIds = state.lines.map((l) => l.productId).toSet();
    final picked = await pickProduct(context, excludeProductIds: existingIds, inStockOnly: true);
    if (picked == null) return;
    ref
        .read(createSaleControllerProvider.notifier)
        .addLine(
          SaleLineDraft(
            productId: picked.productId,
            productName: picked.name,
            unitSymbol: picked.unit.symbol,
            availableStock: picked.currentStock,
            taxRate: picked.taxRate,
          ),
        );
  }

  Future<void> _pickDate() async {
    final state = ref.read(createSaleControllerProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: state.saleDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ref.read(createSaleControllerProvider.notifier).setSaleDate(picked);
    }
  }

  Future<void> _submit() async {
    final success = await ref.read(createSaleControllerProvider.notifier).submit();
    if (!mounted) return;
    if (success) {
      final result = ref.read(createSaleControllerProvider).lastResult!;
      await _showSuccessDialog(result);
      if (!mounted) return;
      context.pop();
    } else {
      final error = ref.read(createSaleControllerProvider).errorMessage;
      if (error != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  Future<void> _showSuccessDialog(CreatedSaleSummary result) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, color: AppColors.success, size: 40),
          title: const Text('Sale created successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DialogRow(label: 'Sale Number', value: result.saleNumber),
              _DialogRow(label: 'Total', value: Formatters.currency(result.totalAmount)),
              _DialogRow(label: 'Paid', value: Formatters.currency(result.paidAmount)),
              if (result.paidAmount > 0) _DialogRow(label: 'Paid via', value: paymentModeLabel(result.paymentMethod)),
              _DialogRow(label: 'Outstanding', value: Formatters.currency(result.dueAmount)),
              _DialogRow(label: 'Status', value: result.paymentStatus),
              const SizedBox(height: 8),
              Text('Updated Stock', style: Theme.of(dialogContext).textTheme.labelLarge),
              const SizedBox(height: 4),
              for (final entry in result.updatedStock.entries)
                _DialogRow(label: entry.key, value: Formatters.quantity(entry.value)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Done'))],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createSaleControllerProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('New Sale')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _CustomerPicker(customerId: state.customerId, customerName: state.customerName),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('Sale Date'),
              subtitle: Text(Formatters.date(state.saleDate)),
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
            onChanged: (value) {
              ref.read(createSaleControllerProvider.notifier).setDiscount(double.tryParse(value) ?? 0);
            },
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
                  _TotalRow(label: 'Discount', value: -state.discountAmount),
                  _TotalRow(label: 'Tax', value: state.taxAmount),
                  const Divider(height: 20),
                  _TotalRow(label: 'Grand Total', value: state.grandTotal, emphasize: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _PaymentSection(
            state: state,
            advanceController: _advanceController,
            referenceController: _referenceController,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: 'Confirm Sale',
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit
                ? () {
                    ref
                        .read(createSaleControllerProvider.notifier)
                        .setNotes(_notesController.text.trim().isEmpty ? null : _notesController.text.trim());
                    _submit();
                  }
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildLineCard(SaleLineDraft line, int index) {
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
                        'Available Stock: ${Formatters.quantity(line.availableStock)} ${line.unitSymbol}',
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
                    ref.read(createSaleControllerProvider.notifier).removeLine(index);
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
                    decoration: InputDecoration(
                      labelText: 'Qty (${line.unitSymbol})',
                      errorText: line.exceedsAvailableStock
                          ? 'Only ${Formatters.quantity(line.availableStock)} ${line.unitSymbol} available'
                          : null,
                    ),
                    onChanged: (value) {
                      ref
                          .read(createSaleControllerProvider.notifier)
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
                          .read(createSaleControllerProvider.notifier)
                          .updateLine(index, unitPrice: double.tryParse(value));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GstRateSelector(
              value: line.taxRate,
              onChanged: (rate) => ref.read(createSaleControllerProvider.notifier).updateLine(index, taxRate: rate),
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

class _CustomerPicker extends ConsumerWidget {
  const _CustomerPicker({required this.customerId, required this.customerName});

  final String? customerId;
  final String? customerName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);

    return Card(
      child: ListTile(
        leading: const Icon(Icons.person_outline),
        title: const Text('Customer'),
        subtitle: Text(customerName ?? 'Tap to select a customer'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showCustomerSheet(context, ref, customersAsync),
      ),
    );
  }

  void _showCustomerSheet(BuildContext context, WidgetRef ref, AsyncValue<List<Customer>> customersAsync) {
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
                Text('Select Customer', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                customersAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => Text('$error'),
                  data: (customers) => Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final customer in customers)
                          ListTile(
                            title: Text(customer.name),
                            subtitle: customer.mobileNumber != null ? Text(customer.mobileNumber!) : null,
                            trailing: PickerDeleteButton(
                              tooltip: 'Delete customer',
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                                _deleteCustomer(context, ref, customer);
                              },
                            ),
                            onTap: () {
                              ref.read(createSaleControllerProvider.notifier).setCustomer(customer.id, customer.name);
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
                    _showAddCustomerDialog(context, ref);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Customer'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Deactivates rather than erases, so past sales and any balance due stay
  /// intact — the customer just stops appearing in pickers.
  Future<void> _deleteCustomer(BuildContext context, WidgetRef ref, Customer customer) async {
    final deleted = await confirmAndDelete(
      context,
      title: 'Delete customer?',
      message: '"${customer.name}" will no longer appear in lists. Past sales and dues are kept.',
      successMessage: 'Customer deleted',
      onDelete: () async {
        await ref.read(customerApiProvider).setCustomerStatus(customer.id, false);
        ref.invalidate(customersProvider);
      },
    );
    if (deleted && ref.read(createSaleControllerProvider).customerId == customer.id) {
      ref.read(createSaleControllerProvider.notifier).clearCustomer();
    }
  }

  void _showAddCustomerDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Customer'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Customer Name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                final navigator = Navigator.of(dialogContext);
                final customer = await ref.read(customerApiProvider).createCustomer(name: name);
                ref.invalidate(customersProvider);
                ref.read(createSaleControllerProvider.notifier).setCustomer(customer.id, customer.name);
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

class _DialogRow extends StatelessWidget {
  const _DialogRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
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

String paymentModeLabel(String mode) => switch (mode) {
  'CASH' => 'Cash',
  'UPI' => 'UPI',
  'BANK_TRANSFER' => 'Bank transfer',
  'CARD' => 'Card',
  'CREDIT' => 'Credit',
  _ => mode,
};

/// Payment step of a sale: first a required choice between a direct
/// (paid-in-full) sale and a credit sale, then the details that choice
/// needs — payment mode and transaction reference for money received, and
/// an optional advance plus the amount due for credit.
class _PaymentSection extends ConsumerWidget {
  const _PaymentSection({required this.state, required this.advanceController, required this.referenceController});

  final CreateSaleState state;
  final TextEditingController advanceController;
  final TextEditingController referenceController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(createSaleControllerProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final saleType = state.saleType;
    final receivingMoney = state.paidAmount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text('Payment', style: textTheme.titleMedium)),
            if (saleType != null) PaymentStatusBadge(status: state.previewPaymentStatus),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text('How is the customer paying for this sale?', style: textTheme.bodySmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SaleTypeOption(
                icon: Icons.payments_outlined,
                title: 'Direct sale',
                subtitle: 'Paid in full now',
                selected: saleType == SaleType.direct,
                onTap: () => notifier.setSaleType(SaleType.direct),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _SaleTypeOption(
                icon: Icons.schedule_outlined,
                title: 'Credit sale',
                subtitle: 'Customer pays later',
                selected: saleType == SaleType.credit,
                onTap: () => notifier.setSaleType(SaleType.credit),
              ),
            ),
          ],
        ),
        if (saleType == SaleType.credit) ...[
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: advanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Advance received now (optional)',
              prefixText: '₹ ',
              helperText: state.advanceExceedsTotal ? null : 'Leave empty if nothing is paid today',
              errorText: state.advanceExceedsTotal ? 'Advance cannot be more than the grand total' : null,
            ),
            onChanged: (value) => notifier.setAdvanceAmount(double.tryParse(value) ?? 0),
          ),
        ],
        if (saleType != null && receivingMoney) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(saleType == SaleType.direct ? 'Payment mode' : 'Advance paid via', style: textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final mode in salePaymentModes)
                AppFilterChip(
                  label: paymentModeLabel(mode),
                  selected: state.paymentMode == mode,
                  onSelected: () => notifier.setPaymentMode(mode),
                ),
            ],
          ),
          if (state.paymentMode == 'UPI') ...[
            const SizedBox(height: AppSpacing.md),
            UpiQrPanel(amount: state.paidAmount),
          ],
          if (state.paymentMode == 'BANK_TRANSFER') ...[
            const SizedBox(height: AppSpacing.md),
            BankDetailsPanel(amount: state.paidAmount),
          ],
          if (state.paymentMode != 'CASH') ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: referenceController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: _referenceLabel(state.paymentMode)),
              onChanged: notifier.setPaymentReference,
            ),
          ],
        ],
        if (saleType != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  _TotalRow(label: 'Grand Total', value: state.grandTotal),
                  _TotalRow(
                    label: saleType == SaleType.direct ? 'Amount received' : 'Advance received',
                    value: state.paidAmount,
                  ),
                  const Divider(height: 20),
                  _AmountDueRow(amount: state.remainingAmount),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  static String _referenceLabel(String mode) => switch (mode) {
    'UPI' => 'UPI transaction ID (optional)',
    'BANK_TRANSFER' => 'UTR / bank reference (optional)',
    'CARD' => 'Card slip / approval no. (optional)',
    _ => 'Reference (optional)',
  };
}

class _SaleTypeOption extends StatelessWidget {
  const _SaleTypeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(AppRadius.lg);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: selected ? scheme.primary : scheme.outlineVariant, width: selected ? 1.5 : 1),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: AppSizes.icon,
                      color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
                    ),
                    const Spacer(),
                    Icon(
                      selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      size: AppSizes.iconSm,
                      color: selected ? scheme.primary : scheme.outline,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmountDueRow extends StatelessWidget {
  const _AmountDueRow({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    final due = amount > 0.005;
    return Row(
      children: [
        Expanded(
          child: Text(
            due ? 'Amount due from customer' : 'Amount due',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        Text(
          Formatters.currency(amount),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: due ? AppColors.warning : AppColors.success,
          ),
        ),
      ],
    );
  }
}
