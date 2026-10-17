import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/export_api.dart';
import '../../../core/widgets/brand_app_bar.dart';

final exportApiProvider = Provider<ExportApi>((ref) => ExportApi(ref.watch(dioProvider)));

const _exports = [
  (type: 'sales', label: 'Sales', icon: Icons.point_of_sale_outlined),
  (type: 'purchases', label: 'Purchases', icon: Icons.shopping_cart_outlined),
  (type: 'inventory', label: 'Inventory', icon: Icons.inventory_2_outlined),
  (type: 'customers', label: 'Customers', icon: Icons.people_outline),
  (type: 'suppliers', label: 'Suppliers', icon: Icons.local_shipping_outlined),
];

/// Downloads each export as CSV text from the backend (already
/// tenant-scoped and filtered — see export.service.ts) and hands it to the
/// OS share sheet, which lets the user save it to Files, email it, etc.
/// No client-side CSV generation or filtering happens here.
class ExportsScreen extends ConsumerStatefulWidget {
  const ExportsScreen({super.key});

  @override
  ConsumerState<ExportsScreen> createState() => _ExportsScreenState();
}

class _ExportsScreenState extends ConsumerState<ExportsScreen> {
  DateTimeRange? _range;
  String? _exportingType;

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(context: context, firstDate: DateTime(now.year - 5), lastDate: now);
    if (range != null) setState(() => _range = range);
  }

  Future<void> _export(String type, String label) async {
    setState(() => _exportingType = type);
    try {
      final csv = await ref.read(exportApiProvider).exportCsv(type, fromDate: _range?.start, toDate: _range?.end);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$type.csv');
      await file.writeAsString(csv);
      if (!mounted) return;
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: '$label export'));
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _exportingType = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(title: const Text('Data Export')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OutlinedButton.icon(
            onPressed: _pickDateRange,
            icon: const Icon(Icons.date_range_outlined),
            label: Text(
              _range == null
                  ? 'Filter by date range (optional)'
                  : '${'${_range!.start.toLocal()}'.split(' ')[0]} – ${'${_range!.end.toLocal()}'.split(' ')[0]}',
            ),
          ),
          if (_range != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () => setState(() => _range = null), child: const Text('Clear')),
            ),
          const SizedBox(height: 12),
          for (final export in _exports)
            Card(
              child: ListTile(
                leading: Icon(export.icon, color: AppColors.primary),
                title: Text(export.label),
                subtitle: const Text('Export as CSV'),
                trailing: _exportingType == export.type
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.ios_share_outlined),
                onTap: _exportingType == null ? () => _export(export.type, export.label) : null,
              ),
            ),
        ],
      ),
    );
  }
}
