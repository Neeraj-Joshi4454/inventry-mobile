import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/notification_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
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
      ref.read(notificationListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationListProvider);
    final notifier = ref.read(notificationListProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Notifications'),
        actions: [
          if (state.unreadCount > 0) TextButton(onPressed: notifier.markAllRead, child: const Text('Mark all read')),
        ],
      ),
      body: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(state, notifier)),
    );
  }

  Widget _buildBody(NotificationListState state, NotificationListNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.notifications_none,
        title: 'No notifications',
        description: 'Low stock and out-of-stock alerts will appear here.',
      );
    }

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Column(
            children: [
              for (final item in state.items) ...[
                ListTile(
                  leading: Icon(
                    item.type == 'OUT_OF_STOCK' ? Icons.remove_shopping_cart_outlined : Icons.warning_amber_outlined,
                    color: item.type == 'OUT_OF_STOCK' ? AppColors.error : AppColors.warning,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(fontWeight: item.isRead ? FontWeight.normal : FontWeight.w700),
                  ),
                  subtitle: Text('${item.message}\n${Formatters.dateTime(item.createdAt)}'),
                  isThreeLine: true,
                  trailing: item.isRead ? null : const Icon(Icons.circle, size: 10, color: AppColors.primary),
                  onTap: item.isRead ? null : () => notifier.markRead(item.id),
                ),
                if (item != state.items.last) const Divider(height: 1),
              ],
              if (state.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
