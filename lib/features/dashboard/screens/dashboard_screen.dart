import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/inline_alert.dart';
import '../../../core/widgets/settings_list.dart';
import '../../../core/widgets/status_badge.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/auth_state.dart';
import '../../notifications/providers/notification_providers.dart';
import '../../reports/providers/report_providers.dart';
import '../../reports/widgets/summary_card.dart';
import '../../../core/widgets/brand_app_bar.dart';

/// Roles the backend lets read the dashboard report
/// (backend/src/modules/reports/report.routes.ts REPORT_ROLES). Other roles
/// don't see the "Today" section at all rather than a permission error.
const _metricsRoles = {'OWNER', 'MANAGER', 'ACCOUNTANT'};

/// Home tab: a compact greeting, stock alerts, today's figures (for roles
/// that can see reports), and quick actions to the most common daily tasks.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };
    final unreadCount = ref.watch(unreadNotificationCountProvider).valueOrNull ?? 0;
    final showMetrics = user != null && _metricsRoles.contains(user.role);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: BrandAppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: unreadCount > 0 ? 'Notifications, $unreadCount unread' : 'Notifications',
            icon: Badge(
              isLabelVisible: unreadCount > 0,
              label: Text(unreadCount > 99 ? '99+' : '$unreadCount'),
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: () => context.push('/notifications'),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(unreadNotificationCountProvider);
          if (showMetrics) ref.invalidate(dashboardSummaryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xl),
          children: [
            Text(
              user != null ? 'Welcome back, ${user.name}' : 'Welcome back',
              style: textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(DateFormat('EEEE, d MMMM').format(DateTime.now()), style: textTheme.bodySmall),
            if (unreadCount > 0) ...[
              const SizedBox(height: AppSpacing.lg),
              InlineAlert(
                icon: Icons.warning_amber_rounded,
                tone: StatusTone.warning,
                title: '$unreadCount stock alert${unreadCount == 1 ? '' : 's'}',
                message: 'Low or out-of-stock products need attention.',
                onTap: () => context.push('/notifications'),
              ),
            ],
            if (showMetrics) ...[
              const SizedBox(height: AppSpacing.xl),
              const _SectionTitle('Today'),
              const _TodaySummary(),
            ],
            const SizedBox(height: AppSpacing.xl),
            const _SectionTitle('Quick actions'),
            SettingsGroup(
              children: [
                SettingsListItem(
                  icon: Icons.point_of_sale_outlined,
                  title: 'Stock Out (New Sale)',
                  subtitle: 'Record a sale and reduce stock',
                  onTap: () => context.push('/sales/new'),
                ),
                SettingsListItem(
                  icon: Icons.add_shopping_cart_outlined,
                  title: 'Stock In (New Purchase)',
                  subtitle: 'Record a purchase and add stock',
                  onTap: () => context.push('/purchases/new'),
                ),
                SettingsListItem(
                  icon: Icons.warehouse_outlined,
                  title: 'View inventory',
                  subtitle: 'Current stock levels for all products',
                  onTap: () => context.go('/inventory'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

/// Today's figures from the existing dashboard report. While loading it
/// shows same-sized placeholders (no layout jump); on error it collapses
/// to a single quiet line rather than a full error screen.
class _TodaySummary extends ConsumerWidget {
  const _TodaySummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    return summaryAsync.when(
      loading: () => const SummaryCardGrid(
        cards: [
          SummaryCard(label: "Today's sales", value: '—', caption: ' '),
          SummaryCard(label: "Today's purchases", value: '—', caption: ' '),
          SummaryCard(label: 'Low stock', value: '—', caption: ' '),
          SummaryCard(label: 'Out of stock', value: '—', caption: ' '),
        ],
      ),
      error: (_, _) =>
          Text("Couldn't load today's figures. Pull down to retry.", style: Theme.of(context).textTheme.bodySmall),
      data: (summary) {
        String invoices(int count) => '$count ${count == 1 ? 'invoice' : 'invoices'}';
        String products(int count) => '$count ${count == 1 ? 'product' : 'products'}';
        return SummaryCardGrid(
          cards: [
            SummaryCard(
              label: "Today's sales",
              value: Formatters.currency(summary.todaysSales.amount),
              caption: invoices(summary.todaysSales.count),
            ),
            SummaryCard(
              label: "Today's purchases",
              value: Formatters.currency(summary.todaysPurchases.amount),
              caption: invoices(summary.todaysPurchases.count),
            ),
            SummaryCard(
              label: 'Low stock',
              value: '${summary.lowStockProducts}',
              caption: products(summary.lowStockProducts),
            ),
            SummaryCard(
              label: 'Out of stock',
              value: '${summary.outOfStockProducts}',
              caption: products(summary.outOfStockProducts),
            ),
          ],
        );
      },
    );
  }
}
