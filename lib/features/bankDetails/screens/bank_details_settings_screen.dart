import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/bank_details.dart';
import '../providers/bank_details_provider.dart';

/// Settings → Bank details. Shown on New Sale when Bank transfer is chosen.
class BankDetailsSettingsScreen extends ConsumerStatefulWidget {
  const BankDetailsSettingsScreen({super.key});

  @override
  ConsumerState<BankDetailsSettingsScreen> createState() => _BankDetailsSettingsScreenState();
}

class _BankDetailsSettingsScreenState extends ConsumerState<BankDetailsSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _holder = TextEditingController();
  final _bank = TextEditingController();
  final _account = TextEditingController();
  final _confirmAccount = TextEditingController();
  final _ifsc = TextEditingController();
  final _branch = TextEditingController();
  bool _prefilled = false;
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_holder, _bank, _account, _confirmAccount, _ifsc, _branch]) {
      c.dispose();
    }
    super.dispose();
  }

  void _prefill(BankDetails? details) {
    if (_prefilled) return;
    _prefilled = true;
    if (details == null) return;
    _holder.text = details.accountHolderName;
    _bank.text = details.bankName;
    _account.text = details.accountNumber;
    _confirmAccount.text = details.accountNumber;
    _ifsc.text = details.ifsc;
    _branch.text = details.branch ?? '';
  }

  String? _required(String? v, String what) => (v == null || v.trim().isEmpty) ? '$what is required' : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await ref
        .read(bankDetailsProvider.notifier)
        .save(
          BankDetails(
            accountHolderName: _holder.text.trim(),
            bankName: _bank.text.trim(),
            accountNumber: _account.text.trim(),
            ifsc: _ifsc.text.trim().toUpperCase(),
            branch: _branch.text.trim().isEmpty ? null : _branch.text.trim(),
          ),
        );
    if (!mounted) return;
    setState(() => _saving = false);
    final failed = ref.read(bankDetailsProvider).hasError;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(failed ? 'Could not save bank details' : 'Bank details saved')));
  }

  @override
  Widget build(BuildContext context) {
    final detailsAsync = ref.watch(bankDetailsProvider);

    return Scaffold(
      appBar: const BrandAppBar(title: Text('Bank details')),
      body: detailsAsync.isLoading && !_prefilled
          ? const LoadingIndicator()
          : Builder(
              builder: (context) {
                _prefill(detailsAsync.valueOrNull);
                final saved = detailsAsync.valueOrNull;
                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      Text(
                        'Shown to customers on New Sale when they pay by bank transfer. '
                        'Stored securely on this phone only.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        label: 'Account holder name',
                        controller: _holder,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => _required(v, 'Account holder name'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Bank name',
                        controller: _bank,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => _required(v, 'Bank name'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Account number',
                        controller: _account,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(18)],
                        validator: (v) {
                          final value = v?.trim() ?? '';
                          if (value.isEmpty) return 'Account number is required';
                          if (value.length < 9) return 'Account number looks too short';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Confirm account number',
                        controller: _confirmAccount,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(18)],
                        validator: (v) =>
                            (v?.trim() ?? '') == _account.text.trim() ? null : 'Account numbers do not match',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'IFSC code',
                        controller: _ifsc,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [LengthLimitingTextInputFormatter(11)],
                        validator: (v) {
                          final value = (v ?? '').trim().toUpperCase();
                          if (value.isEmpty) return 'IFSC code is required';
                          return BankDetails.ifscPattern.hasMatch(value)
                              ? null
                              : 'Enter a valid IFSC (e.g. HDFC0001234)';
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Branch (optional)',
                        controller: _branch,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppButton(label: 'Save bank details', isLoading: _saving, onPressed: _save),
                      if (saved != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          label: 'Remove bank details',
                          variant: AppButtonVariant.tertiary,
                          onPressed: () async {
                            final removed = await confirmAndDelete(
                              context,
                              title: 'Remove bank details?',
                              message: 'They will no longer appear when a customer pays by bank transfer.',
                              successMessage: 'Bank details removed',
                              onDelete: () => ref.read(bankDetailsProvider.notifier).remove(),
                            );
                            if (removed) {
                              for (final c in [_holder, _bank, _account, _confirmAccount, _ifsc, _branch]) {
                                c.clear();
                              }
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}
