import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../providers/bank_details_provider.dart';

/// Shown on New Sale when Bank transfer is the payment mode: the amount to
/// collect and the business's bank account, with copy buttons for the
/// fields a customer types into their banking app.
class BankDetailsPanel extends ConsumerWidget {
  const BankDetailsPanel({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(bankDetailsProvider);
    final details = detailsAsync.valueOrNull;
    final textTheme = Theme.of(context).textTheme;

    if (detailsAsync.isLoading && details == null) {
      return const SizedBox(height: 64, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }
    if (details == null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.account_balance_outlined),
          title: const Text('No bank details added'),
          subtitle: const Text('Add your account so customers can transfer to it'),
          trailing: TextButton(onPressed: () => context.push('/settings/bank-details'), child: const Text('Add')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('Transfer to', style: textTheme.titleSmall)),
                Text(Formatters.currency(amount), style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _DetailRow(label: 'Account holder', value: details.accountHolderName),
            _DetailRow(label: 'Bank', value: details.bankName),
            _DetailRow(label: 'Account no.', value: details.accountNumber, copyable: true),
            _DetailRow(label: 'IFSC', value: details.ifsc, copyable: true),
            if (details.branch != null) _DetailRow(label: 'Branch', value: details.branch!),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.copyable = false});

  final String label;
  final String value;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: textTheme.bodySmall)),
          Expanded(
            child: SelectableText(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy_rounded, size: 18),
              tooltip: 'Copy $label',
              visualDensity: VisualDensity.compact,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('$label copied')));
              },
            )
          else
            const SizedBox(width: 40),
        ],
      ),
    );
  }
}
