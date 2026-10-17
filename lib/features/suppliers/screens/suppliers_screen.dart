import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/filter_chip_bar.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/search_input.dart';
import '../providers/supplier_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class SuppliersScreen extends ConsumerStatefulWidget {
  const SuppliersScreen({super.key});

  @override
  ConsumerState<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends ConsumerState<SuppliersScreen> {
  final _searchController = TextEditingController();
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
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(supplierListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supplierListProvider);
    final notifier = ref.read(supplierListProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Suppliers')),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () async {
          await context.push('/suppliers/new');
        },
        icon: const Icon(Icons.add_business_outlined),
        label: const Text('Add Supplier'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by name',
              onChanged: notifier.setSearch,
            ),
          ),
          FilterChipBar<String>(
            semanticLabel: 'Supplier status filter',
            selected: state.status,
            onSelected: notifier.setStatusFilter,
            options: const [
              FilterOption('active', 'Active'),
              FilterOption('inactive', 'Inactive'),
              FilterOption('all', 'All'),
            ],
          ),
          const Divider(),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(SupplierListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(supplierListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.local_shipping_outlined,
        title: 'No suppliers yet',
        description: 'Add a supplier to start recording purchases from them.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(supplierListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index >= state.items.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }
          final supplier = state.items[index];
          return ListTile(
            title: Text(supplier.name),
            subtitle: Text(supplier.contactPerson ?? supplier.mobileNumber ?? supplier.email ?? 'No contact info'),
            trailing: supplier.isActive
                ? null
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Inactive',
                      style: TextStyle(color: AppColors.error, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
            onTap: () => context.push('/suppliers/${supplier.id}'),
          );
        },
      ),
    );
  }
}
