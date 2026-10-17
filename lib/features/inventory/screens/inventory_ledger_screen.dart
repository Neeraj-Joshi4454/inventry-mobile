import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/models/inventory_transaction.dart';
import '../providers/inventory_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class InventoryLedgerScreen extends ConsumerStatefulWidget {
  const InventoryLedgerScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<InventoryLedgerScreen> createState() => _InventoryLedgerScreenState();
}

class _InventoryLedgerScreenState extends ConsumerState<InventoryLedgerScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(ledgerProvider(widget.productId).notifier).loadMore();
    }
  }

  Future<void> _pickDateRange() async {
    final notifier = ref.read(ledgerProvider(widget.productId).notifier);
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) {
      notifier.setDateRange(range.start, range.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ledgerProvider(widget.productId));
    final notifier = ref.read(ledgerProvider(widget.productId).notifier);
    final hasActiveFilters = state.type != null || state.fromDate != null;

    return Scaffold(
      appBar: BrandAppBar(
        title: Text(state.productName ?? 'Inventory Ledger'),
        actions: [
          IconButton(
            icon: Icon(hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(context, notifier, state),
          ),
        ],
      ),
      body: Column(
        children: [
          if (hasActiveFilters)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: notifier.clearFilters,
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Clear filters'),
                ),
              ),
            ),
          const Padding(padding: EdgeInsets.fromLTRB(16, 8, 16, 4), child: _LedgerHeaderRow()),
          const Divider(height: 1),
          Expanded(child: _buildBody(state, notifier)),
        ],
      ),
    );
  }

  Widget _buildBody(LedgerState state, LedgerNotifier notifier) {
    if (state.isLoading && state.entries.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.entries.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.entries.isEmpty) {
      return const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No stock movements yet',
        description: 'Purchases and sales will appear here.',
      );
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: state.entries.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index >= state.entries.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }
          return _LedgerRow(entry: state.entries[index]);
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context, LedgerNotifier notifier, LedgerState state) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter Ledger', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Types'),
                      selected: state.type == null,
                      onSelected: (_) {
                        notifier.setType(null);
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                    for (final type in InventoryTransactionType.filterable)
                      ChoiceChip(
                        label: Text(type.label),
                        selected: state.type == type,
                        onSelected: (_) {
                          notifier.setType(type);
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _pickDateRange();
                  },
                  icon: const Icon(Icons.date_range_outlined),
                  label: const Text('Choose Date Range'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LedgerHeaderRow extends StatelessWidget {
  const _LedgerHeaderRow();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5));
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Type / Date', style: style)),
        Expanded(
          flex: 2,
          child: Text('In', textAlign: TextAlign.right, style: style),
        ),
        Expanded(
          flex: 2,
          child: Text('Out', textAlign: TextAlign.right, style: style),
        ),
        Expanded(
          flex: 2,
          child: Text('Balance', textAlign: TextAlign.right, style: style),
        ),
      ],
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.entry});

  final InventoryLedgerEntry entry;

  @override
  Widget build(BuildContext context) {
    final inValue = entry.type.isIncrease ? entry.quantity : 0;
    final outValue = entry.type.isIncrease ? 0 : entry.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.type.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(Formatters.date(entry.createdAt), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              inValue > 0 ? '+${Formatters.quantity(inValue)}' : '—',
              textAlign: TextAlign.right,
              style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              outValue > 0 ? '-${Formatters.quantity(outValue)}' : '—',
              textAlign: TextAlign.right,
              style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Formatters.quantity(entry.resultingStock),
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
