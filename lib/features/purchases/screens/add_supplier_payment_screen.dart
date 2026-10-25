import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/widgets/payment_section.dart';
import '../providers/purchase_providers.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD'];

/// Records a payment to the supplier against one purchase that still has a
/// balance due — e.g. settling a credit purchase in instalments. Reached
/// from the Purchase Details screen; never touches inventory, only the
/// purchase's paid/due totals (see supplierPayment.service.ts).
class AddSupplierPaymentScreen extends ConsumerStatefulWidget {
  const AddSupplierPaymentScreen({
    super.key,
    required this.purchaseId,
    required this.purchaseNumber,
    required this.supplierName,
    required this.dueAmount,
    this.supplierId,
  });

  final String purchaseId;
  final String purchaseNumber;
  final String supplierName;
  final String? supplierId;
  final double dueAmount;

  @override
  ConsumerState<AddSupplierPaymentScreen> createState() => _AddSupplierPaymentScreenState();
}

class _AddSupplierPaymentScreenState extends ConsumerState<AddSupplierPaymentScreen> {
  late final _amountController = TextEditingController(text: widget.dueAmount.toStringAsFixed(2));
  final _referenceController = TextEditingController();
  final _notesController = TextEditingController();
  String _method = 'CASH';
  late double _amount = widget.dueAmount;
  DateTime _paymentDate = DateTime.now();
  String? _errorMessage;

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isValid => _amount > 0 && _amount <= widget.dueAmount + 0.005;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _paymentDate,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) setState(() => _paymentDate = picked);
  }

  Future<void> _submit() async {
    if (!_isValid) return;
    final reference = _referenceController.text.trim();
    final notes = _notesController.text.trim();
    final success = await ref
        .read(supplierPaymentControllerProvider.notifier)
        .submit(
          purchaseId: widget.purchaseId,
          supplierId: widget.supplierId,
          amount: _amount,
          method: _method,
          paymentDate: _paymentDate,
          referenceNumber: _method == 'CASH' || reference.isEmpty ? null : reference,
          notes: notes.isEmpty ? null : notes,
        );
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
    } else {
      final error = ref.read(supplierPaymentControllerProvider).error;
      setState(() => _errorMessage = error?.toString() ?? 'Failed to record payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(supplierPaymentControllerProvider).isLoading;

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Pay Supplier')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.purchaseNumber, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(widget.supplierName, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(
                    'Due to supplier: ${Formatters.currency(widget.dueAmount)}',
                    style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Amount', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: '₹ ',
              errorText: _amount <= 0
                  ? 'Enter an amount greater than zero'
                  : _amount > widget.dueAmount + 0.005
                  ? 'Cannot exceed the amount due'
                  : null,
            ),
            onChanged: (value) => setState(() => _amount = double.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 20),
          Text('Payment Method', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final method in _paymentMethods)
                ChoiceChip(
                  label: Text(paymentModeLabel(method)),
                  selected: _method == method,
                  onSelected: (_) => setState(() => _method = method),
                ),
            ],
          ),
          if (_method != 'CASH') ...[
            const SizedBox(height: 16),
            TextField(
              controller: _referenceController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Reference / Txn ID (optional)'),
            ),
          ],
          const SizedBox(height: 16),
          InkWell(
            onTap: _pickDate,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Payment Date',
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
              ),
              child: Text(Formatters.date(_paymentDate)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Text(_errorMessage!, style: const TextStyle(color: AppColors.error)),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(label: 'Record Payment', isLoading: isSubmitting, onPressed: _isValid ? _submit : null),
        ),
      ),
    );
  }
}
