import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/storage/local_image_provider.dart';
import '../../../core/storage/pick_local_image.dart';
import '../../../core/utils/page_padding.dart';

/// Settings → UPI QR code. The owner uploads their payment QR once; the
/// New Sale screen shows it whenever UPI is chosen as the payment mode.
class UpiQrSettingsScreen extends ConsumerStatefulWidget {
  const UpiQrSettingsScreen({super.key});

  @override
  ConsumerState<UpiQrSettingsScreen> createState() => _UpiQrSettingsScreenState();
}

class _UpiQrSettingsScreenState extends ConsumerState<UpiQrSettingsScreen> {
  bool _picking = false;

  Future<void> _pick() async {
    setState(() => _picking = true);
    try {
      final message = await pickAndSaveLocalImage(ref, 'upi_qr', savedMessage: 'UPI QR code saved');
      if (message != null) _showMessage(message);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final qrAsync = ref.watch(upiQrProvider);
    final qr = qrAsync.valueOrNull;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const BrandAppBar(title: Text('UPI QR code')),
      body: ListView(
        padding: pagePadding(context, all: AppSpacing.lg),
        children: [
          Text(
            'Upload the UPI QR code customers scan to pay you. It appears on the New Sale screen when UPI is '
            'selected. The image is stored only on this phone.',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: qrAsync.isLoading && qr == null
                  ? const SizedBox(height: 240, child: Center(child: CircularProgressIndicator()))
                  : qr == null
                  ? const EmptyState(
                      icon: Icons.qr_code_2,
                      title: 'No QR code yet',
                      description: 'Choose the QR image from your photos — e.g. a screenshot from your UPI app.',
                    )
                  : Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320, maxHeight: 360),
                        child: Image.file(qr, key: ValueKey(qr.path), fit: BoxFit.contain),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: qr == null ? 'Upload QR code' : 'Replace QR code',
            icon: Icons.upload_outlined,
            isLoading: _picking,
            onPressed: _pick,
          ),
          if (qr != null) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Remove QR code',
              variant: AppButtonVariant.tertiary,
              onPressed: () => confirmAndDelete(
                context,
                title: 'Remove UPI QR code?',
                message: 'It will no longer appear when you choose UPI on a sale.',
                successMessage: 'UPI QR code removed',
                onDelete: () => ref.read(upiQrProvider.notifier).remove(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
