import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:inventry_mobile/core/navigation/main_shell.dart';
import 'package:inventry_mobile/core/theme/app_theme.dart';
import 'package:inventry_mobile/core/widgets/app_button.dart';
import 'package:inventry_mobile/core/widgets/filter_chip_bar.dart';
import 'package:inventry_mobile/core/widgets/inline_alert.dart';
import 'package:inventry_mobile/core/widgets/list_row_card.dart';
import 'package:inventry_mobile/core/widgets/settings_list.dart';
import 'package:inventry_mobile/core/widgets/status_badge.dart';
import 'package:inventry_mobile/features/inventory/data/models/inventory_item.dart';
import 'package:inventry_mobile/features/inventory/data/models/stock_status.dart';
import 'package:inventry_mobile/features/inventory/providers/inventory_providers.dart';
import 'package:inventry_mobile/features/inventory/screens/inventory_screen.dart';
import 'package:inventry_mobile/features/products/data/models/category.dart';
import 'package:inventry_mobile/features/products/data/models/unit.dart';
import 'package:inventry_mobile/features/products/providers/product_providers.dart';
import 'package:inventry_mobile/features/reports/widgets/summary_card.dart';

/// Layout checks at the phone/tablet widths the redesign targets. Any
/// RenderFlex overflow or clipped layout throws during pump, which fails
/// the test via tester.takeException().
const _widths = [320.0, 360.0, 390.0, 430.0, 768.0];

const _categories = [
  ProductCategory(id: 'c1', name: 'Aggregate'),
  ProductCategory(id: 'c2', name: 'Bricks'),
  ProductCategory(id: 'c3', name: 'Cement'),
  ProductCategory(id: 'c4', name: 'Hardware'),
  ProductCategory(id: 'c5', name: 'Pipes'),
  ProductCategory(id: 'c6', name: 'Sand'),
  ProductCategory(id: 'c7', name: 'Steel'),
  ProductCategory(id: 'c8', name: 'Tiles'),
  ProductCategory(id: 'c9', name: 'steel 12mm'),
];

const _bag = ProductUnit(id: 'u1', name: 'Bag', symbol: 'bag');

final _items = [
  const InventoryItem(
    productId: 'p1',
    name: 'UltraTech Portland Pozzolana Cement 53 Grade Premium Weather-Shield 50kg',
    sku: 'CEM-ULTRATECH-PPC-53-WS-50KG-0001',
    category: ProductCategory(id: 'c3', name: 'Cement'),
    unit: _bag,
    currentStock: 1234567.5,
    lowStockThreshold: 10,
    status: StockStatus.inStock,
  ),
  const InventoryItem(
    productId: 'p2',
    name: 'Red bricks',
    sku: 'BRK-1',
    category: ProductCategory(id: 'c2', name: 'Bricks'),
    unit: ProductUnit(id: 'u2', name: 'Piece', symbol: 'pcs'),
    currentStock: 12,
    lowStockThreshold: 50,
    status: StockStatus.lowStock,
  ),
  const InventoryItem(
    productId: 'p3',
    name: 'River sand',
    sku: 'SND-1',
    category: ProductCategory(id: 'c6', name: 'Sand'),
    unit: ProductUnit(id: 'u3', name: 'Cubic metre', symbol: 'm³'),
    currentStock: 0,
    lowStockThreshold: 5,
    status: StockStatus.outOfStock,
  ),
];

class _FakeInventoryList extends InventoryListNotifier {
  StockStatus? lastStatus;
  String? lastCategory;

  @override
  InventoryListState build() => InventoryListState(items: _items, hasMore: false);

  @override
  Future<void> refresh() async {}

  @override
  void setStatus(StockStatus? status) {
    lastStatus = status;
    state = state.copyWith(status: status);
  }

  @override
  void setCategory(String? categoryId) {
    lastCategory = categoryId;
    state = state.copyWith(categoryId: categoryId);
  }
}

Future<void> _setWidth(WidgetTester tester, double width) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

/// Scrolls [bar] horizontally until the chip labelled [label] is fully in
/// view, then taps it — chips past the edge aren't built until scrolled to.
Future<void> _tapChip(WidgetTester tester, Finder bar, String label) async {
  final chip = find.descendant(of: bar, matching: find.text(label));
  await tester.scrollUntilVisible(
    chip,
    80,
    scrollable: find.descendant(of: bar, matching: find.byType(Scrollable)),
  );
  await tester.pump(const Duration(milliseconds: 300)); // not pumpAndSettle: a loading spinner never settles
  await tester.tap(chip);
  await tester.pump();
}

