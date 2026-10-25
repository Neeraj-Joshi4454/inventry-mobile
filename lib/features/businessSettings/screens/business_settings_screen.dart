import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/storage/local_image_provider.dart';
import '../../../core/storage/pick_local_image.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/business_settings.dart';
import '../providers/business_settings_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/utils/page_padding.dart';

class BusinessSettingsScreen extends ConsumerStatefulWidget {
  const BusinessSettingsScreen({super.key});

  @override
  ConsumerState<BusinessSettingsScreen> createState() => _BusinessSettingsScreenState();
}

class _BusinessSettingsScreenState extends ConsumerState<BusinessSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _gstController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _pincodeController = TextEditingController();
  final _invoicePrefixController = TextEditingController();
  final _invoiceFooterController = TextEditingController();
  bool _loaded = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _gstController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _pincodeController.dispose();
    _invoicePrefixController.dispose();
    _invoiceFooterController.dispose();
    super.dispose();
  }

  void _prefill(BusinessSettings settings) {
    if (_loaded) return;
    _loaded = true;
    _businessNameController.text = settings.businessName;
    _ownerNameController.text = settings.ownerName;
    _mobileController.text = settings.mobileNumber;
    _emailController.text = settings.email ?? '';
    _gstController.text = settings.gstNumber ?? '';
    _stateController.text = settings.address?.state ?? '';
    _cityController.text = settings.address?.city ?? '';
    _addressLine1Controller.text = settings.address?.line1 ?? '';
    _addressLine2Controller.text = settings.address?.line2 ?? '';
    _pincodeController.text = settings.address?.pincode ?? '';
    _invoicePrefixController.text = settings.invoicePrefix;
    _invoiceFooterController.text = settings.invoiceFooterNote ?? '';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(businessSettingsFormControllerProvider.notifier);
    final success = await controller.save(
      businessName: _businessNameController.text.trim(),
      ownerName: _ownerNameController.text.trim(),
      businessMobileNumber: _mobileController.text.trim().isEmpty ? null : _mobileController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      gstNumber: _gstController.text.trim().isEmpty ? null : _gstController.text.trim(),
      // Sent in full: the backend replaces the whole address, so every
      // part must be included or it would be cleared.
      address: {
        'line1': _addressLine1Controller.text.trim(),
        'line2': _addressLine2Controller.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'pincode': _pincodeController.text.trim(),
      },
      invoicePrefix: _invoicePrefixController.text.trim().isEmpty ? 'INV' : _invoicePrefixController.text.trim(),
      invoiceFooterNote: _invoiceFooterController.text.trim().isEmpty ? null : _invoiceFooterController.text.trim(),
    );
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Business settings saved')));
    } else {
      final error = ref.read(businessSettingsFormControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(businessSettingsProvider);
    final formState = ref.watch(businessSettingsFormControllerProvider);
    final isSubmitting = formState.isLoading;

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Business Settings')),
      body: settingsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(message: '$error', onRetry: () => ref.invalidate(businessSettingsProvider)),
        data: (settings) {
          _prefill(settings);
          return Form(
            key: _formKey,
            child: ListView(
              padding: pagePadding(context),
              children: [
                Text(
                  'These details and your logo are printed on every sale and purchase invoice.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                const _BusinessLogoSection(),
                const SizedBox(height: 24),
                Text('Business details', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Business Name',
                  controller: _businessNameController,
                  enabled: !isSubmitting,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Business name is required' : null,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Owner Name',
                  controller: _ownerNameController,
                  enabled: !isSubmitting,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Owner name is required' : null,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Mobile Number',
                  controller: _mobileController,
                  enabled: !isSubmitting,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  enabled: !isSubmitting,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'GSTIN',
                  controller: _gstController,
                  enabled: !isSubmitting,
                  textCapitalization: TextCapitalization.characters,
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                Text('Address', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                AppTextField(label: 'Address line 1', controller: _addressLine1Controller, enabled: !isSubmitting),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Address line 2 (optional)',
                  controller: _addressLine2Controller,
                  enabled: !isSubmitting,
                ),
                const SizedBox(height: 12),
                AppTextField(label: 'City', controller: _cityController, enabled: !isSubmitting),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(label: 'State', controller: _stateController, enabled: !isSubmitting),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        label: 'Pincode',
                        controller: _pincodeController,
                        enabled: !isSubmitting,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Invoice Settings', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                AppTextField(label: 'Invoice Prefix', controller: _invoicePrefixController, enabled: !isSubmitting),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Invoice Footer Note',
                  controller: _invoiceFooterController,
                  enabled: !isSubmitting,
                ),
                const SizedBox(height: 24),
                AppButton(label: 'Save', isLoading: isSubmitting, onPressed: _save),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Logo picker for invoices. Stored only on this phone (like the UPI QR),
/// so it applies to invoices generated on this device.
class _BusinessLogoSection extends ConsumerStatefulWidget {
  const _BusinessLogoSection();

  @override
  ConsumerState<_BusinessLogoSection> createState() => _BusinessLogoSectionState();
}

class _BusinessLogoSectionState extends ConsumerState<_BusinessLogoSection> {
  bool _picking = false;

  Future<void> _pick() async {
    setState(() => _picking = true);
    try {
      final message = await pickAndSaveLocalImage(ref, 'business_logo', savedMessage: 'Business logo saved');
      if (message != null && mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = ref.watch(businessLogoProvider).valueOrNull;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: scheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: logo == null
                  ? Icon(Icons.add_photo_alternate_outlined, color: scheme.onSurfaceVariant)
                  : Image.file(logo, key: ValueKey(logo.path), fit: BoxFit.contain),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Business logo', style: textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    logo == null ? 'Shown at the top of your invoices' : 'Printed on invoices from this phone',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      AppButton(
                        label: logo == null ? 'Upload' : 'Replace',
                        icon: Icons.upload_outlined,
                        size: AppButtonSize.compact,
                        variant: AppButtonVariant.secondary,
                        expand: false,
                        isLoading: _picking,
                        onPressed: _pick,
                      ),
                      if (logo != null)
                        AppButton(
                          label: 'Remove',
                          size: AppButtonSize.compact,
                          variant: AppButtonVariant.tertiary,
                          expand: false,
                          onPressed: () => confirmAndDelete(
                            context,
                            title: 'Remove business logo?',
                            message: 'Invoices will be printed without a logo.',
                            successMessage: 'Business logo removed',
                            onDelete: () => ref.read(businessLogoProvider.notifier).remove(),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
