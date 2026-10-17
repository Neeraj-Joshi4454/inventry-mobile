import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/expense_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ExpenseDetailScreen extends ConsumerWidget {
  const ExpenseDetailScreen({super.key, required this.expenseId});

  final String expenseId;

  Future<void> _cancelExpense(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel this expense?'),
        content: const Text(
          'The record is kept for your history, but it will no longer count toward totals or reports.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('No')),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel Expense'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final success = await ref.read(expenseFormControllerProvider.notifier).setStatus(expenseId, 'CANCELLED');
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(success ? 'Expense cancelled' : 'Failed to cancel expense')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAsync = ref.watch(expenseDetailProvider(expenseId));

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Expense Details'),
        actions: [
          expenseAsync.maybeWhen(
            data: (expense) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: expense.status == 'CANCELLED'
                  ? null
                  : () => context.push('/expenses/$expenseId/edit', extra: expense),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: expenseAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error is ApiException ? error.message : '$error',
          onRetry: () => ref.invalidate(expenseDetailProvider(expenseId)),
        ),
        data: (expense) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(expense.title, style: Theme.of(context).textTheme.titleLarge)),
                          _StatusChip(status: expense.status),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Formatters.currency(expense.amount),
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                      ),
                      const Divider(height: 24),
                      _InfoRow(icon: Icons.category_outlined, label: 'Category', value: expense.categoryName),
                      _InfoRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Expense Date',
                        value: Formatters.date(expense.expenseDate),
                      ),
                      _InfoRow(icon: Icons.payments_outlined, label: 'Payment Method', value: expense.paymentMethod),
                      _InfoRow(
                        icon: Icons.confirmation_number_outlined,
                        label: 'Reference Number',
                        value: expense.referenceNumber,
                      ),
                      _InfoRow(icon: Icons.notes_outlined, label: 'Notes', value: expense.notes),
                      if (expense.attachmentUrl != null && expense.attachmentUrl!.isNotEmpty)
                        _InfoRow(icon: Icons.attach_file_outlined, label: 'Attachment', value: expense.attachmentUrl),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (expense.createdByName != null)
                Text(
                  'Created by ${expense.createdByName}'
                  '${expense.createdAt != null ? ' on ${Formatters.dateTime(expense.createdAt!)}' : ''}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (expense.updatedByName != null)
                Text('Last updated by ${expense.updatedByName}', style: Theme.of(context).textTheme.bodySmall),
              if (expense.status != 'CANCELLED') ...[
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => _cancelExpense(context, ref),
                  icon: const Icon(Icons.block_outlined),
                  label: const Text('Cancel Expense'),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = status == 'CANCELLED' ? AppColors.error : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
