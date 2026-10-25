import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/tax_config.dart';
import '../providers/tax_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/utils/page_padding.dart';

const _taxTypes = ['CGST_SGST', 'IGST', 'UTGST', 'NO_TAX'];

// Mirrors the backend's GSTIN_REGEX (tax.validators.ts): 2-digit state code
// + 10-character PAN + entity code + 'Z' + checksum — 15 characters.
final _gstinPattern = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$');

String? validateGstin(String? value) {
  final gstin = value?.trim().toUpperCase() ?? '';
  if (gstin.isEmpty) return null;
  if (gstin.length != 15) {
    return 'GSTIN must be 15 characters (e.g. 27ABCDE1234F1Z5)';
  }
  if (!_gstinPattern.hasMatch(gstin)) {
    return 'Invalid GSTIN format (e.g. 27ABCDE1234F1Z5)';
  }
  return null;
}

class TaxSettingsScreen extends ConsumerStatefulWidget {
  const TaxSettingsScreen({super.key});

  @override
  ConsumerState<TaxSettingsScreen> createState() => _TaxSettingsScreenState();
}

class _TaxSettingsScreenState extends ConsumerState<TaxSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gstinController = TextEditingController();
  final _stateController = TextEditingController();
  bool _gstEnabled = false;
  double _defaultTaxRate = 0;
  String _taxType = 'CGST_SGST';
  bool _loaded = false;

  @override
  void dispose() {
    _gstinController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _prefill(TaxConfig config) {
    if (_loaded) return;
    _loaded = true;
    _gstEnabled = config.gstEnabled;
    _gstinController.text = config.gstin ?? '';
    _stateController.text = config.state ?? '';
    _defaultTaxRate = config.defaultTaxRate;
    _taxType = config.taxType;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(taxConfigFormControllerProvider.notifier);
    final success = await controller.saveTaxConfig(
      gstEnabled: _gstEnabled,
      gstin: _gstinController.text.trim().isEmpty ? null : _gstinController.text.trim().toUpperCase(),
      businessState: _stateController.text.trim().isEmpty ? null : _stateController.text.trim(),
      defaultTaxRate: _defaultTaxRate,
      taxType: _taxType,
    );
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tax settings saved')));
    } else {
      final error = ref.read(taxConfigFormControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(taxConfigProvider);
    final formState = ref.watch(taxConfigFormControllerProvider);
    final isSubmitting = formState.isLoading;

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Tax Settings')),
      body: configAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(message: '$error', onRetry: () => ref.invalidate(taxConfigProvider)),
        data: (config) {
          _prefill(config);
          return Form(
            key: _formKey,
            child: ListView(
              padding: pagePadding(context),
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('GST Enabled'),
                  subtitle: const Text('Turn off if this business does not charge GST'),
                  value: _gstEnabled,
                  onChanged: isSubmitting ? null : (value) => setState(() => _gstEnabled = value),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'GSTIN',
                  controller: _gstinController,
                  enabled: !isSubmitting,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9A-Za-z]')),
                    LengthLimitingTextInputFormatter(15),
                    TextInputFormatter.withFunction((_, value) => value.copyWith(text: value.text.toUpperCase())),
                  ],
                  validator: validateGstin,
                ),
                const SizedBox(height: 12),
                AppTextField(label: 'Business State', controller: _stateController, enabled: !isSubmitting),
                const SizedBox(height: 16),
                Text('Default Tax Rate', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final rate in const [0.0, 5.0, 12.0, 18.0, 28.0])
                      ChoiceChip(
                        label: Text('${rate.toStringAsFixed(0)}%'),
                        selected: _defaultTaxRate == rate,
                        onSelected: isSubmitting ? null : (_) => setState(() => _defaultTaxRate = rate),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Tax Type', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final type in _taxTypes)
                      ChoiceChip(
                        label: Text(_taxTypeLabel(type)),
                        selected: _taxType == type,
                        onSelected: isSubmitting ? null : (_) => setState(() => _taxType = type),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'CGST + SGST is used automatically for customers/suppliers in the same '
                  'state as the business; IGST is used automatically for other states. '
                  'This setting is only the fallback when a state is unknown.',
                  style: Theme.of(context).textTheme.bodySmall,
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

  String _taxTypeLabel(String type) {
    return switch (type) {
      'CGST_SGST' => 'CGST + SGST',
      'IGST' => 'IGST',
      'UTGST' => 'UTGST',
      'NO_TAX' => 'No Tax',
      _ => type,
    };
  }
}
