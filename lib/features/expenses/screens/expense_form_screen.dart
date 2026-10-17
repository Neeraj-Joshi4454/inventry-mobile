import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../data/models/expense.dart';
import '../data/models/expense_category.dart';
import '../providers/expense_category_providers.dart';
import '../providers/expense_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

const _paymentMethods = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD', 'OTHER'];

/// Handles both "add" (existing == null) and "edit" (existing != null) —
/// mirrors suppliers/screens/supplier_form_screen.dart's add/edit shape.
class ExpenseFormScreen extends ConsumerStatefulWidget {
  const ExpenseFormScreen({super.key, this.existing});

  final Expense? existing;

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: widget.existing?.title);
  late final _amountController = TextEditingController(
    text: widget.existing != null ? widget.existing!.amount.toString() : '',
  );
  late final _referenceController = TextEditingController(text: widget.existing?.referenceNumber);
  late final _notesController = TextEditingController(text: widget.existing?.notes);
  late final _attachmentController = TextEditingController(text: widget.existing?.attachmentUrl);

  String? _categoryId;
  String? _categoryName;
  late DateTime _expenseDate = widget.existing?.expenseDate ?? DateTime.now();
  late String _paymentMethod = widget.existing?.paymentMethod ?? 'CASH';

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.existing?.categoryId;
    _categoryName = widget.existing?.categoryName;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expenseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _expenseDate = picked);
  }

  void _pickCategory(List<ExpenseCategory> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Select Category', style: Theme.of(context).textTheme.titleMedium),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final category in categories)
                      ListTile(
                        title: Text(category.name),
                        onTap: () {
                          setState(() {
                            _categoryId = category.id;
                            _categoryName = category.name;
                          });
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_categoryId == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Please select an expense category')));
      return;
    }

    final controller = ref.read(expenseFormControllerProvider.notifier);
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0;
    final referenceNumber = _referenceController.text.trim().isEmpty ? null : _referenceController.text.trim();
    final notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final attachmentUrl = _attachmentController.text.trim().isEmpty ? null : _attachmentController.text.trim();

    final success = _isEdit
        ? await controller.editExpense(
            widget.existing!.id,
            title: title,
            categoryId: _categoryId!,
            amount: amount,
            expenseDate: _expenseDate,
            paymentMethod: _paymentMethod,
            referenceNumber: referenceNumber,
            notes: notes,
            attachmentUrl: attachmentUrl,
          )
        : await controller.create(
            title: title,
            categoryId: _categoryId!,
            amount: amount,
            expenseDate: _expenseDate,
            paymentMethod: _paymentMethod,
            referenceNumber: referenceNumber,
            notes: notes,
            attachmentUrl: attachmentUrl,
          );

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_isEdit ? 'Expense updated' : 'Expense added')));
      context.pop();
    } else {
      final error = ref.read(expenseFormControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseFormControllerProvider);
    final isSubmitting = state.isLoading;
    final categoriesAsync = ref.watch(activeExpenseCategoriesProvider);

    return Scaffold(
      appBar: BrandAppBar(title: Text(_isEdit ? 'Edit Expense' : 'Add Expense')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              label: 'Expense Title',
              controller: _titleController,
              enabled: !isSubmitting,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Expense title is required' : null,
            ),
            const SizedBox(height: 12),
            categoriesAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, _) => Text('$error'),
              data: (categories) => Card(
                child: ListTile(
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Category'),
                  subtitle: Text(_categoryName ?? 'Tap to select a category'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: isSubmitting ? null : () => _pickCategory(categories),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              enabled: !isSubmitting,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹ '),
              validator: (v) {
                final value = double.tryParse(v ?? '');
                if (value == null || value <= 0) return 'Enter an amount greater than zero';
                return null;
              },
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: const Text('Expense Date'),
                subtitle: Text(Formatters.date(_expenseDate)),
                trailing: const Icon(Icons.chevron_right),
                onTap: isSubmitting ? null : _pickDate,
              ),
            ),
            const SizedBox(height: 16),
            Text('Payment Method', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final method in _paymentMethods)
                  ChoiceChip(
                    label: Text(method),
                    selected: _paymentMethod == method,
                    onSelected: isSubmitting ? null : (_) => setState(() => _paymentMethod = method),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Reference Number (optional)',
              controller: _referenceController,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 12),
            AppTextField(label: 'Notes (optional)', controller: _notesController, enabled: !isSubmitting),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Attachment/Receipt URL (optional)',
              controller: _attachmentController,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 24),
            AppButton(label: _isEdit ? 'Save Changes' : 'Add Expense', isLoading: isSubmitting, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
