import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/inventory_item.dart';
import '../providers/inventory_providers.dart';
import 'stock_status_chip.dart';
import '../../../core/widgets/brand_app_bar.dart';

/// Pushes a full-screen product picker and resolves with the product the
/// user tapped (or null if they backed out). Shared by Create Sale, Create
/// Purchase and others — all need "search for a product, see its current
/// stock before committing to a quantity" as a self-contained step.
/// [inStockOnly] limits the list to products with stock on hand, so a sale
/// offers exactly what has been purchased into inventory.
Future<InventoryItem?> pickProduct(
  BuildContext context, {
  Set<String> excludeProductIds = const {},
  bool inStockOnly = false,
}) {
  return Navigator.of(context).push<InventoryItem>(
    MaterialPageRoute(
      builder: (_) => ProductPickerPage(excludeProductIds: excludeProductIds, inStockOnly: inStockOnly),
    ),
  );
}

class ProductPickerPage extends ConsumerStatefulWidget {
  const ProductPickerPage({super.key, this.excludeProductIds = const {}, this.inStockOnly = false});

  final Set<String> excludeProductIds;
  final bool inStockOnly;

  @override
  ConsumerState<ProductPickerPage> createState() => _ProductPickerPageState();
}

class _ProductPickerPageState extends ConsumerState<ProductPickerPage> {
  final _searchController = TextEditingController();
  List<InventoryItem>? _results;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await ref.read(inventoryApiProvider).listInventory(search: query, inStockOnly: widget.inStockOnly);
      if (!mounted) return;
      setState(() {
        _results = result.items.where((i) => !widget.excludeProductIds.contains(i.productId)).toList();
        _isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(title: const Text('Select Product')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Search for a product', prefixIcon: Icon(Icons.search)),
              onSubmitted: _search,
              onChanged: (value) {
                if (value.isEmpty) _search('');
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const LoadingIndicator()
                : _error != null
                ? Center(child: Text(_error!))
                : (_results == null || _results!.isEmpty)
                ? EmptyState(
                    icon: Icons.search_off,
                    title: widget.inStockOnly ? 'No products in stock' : 'No products found',
                  )
                : ListView.separated(
                    itemCount: _results!.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _results![index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.sku),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${Formatters.quantity(item.currentStock)} ${item.unit.symbol}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            StockStatusChip(status: item.status),
                          ],
                        ),
                        onTap: () => Navigator.of(context).pop(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
