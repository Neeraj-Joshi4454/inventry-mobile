import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/models/app_notification.dart';
import '../data/notification_api.dart';

final notificationApiProvider = Provider<NotificationApi>((ref) => NotificationApi(ref.watch(dioProvider)));

/// Unread count only — cheap, used for the dashboard badge and the More
/// menu row without pulling the full list.
final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final result = await ref.watch(notificationApiProvider).listNotifications(unreadOnly: true);
  return result.unreadCount;
});

class NotificationListState {
  const NotificationListState({
    this.items = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.page = 1,
  });

  final List<AppNotification> items;
  final int unreadCount;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final int page;

  NotificationListState copyWith({
    List<AppNotification>? items,
    int? unreadCount,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    int? page,
  }) {
    return NotificationListState(
      items: items ?? this.items,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class NotificationListNotifier extends Notifier<NotificationListState> {
  @override
  NotificationListState build() {
    Future.microtask(refresh);
    return const NotificationListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref.read(notificationApiProvider).listNotifications(page: 1);
      state = state.copyWith(
        items: result.notifications,
        unreadCount: result.unreadCount,
        isLoading: false,
        hasMore: result.notifications.length >= 20,
        page: 1,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final result = await ref.read(notificationApiProvider).listNotifications(page: nextPage);
      state = state.copyWith(
        items: [...state.items, ...result.notifications],
        unreadCount: result.unreadCount,
        isLoadingMore: false,
        hasMore: result.notifications.length >= 20,
        page: nextPage,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }

  Future<void> markRead(String id) async {
    try {
      await ref.read(notificationApiProvider).markRead(id);
      await refresh();
      ref.invalidate(unreadNotificationCountProvider);
    } on ApiException {
      // Leave the list as-is; user can retry the tap.
    }
  }

  Future<void> markAllRead() async {
    try {
      await ref.read(notificationApiProvider).markAllRead();
      await refresh();
      ref.invalidate(unreadNotificationCountProvider);
    } on ApiException {
      // Leave the list as-is; user can retry.
    }
  }
}

final notificationListProvider = NotifierProvider<NotificationListNotifier, NotificationListState>(
  NotificationListNotifier.new,
);
