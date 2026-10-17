import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../data/business_settings_api.dart';
import '../data/models/business_settings.dart';

final businessSettingsApiProvider = Provider<BusinessSettingsApi>((ref) => BusinessSettingsApi(ref.watch(dioProvider)));

final businessSettingsProvider = FutureProvider<BusinessSettings>((ref) {
  return ref.watch(businessSettingsApiProvider).getSettings();
});

class BusinessSettingsFormController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> save({
    required String businessName,
    required String ownerName,
    String? businessMobileNumber,
    String? email,
    String? gstNumber,
    Map<String, String?>? address,
    required String invoicePrefix,
    String? invoiceFooterNote,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(businessSettingsApiProvider)
          .updateSettings(
            businessName: businessName,
            ownerName: ownerName,
            businessMobileNumber: businessMobileNumber,
            email: email,
            gstNumber: gstNumber,
            address: address,
            invoicePrefix: invoicePrefix,
            invoiceFooterNote: invoiceFooterNote,
          ),
    );
    final success = !state.hasError;
    if (success) {
      ref.invalidate(businessSettingsProvider);
    }
    return success;
  }
}

final businessSettingsFormControllerProvider = AsyncNotifierProvider<BusinessSettingsFormController, void>(
  BusinessSettingsFormController.new,
);
