import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../data/tax_api.dart';
import '../data/models/tax_config.dart';

final taxApiProvider = Provider<TaxApi>((ref) => TaxApi(ref.watch(dioProvider)));

final taxConfigProvider = FutureProvider<TaxConfig>((ref) {
  return ref.watch(taxApiProvider).getTaxConfig();
});

class TaxConfigFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> saveTaxConfig({
    bool? gstEnabled,
    String? gstin,
    String? businessState,
    double? defaultTaxRate,
    String? taxType,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(taxApiProvider)
          .updateTaxConfig(
            gstEnabled: gstEnabled,
            gstin: gstin,
            state: businessState,
            defaultTaxRate: defaultTaxRate,
            taxType: taxType,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(taxConfigProvider);
    }
    return success;
  }
}

final taxConfigFormControllerProvider = AsyncNotifierProvider<TaxConfigFormController, void>(
  TaxConfigFormController.new,
);
