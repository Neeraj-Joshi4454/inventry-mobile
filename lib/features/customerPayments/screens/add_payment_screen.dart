import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/customer_payment_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD'];

/// Records a payment against one sale. Reached from the Sale Details screen
/// whenever a sale still has an outstanding balance — never creates or
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
  late final _amountController = TextEditingController(text: widget.dueAmount.toString());
  final _notesController = TextEditingController();
  String _method = 'CASH';
  double _amount = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _amount = widget.dueAmount;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isValid => _amount > 0 && _amount <= widget.dueAmount + 0.005;

  Future<void> _submit() async {
    if (!_isValid) return;
    final success = await ref
        .read(addPaymentControllerProvider.notifier)
        .submit(
          saleId: widget.saleId,
          customerId: widget.customerId,
          amount: _amount,
          method: _method,
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
      appBar: BrandAppBar(title: const Text('Add Payment')),
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
                  label: Text(_methodLabel(method)),
                  selected: _method == method,
                  onSelected: (_) => setState(() => _method = method),
                ),
            ],
          ),
          const SizedBox(height: 20),
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

  String _methodLabel(String method) {
    return switch (method) {
      'CASH' => 'Cash',
      'UPI' => 'UPI',
      'BANK_TRANSFER' => 'Bank Transfer',
      'CARD' => 'Card',
      _ => method,
    };
  }
}
