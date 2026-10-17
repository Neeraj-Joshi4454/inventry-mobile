import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_config.freezed.dart';

@freezed
abstract class TaxConfig with _$TaxConfig {
  const factory TaxConfig({
    required bool gstEnabled,
    String? gstin,
    String? state,
    required double defaultTaxRate,
    required String taxType,
  }) = _TaxConfig;

  factory TaxConfig.fromJson(Map<String, dynamic> json) {
    return TaxConfig(
      gstEnabled: json['gstEnabled'] as bool? ?? false,
      gstin: json['gstin'] as String?,
      state: json['state'] as String?,
      defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble() ?? 0,
      taxType: json['taxType'] as String? ?? 'CGST_SGST',
    );
  }
}
