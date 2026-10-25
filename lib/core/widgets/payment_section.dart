import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../utils/formatters.dart';
import 'filter_chip_bar.dart';
import 'status_badge.dart';

/// How a sale or purchase is being settled. Deliberately has no default on
/// either form: the user must choose, so nothing is silently saved as
/// credit.
enum PaymentType {
  /// Paid in full now — the amount paid is the grand total.
  direct,

  /// Paid later; an optional advance can be paid now.
  credit,
}

/// Ways money can actually change hands. Credit is a payment type, not a
/// payment mode, so it's deliberately absent here.
const paymentModes = ['CASH', 'UPI', 'BANK_TRANSFER', 'CARD'];

String paymentModeLabel(String mode) => switch (mode) {
  'CASH' => 'Cash',
  'UPI' => 'UPI',
  'BANK_TRANSFER' => 'Bank transfer',
  'CARD' => 'Card',
  'CREDIT' => 'Credit',
  _ => mode,
};

/// Money paid now: the full total for a direct settlement, the advance
/// (possibly zero) for credit.
double paidNow(PaymentType? type, {required double grandTotal, required double advance}) => switch (type) {
  PaymentType.direct => grandTotal > 0 ? grandTotal : 0,
  PaymentType.credit => advance,
  null => 0,
};

/// Live preview of the status the backend will save — mirrors
/// sale.service.ts / purchase.service.ts. [unpaidStatus] is CREDIT for a
/// sale and UNPAID for a purchase.
String previewStatusFor({required double paid, required double remaining, required String unpaidStatus}) {
  if (paid <= 0) return unpaidStatus;
  if (remaining <= 0.005) return 'PAID';
  return 'PARTIAL';
}

/// Payment step shared by New Sale and New Purchase: a required choice
/// between direct (paid in full) and credit, then the details that choice
/// needs — payment mode and transaction reference for money paid, and an
/// optional advance plus the amount still due for credit.
class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
    required this.noun,
    required this.question,
    required this.directSubtitle,
    required this.creditSubtitle,
    required this.paidLabel,
    required this.dueLabel,
    required this.type,
    required this.onTypeChanged,
    required this.grandTotal,
    required this.paidAmount,
    required this.remainingAmount,
    required this.previewStatus,
    required this.advanceExceedsTotal,
    required this.advanceController,
    required this.onAdvanceChanged,
    required this.paymentMode,
    required this.onModeChanged,
    required this.referenceController,
    required this.onReferenceChanged,
    this.modeDetails,
  });

  /// "sale" or "purchase" — names the two options ("Direct sale").
  final String noun;
  final String question;
  final String directSubtitle;
  final String creditSubtitle;

  /// e.g. "received" for a sale, "paid" for a purchase.
  final String paidLabel;

  /// e.g. "Amount due from customer" / "Amount due to supplier".
  final String dueLabel;

  final PaymentType? type;
  final ValueChanged<PaymentType> onTypeChanged;
  final double grandTotal;
  final double paidAmount;
  final double remainingAmount;
  final String previewStatus;
  final bool advanceExceedsTotal;
  final TextEditingController advanceController;
  final ValueChanged<double> onAdvanceChanged;
  final String paymentMode;
  final ValueChanged<String> onModeChanged;
  final TextEditingController referenceController;
  final ValueChanged<String> onReferenceChanged;

  /// Extra content under the chosen mode (the sale screen shows its own
  /// UPI QR / bank details for the customer to pay into).
  final Widget? Function(String mode, double amount)? modeDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final payingNow = paidAmount > 0;
    final details = type != null && payingNow ? modeDetails?.call(paymentMode, paidAmount) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text('Payment', style: textTheme.titleMedium)),
            if (type != null) PaymentStatusBadge(status: previewStatus),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(question, style: textTheme.bodySmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PaymentTypeOption(
                icon: Icons.payments_outlined,
                title: 'Direct $noun',
                subtitle: directSubtitle,
                selected: type == PaymentType.direct,
                onTap: () => onTypeChanged(PaymentType.direct),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _PaymentTypeOption(
                icon: Icons.schedule_outlined,
                title: 'Credit $noun',
                subtitle: creditSubtitle,
                selected: type == PaymentType.credit,
                onTap: () => onTypeChanged(PaymentType.credit),
              ),
            ),
          ],
        ),
        if (type == PaymentType.credit) ...[
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: advanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Advance $paidLabel now (optional)',
              prefixText: '₹ ',
              helperText: advanceExceedsTotal ? null : 'Leave empty if nothing is paid today',
              errorText: advanceExceedsTotal ? 'Advance cannot be more than the grand total' : null,
            ),
            onChanged: (value) => onAdvanceChanged(double.tryParse(value) ?? 0),
          ),
        ],
        if (type != null && payingNow) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(type == PaymentType.direct ? 'Payment mode' : 'Advance paid via', style: textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final mode in paymentModes)
                AppFilterChip(
                  label: paymentModeLabel(mode),
                  selected: paymentMode == mode,
                  onSelected: () => onModeChanged(mode),
                ),
            ],
          ),
          if (details != null) ...[const SizedBox(height: AppSpacing.md), details],
          if (paymentMode != 'CASH') ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: referenceController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: _referenceLabel(paymentMode)),
              onChanged: onReferenceChanged,
            ),
          ],
        ],
        if (type != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  _AmountRow(label: 'Grand Total', value: grandTotal),
                  _AmountRow(
                    label: type == PaymentType.direct ? 'Amount $paidLabel' : 'Advance $paidLabel',
                    value: paidAmount,
                  ),
                  const Divider(height: 20),
                  _AmountDueRow(amount: remainingAmount, dueLabel: dueLabel),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  static String _referenceLabel(String mode) => switch (mode) {
    'UPI' => 'UPI transaction ID (optional)',
    'BANK_TRANSFER' => 'UTR / bank reference (optional)',
    'CARD' => 'Card slip / approval no. (optional)',
    _ => 'Reference (optional)',
  };
}

class _PaymentTypeOption extends StatelessWidget {
  const _PaymentTypeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(AppRadius.lg);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: selected ? scheme.primary : scheme.outlineVariant, width: selected ? 1.5 : 1),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: AppSizes.icon,
                      color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
                    ),
                    const Spacer(),
                    Icon(
                      selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      size: AppSizes.iconSm,
                      color: selected ? scheme.primary : scheme.outline,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(Formatters.currency(value), style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _AmountDueRow extends StatelessWidget {
  const _AmountDueRow({required this.amount, required this.dueLabel});

  final double amount;
  final String dueLabel;

  @override
  Widget build(BuildContext context) {
    final due = amount > 0.005;
    return Row(
      children: [
        Expanded(
          child: Text(
            due ? dueLabel : 'Amount due',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        Text(
          Formatters.currency(amount),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: due ? AppColors.warning : AppColors.success,
          ),
        ),
      ],
    );
  }
}
