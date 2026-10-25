import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/inventory_item.dart';
import '../providers/inventory_providers.dart';
import '../widgets/product_picker_page.dart';
import '../../../core/widgets/brand_app_bar.dart';
import '../../../core/utils/page_padding.dart';

/// Reached either from the Inventory list (no product preselected — the
/// user picks one, seeing its current stock inline) or from a Product
/// Stock Detail screen's "Adjust Stock" button (product already known).
class StockAdjustmentScreen extends ConsumerStatefulWidget {
  const StockAdjustmentScreen({super.key, this.preselectedProductId});

  final String? preselectedProductId;

  @override
  ConsumerState<StockAdjustmentScreen> createState() => _StockAdjustmentScreenState();
}

class _StockAdjustmentScreenState extends ConsumerState<StockAdjustmentScreen> {
  InventoryItem? _selectedProduct;
  bool _pickerLaunched = false;
  String _type = 'OUT';
  final _quantityController = TextEditingController();
  final _reasonController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _launchPicker() async {
    _pickerLaunched = true;
    final picked = await pickProduct(context);
    if (!mounted) return;
    if (picked == null) {
      context.pop();
      return;
    }
    setState(() => _selectedProduct = picked);
  }

  double? get _quantity => double.tryParse(_quantityController.text);

  double get _newStock {
    final product = _selectedProduct;
    final qty = _quantity;
    if (product == null || qty == null) return product?.currentStock ?? 0;
    return _type == 'IN' ? product.currentStock + qty : product.currentStock - qty;
  }

  Future<void> _confirmAndSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final product = _selectedProduct!;
    final qty = _quantity!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Stock Adjustment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _ReviewRow(label: 'Current Stock', value: Formatters.quantity(product.currentStock)),
            _ReviewRow(
              label: 'Adjustment',
              value: '${_type == 'IN' ? '+' : '-'}${Formatters.quantity(qty)}',
              color: _type == 'IN' ? AppColors.success : AppColors.error,
            ),
            const Divider(height: 20),
            _ReviewRow(label: 'New Stock', value: Formatters.quantity(_newStock), emphasize: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Confirm')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await ref
        .read(stockAdjustmentControllerProvider.notifier)
        .submit(
          productId: product.productId,
          type: _type,
          quantity: qty,
          reason: _reasonController.text.trim(),
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );
    if (!mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stock adjusted — new stock: ${Formatters.quantity(result)} ${product.unit.symbol}')),
      );
      context.pop();
    } else {
      final error = ref.read(stockAdjustmentControllerProvider).error;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error is ApiException ? error.message : 'Failed to adjust stock')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.preselectedProductId != null && _selectedProduct == null) {
      final detailAsync = ref.watch(productStockDetailProvider(widget.preselectedProductId!));
      return detailAsync.when(
        loading: () => const Scaffold(body: LoadingIndicator()),
        error: (error, _) => Scaffold(
          appBar: BrandAppBar(title: const Text('Stock Adjustment')),
          body: Center(child: Text('$error')),
        ),
        data: (product) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _selectedProduct = product);
          });
          return const Scaffold(body: LoadingIndicator());
        },
      );
    }

    if (_selectedProduct == null) {
      if (!_pickerLaunched) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _launchPicker());
      }
      return const Scaffold(body: LoadingIndicator());
    }

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Stock Adjustment')),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    final product = _selectedProduct!;
    final controllerState = ref.watch(stockAdjustmentControllerProvider);
    final isSubmitting = controllerState.isLoading;
    final qty = _quantity;
    final wouldGoNegative = _type == 'OUT' && qty != null && qty > product.currentStock;

    return Form(
      key: _formKey,
      child: ListView(
        padding: pagePadding(context),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(product.sku, style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text(
                          'Current Stock: ${Formatters.quantity(product.currentStock)} ${product.unit.symbol}',
                          style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  if (widget.preselectedProductId == null)
                    TextButton(onPressed: _launchPicker, child: const Text('Change')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'IN', label: Text('Adjust IN'), icon: Icon(Icons.add)),
              ButtonSegment(value: 'OUT', label: Text('Adjust OUT'), icon: Icon(Icons.remove)),
            ],
            selected: {_type},
            onSelectionChanged: isSubmitting ? null : (selection) => setState(() => _type = selection.first),
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Quantity (${product.unit.symbol})',
            controller: _quantityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: !isSubmitting,
            validator: (value) {
              final parsed = double.tryParse(value ?? '');
              if (parsed == null || parsed <= 0) {
                return 'Enter a quantity greater than zero';
              }
              return null;
            },
            onFieldSubmitted: (_) => setState(() {}),
          ),
          const SizedBox(height: 4),
          if (wouldGoNegative)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Only ${Formatters.quantity(product.currentStock)} ${product.unit.symbol} available — cannot adjust out ${Formatters.quantity(qty)}.',
                style: const TextStyle(color: AppColors.error, fontSize: 12),
              ),
            ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Reason (e.g. damaged, miscount, physical recount)',
            controller: _reasonController,
            enabled: !isSubmitting,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'A reason is required' : null,
          ),
          const SizedBox(height: 12),
          AppTextField(label: 'Notes (optional)', controller: _notesController, enabled: !isSubmitting),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ReviewRow(
                    label: 'Current Stock',
                    value: '${Formatters.quantity(product.currentStock)} ${product.unit.symbol}',
                  ),
                  _ReviewRow(
                    label: 'Adjustment',
                    value: qty == null
                        ? '—'
                        : '${_type == 'IN' ? '+' : '-'}${Formatters.quantity(qty)} ${product.unit.symbol}',
                    color: qty == null ? null : (_type == 'IN' ? AppColors.success : AppColors.error),
                  ),
                  const Divider(height: 20),
                  _ReviewRow(
                    label: 'New Stock',
                    value: '${Formatters.quantity(_newStock < 0 ? 0 : _newStock)} ${product.unit.symbol}',
                    emphasize: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Confirm Adjustment',
            isLoading: isSubmitting,
            onPressed: wouldGoNegative ? null : _confirmAndSubmit,
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.label, required this.value, this.color, this.emphasize = false});

  final String label;
  final String value;
  final Color? color;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: emphasize ? FontWeight.w700 : FontWeight.w400)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: emphasize ? 16 : 14,
              color: color ?? (emphasize ? AppColors.primary : null),
            ),
          ),
        ],
      ),
    );
  }
}