void main() {
  for (final width in _widths) {
    testWidgets('design-system components lay out cleanly at ${width.toInt()}px', (tester) async {
      await _setWidth(tester, width);
      var selected = 'All';
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => ListView(
                children: [
                  FilterChipBar<String>(
                    selected: selected,
                    onSelected: (v) => setState(() => selected = v),
                    options: [
                      const FilterOption('All', 'All categories'),
                      for (final c in _categories) FilterOption(c.name, c.name),
                    ],
                  ),
                  const InlineAlert(
                    icon: Icons.warning_amber_rounded,
                    title: '128 stock alerts',
                    message:
                        'Low or out-of-stock products need attention across several warehouses and categories today.',
                    onTap: _noop,
                  ),
                  const SummaryCardGrid(
                    cards: [
                      SummaryCard(label: "Today's sales", value: '₹12,34,56,789.00', caption: '1,204 invoices'),
                      SummaryCard(label: "Today's purchases", value: '₹9,87,65,432.10', caption: '88 invoices'),
                      SummaryCard(label: 'Low stock', value: '17', caption: '17 products'),
                    ],
                  ),
                  const ListRowCard(
                    title: 'A very long product name that should wrap to two lines and then ellipsize neatly',
                    subtitle: 'SKU-WITH-A-VERY-LONG-CODE-1234567890 · Category with long name',
                    trailing: StatusBadge(label: 'Out of Stock', tone: StatusTone.error),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SettingsGroup(
                      title: 'Business',
                      children: [
                        SettingsListItem(icon: Icons.people_outline, title: 'Customers', onTap: _noop),
                        SettingsListItem(
                          icon: Icons.logout,
                          title: 'Log out',
                          destructive: true,
                          showChevron: false,
                          onTap: _noop,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        AppButton(label: 'Save changes to this record and continue', onPressed: _noop),
                        AppButton(label: 'Loading', onPressed: _noop, isLoading: true),
                        AppButton(label: 'Cancel', variant: AppButtonVariant.secondary, onPressed: _noop),
                        AppButton(label: 'Delete', variant: AppButtonVariant.destructive, onPressed: null),
                        Row(
                          children: [
                            AppButton(label: 'Inline', expand: false, onPressed: _noop),
                            AppButton(
                              label: 'Clear',
                              expand: false,
                              variant: AppButtonVariant.tertiary,
                              onPressed: _noop,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);

      // Selecting a chip off-screen: scroll it into view, tap, and it stays selected.
      await _tapChip(tester, find.byType(FilterChipBar<String>), 'steel 12mm');
      expect(selected, 'steel 12mm');
      final chip = tester.widget<AppFilterChip>(
        find.ancestor(of: find.text('steel 12mm'), matching: find.byType(AppFilterChip)),
      );
      expect(chip.selected, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('inventory screen: rows, filters and FAB at ${width.toInt()}px', (tester) async {
      await _setWidth(tester, width);
      final fake = _FakeInventoryList();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            inventoryListProvider.overrideWith(() => fake),
            categoriesProvider.overrideWith((ref) async => _categories),
          ],
          child: MaterialApp(theme: AppTheme.light, home: const InventoryScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Red bricks'), findsOneWidget);
      expect(find.text('Low Stock'), findsWidgets);

      // Status and category filters both apply and stay selected together.
      await _tapChip(tester, find.byType(FilterChipBar<StockStatus?>), 'Low Stock');
      await _tapChip(tester, find.byType(FilterChipBar<String?>), 'Bricks');
      expect(fake.lastStatus, StockStatus.lowStock);
      expect(fake.lastCategory, 'c2');
      expect(fake.state.status, StockStatus.lowStock);
      expect(fake.state.categoryId, 'c2');
      expect(tester.takeException(), isNull);
    });

    testWidgets('bottom navigation fits six destinations at ${width.toInt()}px', (tester) async {
      await _setWidth(tester, width);
      final router = GoRouter(
        initialLocation: '/a',
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, shell) => MainShell(navigationShell: shell),
            branches: [
              for (final path in ['/a', '/b', '/c', '/d', '/e', '/f'])
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: path,
                      builder: (_, _) => Scaffold(body: Text('page $path')),
                    ),
                  ],
                ),
            ],
          ),
        ],
      );
      await tester.pumpWidget(MaterialApp.router(theme: AppTheme.light, routerConfig: router));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();
      expect(find.text('page /d'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}

void _noop() {}
