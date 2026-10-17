import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/list_row_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../providers/purchase_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class PurchasesScreen extends ConsumerStatefulWidget {
  const PurchasesScreen({super.key});

  @override
  ConsumerState<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends ConsumerState<PurchasesScreen> {
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
      ref.read(purchaseListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchaseListProvider);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Purchases')),
      floatingActionButton: FloatingActionButton.extended(
        // No hero: bottom-nav tabs stay mounted together, and their FABs would
        // otherwise share the default hero tag and clash on navigation.
        heroTag: null,
        onPressed: () async {
          await context.push('/purchases/new');
          ref.read(purchaseListProvider.notifier).refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('New Purchase'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(PurchaseListState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const ListSkeleton();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: () => ref.read(purchaseListProvider.notifier).refresh());
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.shopping_bag_outlined,
        title: 'No purchases yet',
        description: 'Record a stock-in purchase to see it here.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(purchaseListProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.fabClearance),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.items.length) return const ListLoadingMore();
          final purchase = state.items[index];
          return ListRowCard(
            key: ValueKey(purchase.id),
            title: purchase.purchaseNumber,
            subtitle: '${purchase.supplierName} · ${Formatters.date(purchase.purchaseDate)}',
            onTap: () => context.push('/purchases/${purchase.id}'),
            trailing: _AmountWithStatus(amount: purchase.totalAmount, paymentStatus: purchase.paymentStatus),
          );
        },
      ),
    );
  }
}

class _AmountWithStatus extends StatelessWidget {
  const _AmountWithStatus({required this.amount, required this.paymentStatus});

  final double amount;
  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Formatters.currency(amount),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        PaymentStatusBadge(status: paymentStatus),
      ],
    );
  }
}
