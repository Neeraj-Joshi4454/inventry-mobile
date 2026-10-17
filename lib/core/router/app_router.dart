import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/auth_state.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/customers/data/models/customer.dart';
import '../../features/customers/screens/customer_detail_screen.dart';
import '../../features/customers/screens/customer_form_screen.dart';
import '../../features/customers/screens/customers_screen.dart';
import '../../features/suppliers/data/models/supplier.dart';
import '../../features/suppliers/screens/supplier_detail_screen.dart';
import '../../features/suppliers/screens/supplier_form_screen.dart';
import '../../features/suppliers/screens/suppliers_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/expenses/data/models/expense.dart';
import '../../features/expenses/screens/expense_categories_screen.dart';
import '../../features/expenses/screens/expense_detail_screen.dart';
import '../../features/expenses/screens/expense_form_screen.dart';
import '../../features/expenses/screens/expense_summary_screen.dart';
import '../../features/expenses/screens/expenses_screen.dart';
import '../../features/inventory/screens/inventory_ledger_screen.dart';
import '../../features/inventory/screens/inventory_screen.dart';
import '../../features/inventory/screens/product_stock_detail_screen.dart';
import '../../features/inventory/screens/stock_adjustment_screen.dart';
import '../../features/more/screens/more_screen.dart';
import '../../features/products/data/models/product.dart';
import '../../features/products/screens/product_form_screen.dart';
import '../../features/products/screens/products_screen.dart';
import '../../features/purchases/screens/create_purchase_screen.dart';
import '../../features/purchases/screens/purchase_detail_screen.dart';
import '../../features/purchases/screens/purchase_invoice_screen.dart';
import '../../features/purchases/screens/purchases_screen.dart';
import '../../features/reports/screens/expense_report_screen.dart';
import '../../features/reports/screens/inventory_ledger_report_screen.dart';
import '../../features/reports/screens/outstanding_customers_screen.dart';
import '../../features/reports/screens/profit_summary_screen.dart';
import '../../features/reports/screens/purchase_report_screen.dart';
import '../../features/reports/screens/reports_dashboard_screen.dart';
import '../../features/reports/screens/sales_report_screen.dart';
import '../../features/reports/screens/stock_report_screen.dart';
import '../../features/sales/screens/create_sale_screen.dart';
import '../../features/sales/screens/invoice_screen.dart';
import '../../features/sales/screens/sale_detail_screen.dart';
import '../../features/sales/screens/sales_screen.dart';
import '../../features/taxes/screens/tax_settings_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/businessSettings/screens/business_settings_screen.dart';
import '../../features/exports/screens/exports_screen.dart';
import '../../features/auditLog/screens/audit_log_screen.dart';
import '../navigation/main_shell.dart';
import '../widgets/splash_screen.dart';
import '../../features/upiQr/screens/upi_qr_settings_screen.dart';
import '../../features/bankDetails/screens/bank_details_settings_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const products = '/products';
  static const inventory = '/inventory';
  static const purchases = '/purchases';
  static const sales = '/sales';
  static const more = '/more';
}

/// Bridges Riverpod state changes into GoRouter's `refreshListenable`, so
/// the router re-evaluates `redirect` every time [AuthState] changes —
/// without this, a login/logout would update app state but the router
/// would keep showing whatever screen it was already on.
class _AuthRouterRefresh extends ChangeNotifier {
  _AuthRouterRefresh(Ref ref) {
    ref.listen<AuthState>(authNotifierProvider, (_, _) => notifyListeners());
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _AuthRouterRefresh(ref);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      final isSplashRoute = state.matchedLocation == AppRoutes.splash;

      return switch (authState) {
        // Session restoration hasn't resolved yet — stay on the splash
        // screen regardless of where navigation was attempted.
        AuthInitial() || AuthLoading() => isSplashRoute ? null : AppRoutes.splash,

        // Authenticated users never see the splash or login screens.
        AuthAuthenticated() => (isSplashRoute || isLoginRoute) ? AppRoutes.dashboard : null,

        // Unauthenticated (or a failed login attempt) always lands on
        // login — a protected route is never reachable without a session.
        AuthUnauthenticated() || AuthError() => isLoginRoute ? null : AppRoutes.login,
      };
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),

