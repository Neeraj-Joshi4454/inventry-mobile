import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/payment_section.dart';
import '../../bankDetails/widgets/bank_details_panel.dart';
import '../../upiQr/widgets/upi_qr_panel.dart';
import '../providers/customer_payment_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD'];

/// Records a customer's repayment against one sale (e.g. settling a credit
/// sale in instalments). Reached from the Sale Details screen whenever a
/// sale still has an outstanding balance — never creates or
/// touches inventory, only the sale's paid/due totals (see
/// customerPayment.service.ts::recordCustomerPayment).
class AddPaymentScreen extends ConsumerStatefulWidget {
  const AddPaymentScreen({
    super.key,
    required this.saleId,
    required this.customerId,
    required this.saleNumber,
    required this.dueAmount,
  });

  final String saleId;
  final String customerId;
  final String saleNumber;
  final double dueAmount;

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
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

  bool get _isValid => _amount > 0 && _amount <= widget.dueAmount + 0.005;

  Future<void> _submit() async {
    if (!_isValid) return;
    final reference = _referenceController.text.trim();
    final success = await ref
        .read(addPaymentControllerProvider.notifier)
        .submit(
          saleId: widget.saleId,
          customerId: widget.customerId,
          amount: _amount,
          method: _method,
          paymentDate: _paymentDate,
          referenceNumber: _method == 'CASH' || reference.isEmpty ? null : reference,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
    } else {
      final error = ref.read(addPaymentControllerProvider).error;
      setState(() => _errorMessage = error?.toString() ?? 'Failed to record payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(addPaymentControllerProvider).isLoading;

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Record Repayment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.saleNumber, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Outstanding: ${Formatters.currency(widget.dueAmount)}',
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
                  ? 'Cannot exceed the outstanding amount'
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
          // The customer pays into the business's own UPI / bank account —
          // same panels as New Sale (see create_sale_screen.dart).
          if (_method == 'UPI' && _isValid) ...[const SizedBox(height: 16), UpiQrPanel(amount: _amount)],
          if (_method == 'BANK_TRANSFER' && _isValid) ...[
            const SizedBox(height: 16),
            BankDetailsPanel(amount: _amount),
          ],
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
