import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/audit_log_api.dart';
import '../data/models/audit_log_entry.dart';

final auditLogApiProvider = Provider<AuditLogApi>((ref) => AuditLogApi(ref.watch(dioProvider)));

class AuditLogListState {
  const AuditLogListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.page = 1,
  });

  final List<AuditLogEntry> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final int page;

  AuditLogListState copyWith({
    List<AuditLogEntry>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    int? page,
  }) {
    return AuditLogListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      page: page ?? this.page,
    );
  }
}

const _unset = Object();

class AuditLogListNotifier extends Notifier<AuditLogListState> {
  @override
  AuditLogListState build() {
    Future.microtask(refresh);
    return const AuditLogListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1);
    try {
      final result = await ref.read(auditLogApiProvider).listAuditLogs(page: 1);
      state = state.copyWith(items: result.items, isLoading: false, hasMore: result.hasNextPage, page: 1);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final result = await ref.read(auditLogApiProvider).listAuditLogs(page: nextPage);
      state = state.copyWith(
        items: [...state.items, ...result.items],
        isLoadingMore: false,
        hasMore: result.hasNextPage,
        page: nextPage,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    }
  }
}

final auditLogListProvider = NotifierProvider<AuditLogListNotifier, AuditLogListState>(AuditLogListNotifier.new);
