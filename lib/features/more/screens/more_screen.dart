import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/settings_list.dart';
import '../../../core/widgets/status_badge.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/auth_state.dart';
import '../../notifications/providers/notification_providers.dart';
import '../../../core/widgets/brand_app_bar.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };

    return Scaffold(
      appBar: BrandAppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xl),
        children: [
          if (user != null) ...[_ProfileHeader(name: user.name, mobileNumber: user.mobileNumber, role: user.role)],
          const SizedBox(height: AppSpacing.xl),
          SettingsGroup(
            title: 'Business',
            children: [
              SettingsListItem(icon: Icons.people_outline, title: 'Customers', onTap: () => context.push('/customers')),
              SettingsListItem(
                icon: Icons.local_shipping_outlined,
                title: 'Suppliers',
                onTap: () => context.push('/suppliers'),
              ),
              SettingsListItem(
                icon: Icons.request_quote_outlined,
                title: 'Expenses',
                onTap: () => context.push('/expenses'),
              ),
              SettingsListItem(icon: Icons.bar_chart_outlined, title: 'Reports', onTap: () => context.push('/reports')),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SettingsGroup(
            title: 'Settings & data',
            children: [
              SettingsListItem(
                icon: Icons.percent_outlined,
                title: 'Tax settings',
                onTap: () => context.push('/taxes'),
              ),
              SettingsListItem(
                icon: Icons.storefront_outlined,
                title: 'Business settings',
                onTap: () => context.push('/business-settings'),
              ),
              SettingsListItem(
                icon: Icons.qr_code_2,
                title: 'UPI QR code',
                subtitle: 'Shown to customers when they pay by UPI',
                onTap: () => context.push('/settings/upi-qr'),
              ),
              SettingsListItem(
                icon: Icons.account_balance_outlined,
                title: 'Bank details',
                subtitle: 'Shown to customers when they pay by bank transfer',
                onTap: () => context.push('/settings/bank-details'),
              ),
              SettingsListItem(
                icon: Icons.download_outlined,
                title: 'Data export',
                onTap: () => context.push('/exports'),
              ),
              SettingsListItem(
                icon: Icons.history_outlined,
                title: 'Audit log',
                onTap: () => context.push('/audit-log'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SettingsGroup(
            title: 'Account',
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final unread = ref.watch(unreadNotificationCountProvider).valueOrNull ?? 0;
                  return SettingsListItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    trailing: unread > 0
                        ? Badge(
                            label: Text(unread > 99 ? '99+' : '$unread'),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            largeSize: 20,
                          )
                        : null,
                    onTap: () => context.push('/notifications'),
                  );
                },
              ),
              SettingsListItem(
                icon: Icons.logout_rounded,
                title: 'Log out',
                destructive: true,
                showChevron: false,
                onTap: () => _confirmLogout(context, ref),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(authNotifierProvider.notifier).logout();
    }
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.mobileNumber, required this.role});

  final String name;
  final String mobileNumber;
  final String role;

  /// "STORE_KEEPER" -> "Store keeper"
  String get _roleLabel {
    final words = role.toLowerCase().split('_');
    final text = words.join(' ');
    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: scheme.primaryContainer,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(mobileNumber, style: textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            StatusBadge(label: _roleLabel, tone: StatusTone.info, showDot: false),
          ],
        ),
      ),
    );
  }
}
