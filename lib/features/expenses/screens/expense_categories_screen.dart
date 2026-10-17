import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/expense_category.dart';
import '../providers/expense_category_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class ExpenseCategoriesScreen extends ConsumerStatefulWidget {
  const ExpenseCategoriesScreen({super.key});

  @override
  ConsumerState<ExpenseCategoriesScreen> createState() => _ExpenseCategoriesScreenState();
}

class _ExpenseCategoriesScreenState extends ConsumerState<ExpenseCategoriesScreen> {
  Future<void> _toggleStatus(ExpenseCategory category) async {
    final success = await ref.read(expenseCategoryListProvider.notifier).setActive(category.id, !category.isActive);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (category.isActive ? 'Category deactivated' : 'Category activated')
              : 'System categories cannot be deactivated',
        ),
      ),
    );
  }

  Future<void> _showEditDialog({ExpenseCategory? existing}) async {
    final nameController = TextEditingController(text: existing?.name);
    final descriptionController = TextEditingController(text: existing?.description);
    final isSystem = existing?.isSystem ?? false;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(existing == null ? 'New Expense Category' : 'Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                enabled: !isSystem,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  helperText: isSystem ? 'System categories cannot be renamed' : null,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description (optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final description = descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim();
                if (name.isEmpty) return;

                final controller = ref.read(expenseCategoryFormControllerProvider.notifier);
                final success = existing == null
                    ? await controller.create(name: name, description: description)
                    : await controller.editCategory(
                        existing.id,
                        name: isSystem ? null : name,
                        description: description,
                      );

                if (!dialogContext.mounted) return;
                if (success) {
                  Navigator.of(dialogContext).pop();
                } else {
                  final error = ref.read(expenseCategoryFormControllerProvider).error;
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')),
                  );
                }
              },
              child: Text(existing == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseCategoryListProvider);
    final notifier = ref.read(expenseCategoryListProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Expense Categories'),
        actions: [
          PopupMenuButton<String>(
            initialValue: state.status,
            onSelected: notifier.setStatusFilter,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'active', child: Text('Active')),
              PopupMenuItem(value: 'inactive', child: Text('Inactive')),
              PopupMenuItem(value: 'all', child: Text('All')),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(state, notifier)),
      floatingActionButton: FloatingActionButton(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () => _showEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(ExpenseCategoryListState state, ExpenseCategoryListNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.category_outlined,
        title: 'No categories',
        description: 'Tap + to add an expense category.',
      );
    }

    return ListView(
      // Bottom padding lets the last row scroll clear of the FAB.
      padding: const EdgeInsets.fromLTRB(16, 16, 16, AppSpacing.fabClearance),
      children: [
        Card(
          child: Column(
            children: [
              for (final category in state.items) ...[
                ListTile(
                  title: Text(category.name),
                  subtitle: Text(
                    category.description?.isNotEmpty == true
                        ? category.description!
                        : (category.isSystem ? 'System category' : 'Custom category'),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!category.isActive)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text('Inactive', style: TextStyle(color: AppColors.error, fontSize: 12)),
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 20),
                        onPressed: () => _showEditDialog(existing: category),
                      ),
                      Switch(
                        value: category.isActive,
                        onChanged: category.isSystem && category.isActive ? null : (_) => _toggleStatus(category),
                      ),
                    ],
                  ),
                ),
                if (category != state.items.last) const Divider(height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
