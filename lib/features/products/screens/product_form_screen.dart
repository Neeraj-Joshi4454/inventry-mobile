import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/confirm_delete.dart';
import '../../../core/widgets/empty_state.dart';
import '../data/models/category.dart';
import '../data/models/product.dart';
import '../data/models/unit.dart';
import '../providers/product_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/utils/page_padding.dart';

/// Handles both "add" (existing == null) and "edit" (existing != null) —
/// same fields, same validation, just a different submit action and title.
/// Mirrors customers/screens/customer_form_screen.dart's add/edit shape.
class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.existing});

  final Product? existing;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.existing?.name);
  late final _skuController = TextEditingController(text: widget.existing?.sku);
  late final _minStockController = TextEditingController(text: widget.existing?.lowStockThreshold.toString());
  late final _descriptionController = TextEditingController(text: widget.existing?.description);
  late final _hsnCodeController = TextEditingController(text: widget.existing?.hsnCode);

  ProductCategory? _selectedCategory;
  ProductUnit? _selectedUnit;
  bool _prefilledPickers = false;

  bool get _isEdit => widget.existing != null;

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _minStockController.dispose();
    _descriptionController.dispose();
    _hsnCodeController.dispose();
    super.dispose();
  }

  /// Category/unit start as bare ids on [widget.existing] (see Product.fromJson);
  /// once the picker lists load we resolve the matching full objects so the
  /// picker rows can show a name instead of "Tap to select".
  void _prefillPickersIfNeeded(List<ProductCategory> categories, List<ProductUnit> units) {
    if (_prefilledPickers || widget.existing == null) return;
    _prefilledPickers = true;
    final existingCategoryId = widget.existing!.category.id;
    final existingUnitId = widget.existing!.unit.id;
    for (final category in categories) {
      if (category.id == existingCategoryId) {
        _selectedCategory = category;
        break;
      }
    }
    for (final unit in units) {
      if (unit.id == existingUnitId) {
        _selectedUnit = unit;
        break;
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    if (_selectedUnit == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a unit')));
      return;
    }

    final controller = ref.read(productFormControllerProvider.notifier);
    final name = _nameController.text.trim();
    final sku = _skuController.text.trim();
    final minStock = double.parse(_minStockController.text);
    final description = _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim();
    final hsnCode = _hsnCodeController.text.trim().isEmpty ? null : _hsnCodeController.text.trim();

    final success = _isEdit
        ? await controller.editProduct(
            widget.existing!.id,
            name: name,
            sku: sku,
            categoryId: _selectedCategory!.id,
            unitId: _selectedUnit!.id,
            lowStockThreshold: minStock,
            description: description,
            hsnCode: hsnCode,
          )
        : (await controller.create(
                name: name,
                sku: sku,
                categoryId: _selectedCategory!.id,
                unitId: _selectedUnit!.id,
                lowStockThreshold: minStock,
                description: description,
                hsnCode: hsnCode,
              )) !=
              null;

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEdit ? 'Product updated successfully' : 'Product created successfully')),
      );
      context.pop();
    } else {
      final error = ref.read(productFormControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productFormControllerProvider);
    final isSubmitting = state.isLoading;
    final categoriesAsync = ref.watch(categoriesProvider);
    final unitsAsync = ref.watch(unitsProvider);

    categoriesAsync.whenData((categories) {
      unitsAsync.whenData((units) => _prefillPickersIfNeeded(categories, units));
    });

    return Scaffold(
      appBar: BrandAppBar(title: Text(_isEdit ? 'Edit Product' : 'Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: pagePadding(context),
          children: [
            AppTextField(
              label: 'Product Name *',
              controller: _nameController,
              enabled: !isSubmitting,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Product name is required' : null,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'SKU / Product Code *',
              controller: _skuController,
              enabled: !isSubmitting,
              textCapitalization: TextCapitalization.characters,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'SKU is required' : null,
            ),
            const SizedBox(height: 12),
            _CategoryPicker(
              categoriesAsync: categoriesAsync,
              selected: _selectedCategory,
              enabled: !isSubmitting,
              onSelected: (c) => setState(() => _selectedCategory = c),
              onDeleted: (id) {
                if (_selectedCategory?.id == id) setState(() => _selectedCategory = null);
              },
            ),
            const SizedBox(height: 12),
            _UnitPicker(
              unitsAsync: unitsAsync,
              selected: _selectedUnit,
              enabled: !isSubmitting,
              onSelected: (u) => setState(() => _selectedUnit = u),
              onDeleted: (id) {
                if (_selectedUnit?.id == id) setState(() => _selectedUnit = null);
              },
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Minimum Stock Level *',
              controller: _minStockController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              enabled: !isSubmitting,
              validator: (v) {
                final parsed = double.tryParse(v ?? '');
                if (parsed == null || parsed < 0) {
                  return 'Enter a minimum stock level of zero or more';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            AppTextField(label: 'Description', controller: _descriptionController, enabled: !isSubmitting),
            const SizedBox(height: 12),
            AppTextField(
              label: 'HSN / SAC Code',
              controller: _hsnCodeController,
              enabled: !isSubmitting,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: _isEdit ? 'Save Changes' : 'Save Product',
              isLoading: isSubmitting,
              onPressed: isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPicker extends ConsumerWidget {
  const _CategoryPicker({
    required this.categoriesAsync,
    required this.selected,
    required this.enabled,
    required this.onSelected,
    required this.onDeleted,
  });

  final AsyncValue<List<ProductCategory>> categoriesAsync;
  final ProductCategory? selected;
  final bool enabled;
  final ValueChanged<ProductCategory> onSelected;
  final ValueChanged<String> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.category_outlined),
        title: const Text('Category *'),
        subtitle: Text(selected?.name ?? 'Tap to select a category'),
        trailing: const Icon(Icons.chevron_right),
        onTap: enabled ? () => _showPicker(context, ref) : null,
      ),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Category', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                categoriesAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => Text('$error'),
                  data: (categories) {
                    if (categories.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: EmptyState(
                          icon: Icons.category_outlined,
                          title: 'No categories yet',
                          description: 'Add one below to continue.',
                        ),
                      );
                    }
                    return Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final category in categories)
                            ListTile(
                              title: Text(category.name),
                              trailing: PickerDeleteButton(
                                tooltip: 'Delete category',
                                onPressed: () {
                                  Navigator.of(sheetContext).pop();
                                  _delete(context, ref, category);
                                },
                              ),
                              onTap: () {
                                onSelected(category);
                                Navigator.of(sheetContext).pop();
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _showAddDialog(context, ref);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Category'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, ProductCategory category) async {
    final deleted = await confirmAndDelete(
      context,
      title: 'Delete category?',
      message: '"${category.name}" will be removed from the category list.',
      successMessage: 'Category deleted',
      onDelete: () async {
        await ref.read(productApiProvider).deleteCategory(category.id);
        ref.invalidate(categoriesProvider);
      },
    );
    if (deleted) onDeleted(category.id);
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Category'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                final navigator = Navigator.of(dialogContext);
                final messenger = ScaffoldMessenger.of(context);
                final category = await ref.read(categoryFormControllerProvider.notifier).create(name);
                if (category != null) {
                  onSelected(category);
                  navigator.pop();
                } else {
                  final error = ref.read(categoryFormControllerProvider).error;
                  messenger.showSnackBar(
                    SnackBar(content: Text(error is ApiException ? error.message : 'Failed to create category')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class _UnitPicker extends ConsumerWidget {
  const _UnitPicker({
    required this.unitsAsync,
    required this.selected,
    required this.enabled,
    required this.onSelected,
    required this.onDeleted,
  });

  final AsyncValue<List<ProductUnit>> unitsAsync;
  final ProductUnit? selected;
  final bool enabled;
  final ValueChanged<ProductUnit> onSelected;
  final ValueChanged<String> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.straighten_outlined),
        title: const Text('Unit *'),
        subtitle: Text(selected != null ? '${selected!.name} (${selected!.symbol})' : 'Tap to select a unit'),
        trailing: const Icon(Icons.chevron_right),
        onTap: enabled ? () => _showPicker(context, ref) : null,
      ),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Unit', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                unitsAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => Text('$error'),
                  data: (units) {
                    if (units.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: EmptyState(
                          icon: Icons.straighten_outlined,
                          title: 'No units yet',
                          description: 'Add one below to continue.',
                        ),
                      );
                    }
                    return Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final unit in units)
                            ListTile(
                              title: Text(unit.name),
                              subtitle: Text(unit.symbol),
                              trailing: PickerDeleteButton(
                                tooltip: 'Delete unit',
                                onPressed: () {
                                  Navigator.of(sheetContext).pop();
                                  _delete(context, ref, unit);
                                },
                              ),
                              onTap: () {
                                onSelected(unit);
                                Navigator.of(sheetContext).pop();
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _showAddDialog(context, ref);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Unit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, ProductUnit unit) async {
    final deleted = await confirmAndDelete(
      context,
      title: 'Delete unit?',
      message: '"${unit.name}" will be removed from the unit list.',
      successMessage: 'Unit deleted',
      onDelete: () async {
        await ref.read(productApiProvider).deleteUnit(unit.id);
        ref.invalidate(unitsProvider);
      },
    );
    if (deleted) onDeleted(unit.id);
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final symbolController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Unit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Unit Name (e.g. Litre)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: symbolController,
                decoration: const InputDecoration(labelText: 'Symbol (e.g. ltr)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final symbol = symbolController.text.trim();
                if (name.isEmpty || symbol.isEmpty) return;
                final navigator = Navigator.of(dialogContext);
                final messenger = ScaffoldMessenger.of(context);
                final unit = await ref.read(unitFormControllerProvider.notifier).create(name: name, symbol: symbol);
                if (unit != null) {
                  onSelected(unit);
                  navigator.pop();
                } else {
                  final error = ref.read(unitFormControllerProvider).error;
                  messenger.showSnackBar(
                    SnackBar(content: Text(error is ApiException ? error.message : 'Failed to create unit')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
