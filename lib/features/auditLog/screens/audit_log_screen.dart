import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../providers/audit_log_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class AuditLogScreen extends ConsumerStatefulWidget {
  const AuditLogScreen({super.key});

  @override
  ConsumerState<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends ConsumerState<AuditLogScreen> {
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
      ref.read(auditLogListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(auditLogListProvider);
    final notifier = ref.read(auditLogListProvider.notifier);

    return Scaffold(
      appBar: BrandAppBar(title: const Text('Audit Log')),
      body: RefreshIndicator(onRefresh: notifier.refresh, child: _buildBody(state, notifier)),
    );
  }

  Widget _buildBody(AuditLogListState state, AuditLogListNotifier notifier) {
    if (state.isLoading && state.items.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.errorMessage != null && state.items.isEmpty) {
      return ErrorView(message: state.errorMessage!, onRetry: notifier.refresh);
    }
    if (state.items.isEmpty) {
      return const EmptyState(
        icon: Icons.history_outlined,
        title: 'No activity yet',
        description: 'Financial and stock actions will be recorded here.',
      );
    }

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Column(
            children: [
              for (final entry in state.items) ...[
                ListTile(
                  dense: true,
                  title: Text(_actionLabel(entry.action)),
                  subtitle: Text('${entry.entityType} · ${entry.actorRole}'),
                  trailing: Text(Formatters.dateTime(entry.createdAt), style: Theme.of(context).textTheme.bodySmall),
                ),
                if (entry != state.items.last) const Divider(height: 1),
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

  String _actionLabel(String action) {
    return action
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((w) {
          if (w.isEmpty) return w;
          return w[0].toUpperCase() + w.substring(1);
        })
        .join(' ');
  }
}
