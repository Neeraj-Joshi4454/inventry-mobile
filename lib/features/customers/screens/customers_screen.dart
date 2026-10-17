import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/search_input.dart';
import '../providers/customer_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
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
      ref.read(customerListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerListProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Customers')),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () async {
          await context.push('/customers/new');
        },
        icon: const Icon(Icons.person_add_alt_outlined),
        label: const Text('Add Customer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: SearchInput(
              controller: _searchController,
              hintText: 'Search by name',
              onChanged: (value) => ref.read(customerListProvider.notifier).setSearch(value),
            ),
          ),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(CustomerListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(customerListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.people_outline,
        title: 'No customers yet',
        description: 'Add a customer to start creating sales for them.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(customerListProvider.notifier).refresh(),
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
          final customer = state.items[index];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.mobileNumber ?? customer.email ?? 'No contact info'),
            trailing: customer.isActive
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
            onTap: () => context.push('/customers/${customer.id}'),
          );
        },
      ),
    );
  }
}