      // Bottom-nav tabs — each branch keeps its own navigation stack.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.dashboard, builder: (context, state) => const DashboardScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.products, builder: (context, state) => const ProductsScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.inventory, builder: (context, state) => const InventoryScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.purchases, builder: (context, state) => const PurchasesScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.sales, builder: (context, state) => const SalesScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.more, builder: (context, state) => const MoreScreen())],
          ),
        ],
      ),

      // Detail/form screens — pushed on top of the shell (covering the
      // bottom nav, as is conventional for a detail/task screen), reachable
      // from any tab via context.push().
      GoRoute(
        path: '/inventory/adjustment',
        builder: (context, state) =>
            StockAdjustmentScreen(preselectedProductId: state.uri.queryParameters['productId']),
      ),
      GoRoute(
        path: '/inventory/:productId',
        builder: (context, state) => ProductStockDetailScreen(productId: state.pathParameters['productId']!),
      ),
      GoRoute(
        path: '/inventory/:productId/ledger',
        builder: (context, state) => InventoryLedgerScreen(productId: state.pathParameters['productId']!),
      ),
      GoRoute(path: '/products/new', builder: (context, state) => const ProductFormScreen()),
      GoRoute(
        path: '/products/:id/edit',
        builder: (context, state) => ProductFormScreen(existing: state.extra as Product?),
      ),
      GoRoute(path: '/purchases/new', builder: (context, state) => const CreatePurchaseScreen()),
      GoRoute(
        path: '/purchases/:id',
        builder: (context, state) => PurchaseDetailScreen(purchaseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/purchases/:id/invoice',
        builder: (context, state) => PurchaseInvoiceScreen(purchaseId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/sales/new', builder: (context, state) => const CreateSaleScreen()),
      GoRoute(
        path: '/sales/:id',
        builder: (context, state) => SaleDetailScreen(saleId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/sales/:id/invoice',
        builder: (context, state) => InvoiceScreen(saleId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/customers', builder: (context, state) => const CustomersScreen()),
      GoRoute(path: '/customers/new', builder: (context, state) => const CustomerFormScreen()),
      GoRoute(
        path: '/customers/:id',
        builder: (context, state) => CustomerDetailScreen(customerId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/customers/:id/edit',
        builder: (context, state) => CustomerFormScreen(existing: state.extra as Customer?),
      ),
      GoRoute(path: '/suppliers', builder: (context, state) => const SuppliersScreen()),
      GoRoute(path: '/suppliers/new', builder: (context, state) => const SupplierFormScreen()),
      GoRoute(
        path: '/suppliers/:id',
        builder: (context, state) => SupplierDetailScreen(supplierId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/suppliers/:id/edit',
        builder: (context, state) => SupplierFormScreen(existing: state.extra as Supplier?),
      ),
      GoRoute(path: '/reports', builder: (context, state) => const ReportsDashboardScreen()),
      GoRoute(path: '/reports/sales', builder: (context, state) => const SalesReportScreen()),
      GoRoute(path: '/reports/purchases', builder: (context, state) => const PurchaseReportScreen()),
      GoRoute(path: '/reports/stock', builder: (context, state) => const StockReportScreen()),
      GoRoute(path: '/reports/ledger', builder: (context, state) => const InventoryLedgerReportScreen()),
      GoRoute(path: '/reports/profit', builder: (context, state) => const ProfitSummaryScreen()),
      GoRoute(path: '/reports/outstanding-customers', builder: (context, state) => const OutstandingCustomersScreen()),
      GoRoute(path: '/reports/expenses', builder: (context, state) => const ExpenseReportScreen()),
      GoRoute(path: '/expenses', builder: (context, state) => const ExpensesScreen()),
      GoRoute(path: '/expenses/new', builder: (context, state) => const ExpenseFormScreen()),
      GoRoute(path: '/expenses/summary', builder: (context, state) => const ExpenseSummaryScreen()),
      GoRoute(path: '/expenses/categories', builder: (context, state) => const ExpenseCategoriesScreen()),
      GoRoute(
        path: '/expenses/:id',
        builder: (context, state) => ExpenseDetailScreen(expenseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/expenses/:id/edit',
        builder: (context, state) => ExpenseFormScreen(existing: state.extra as Expense?),
      ),
      GoRoute(path: '/taxes', builder: (context, state) => const TaxSettingsScreen()),
      GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: '/business-settings', builder: (context, state) => const BusinessSettingsScreen()),
      GoRoute(path: '/settings/upi-qr', builder: (context, state) => const UpiQrSettingsScreen()),
      GoRoute(path: '/settings/bank-details', builder: (context, state) => const BankDetailsSettingsScreen()),
      GoRoute(path: '/exports', builder: (context, state) => const ExportsScreen()),
      GoRoute(path: '/audit-log', builder: (context, state) => const AuditLogScreen()),
    ],
  );
});
