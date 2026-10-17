import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../data/models/customer.dart';
import '../providers/customer_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

/// Handles both "add" (existing == null) and "edit" (existing != null) —
/// same fields, same validation, just a different submit action and title.
class CustomerFormScreen extends ConsumerStatefulWidget {
  const CustomerFormScreen({super.key, this.existing});

  final Customer? existing;

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.existing?.name);
  late final _mobileController = TextEditingController(text: widget.existing?.mobileNumber);
  late final _emailController = TextEditingController(text: widget.existing?.email);
  late final _gstController = TextEditingController(text: widget.existing?.gstNumber);
  late final _notesController = TextEditingController(text: widget.existing?.notes);

  bool get _isEdit => widget.existing != null;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _gstController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(customerFormControllerProvider.notifier);
    final name = _nameController.text.trim();
    final mobile = _mobileController.text.trim().isEmpty ? null : _mobileController.text.trim();
    final email = _emailController.text.trim().isEmpty ? null : _emailController.text.trim();
    final gst = _gstController.text.trim().isEmpty ? null : _gstController.text.trim();
    final notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();

    final success = _isEdit
        ? await controller.editCustomer(
            widget.existing!.id,
            name: name,
            mobileNumber: mobile,
            email: email,
            gstNumber: gst,
            notes: notes,
          )
        : (await controller.create(name: name, mobileNumber: mobile, email: email, gstNumber: gst, notes: notes)) !=
              null;

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_isEdit ? 'Customer updated' : 'Customer added')));
      context.pop();
    } else {
      final error = ref.read(customerFormControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerFormControllerProvider);
    final isSubmitting = state.isLoading;

    return Scaffold(
      appBar: BrandAppBar(title: Text(_isEdit ? 'Edit Customer' : 'Add Customer')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              label: 'Name',
              controller: _nameController,
              enabled: !isSubmitting,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Mobile Number',
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 12),
            AppTextField(label: 'GST Number', controller: _gstController, enabled: !isSubmitting),
            const SizedBox(height: 12),
            AppTextField(label: 'Notes', controller: _notesController, enabled: !isSubmitting),
            const SizedBox(height: 24),
            AppButton(label: _isEdit ? 'Save Changes' : 'Add Customer', isLoading: isSubmitting, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
