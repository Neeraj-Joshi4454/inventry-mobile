import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/brand.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../providers/auth_provider.dart';

/// Self-service sign-up for a new business. Collects what the admin panel's
/// "New Business" form does; submitting raises a request that a Super
/// Admin approves or rejects — nothing is signed in from here.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final email = _emailController.text.trim();
      await ref
          .read(authApiProvider)
          .register(
            businessName: _businessNameController.text.trim(),
            ownerName: _ownerNameController.text.trim(),
            mobileNumber: _mobileController.text.trim(),
            email: email.isEmpty ? null : email,
            password: _passwordController.text,
          );
      if (!mounted) return;
      setState(() => _submitted = true);
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register your business')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _submitted ? _buildSubmitted(context) : _buildForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitted(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.mark_email_read_outlined, size: 72, color: AppColors.success),
        const SizedBox(height: 20),
        Text('Request submitted', style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Text(
          'We’ve sent your registration to the ${Brand.appName} team for review. '
          'Once it’s approved you can sign in with ${_mobileController.text.trim()} '
          'and the password you just chose.',
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        AppButton(label: 'Back to Sign In', onPressed: () => context.go(AppRoutes.login)),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final enabled = !_isSubmitting;
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: BrandLogo(size: 72)),
            const SizedBox(height: 16),
            Text(
              'Tell us about your business. An admin will review your request, '
              'and you can sign in once it’s approved.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Business Name',
              controller: _businessNameController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              prefixIcon: Icons.storefront_outlined,
              autofillHints: const [AutofillHints.organizationName],
              enabled: enabled,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your business name' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Owner Name',
              controller: _ownerNameController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              prefixIcon: Icons.person_outline,
              autofillHints: const [AutofillHints.name],
              enabled: enabled,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter the owner’s name' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Mobile Number',
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.phone_outlined,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(13)],
              enabled: enabled,
              validator: Validators.mobileNumber,
            ),
            const SizedBox(height: 4),
            Text(
              'You’ll use this number to sign in.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Email (optional)',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.email_outlined,
              autofillHints: const [AutofillHints.email],
              enabled: enabled,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return null;
                return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value) ? null : 'Enter a valid email';
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.lock_outline_rounded,
              autofillHints: const [AutofillHints.newPassword],
              enabled: enabled,
              validator: Validators.newPassword,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.lock_outline_rounded,
              enabled: enabled,
              validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            AppButton(label: 'Submit Registration', onPressed: _submit, isLoading: _isSubmitting),
            const SizedBox(height: 12),
            TextButton(
              onPressed: enabled ? () => context.go(AppRoutes.login) : null,
              child: const Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
