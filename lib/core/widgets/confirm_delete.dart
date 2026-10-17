import 'package:flutter/material.dart';

import '../network/api_exception.dart';
import '../theme/app_colors.dart';

/// Asks for confirmation, runs [onDelete], and reports the outcome in a
/// snackbar. Returns true only when the delete went through — used by the
/// pickers that let users add options inline (category, unit, supplier,
/// customer) so they can remove them the same way.
Future<bool> confirmAndDelete(
  BuildContext context, {
  required String title,
  required String message,
  required String successMessage,
  required Future<void> Function() onDelete,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          style: TextButton.styleFrom(foregroundColor: AppColors.error),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return false;

  final messenger = ScaffoldMessenger.of(context);
  try {
    await onDelete();
    messenger.showSnackBar(SnackBar(content: Text(successMessage)));
    return true;
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
    return false;
  }
}

/// Trailing delete button for a picker row.
class PickerDeleteButton extends StatelessWidget {
  const PickerDeleteButton({super.key, required this.tooltip, required this.onPressed});

  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline, color: AppColors.error),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
