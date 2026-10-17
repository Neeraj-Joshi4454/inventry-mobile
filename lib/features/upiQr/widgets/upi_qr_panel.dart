import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/storage/local_image_provider.dart';

/// Shown on New Sale when UPI is the payment mode: the business's saved QR
/// and the amount to collect. Tap to show it full screen for the customer.
/// If no QR has been uploaded, links to the settings page instead.
class UpiQrPanel extends ConsumerWidget {
  const UpiQrPanel({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrAsync = ref.watch(upiQrProvider);
    final qr = qrAsync.valueOrNull;
    final textTheme = Theme.of(context).textTheme;

    if (qrAsync.isLoading && qr == null) {
      return const SizedBox(height: 64, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    if (qr == null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.qr_code_2),
          title: const Text('No UPI QR code uploaded'),
          subtitle: const Text('Add your QR so customers can scan and pay'),
          trailing: TextButton(onPressed: () => context.push('/settings/upi-qr'), child: const Text('Add')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Text('Scan to pay', style: textTheme.titleSmall),
            const SizedBox(height: 2),
            Text(Formatters.currency(amount), style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
            Semantics(
              button: true,
              label: 'UPI QR code, tap to enlarge',
              child: GestureDetector(
                onTap: () => _showFullScreen(context, qr.path),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220, maxHeight: 260),
                  child: Image.file(qr, key: ValueKey(qr.path), fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Tap the QR to enlarge it for the customer', style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  void _showFullScreen(BuildContext context, String path) {
    final file = File(path);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pay ${Formatters.currency(amount)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              const SizedBox(height: AppSpacing.md),
              Flexible(
                child: InteractiveViewer(child: Image.file(file, fit: BoxFit.contain)),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}
