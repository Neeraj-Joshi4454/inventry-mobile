import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit.freezed.dart';
part 'unit.g.dart';

@freezed
abstract class ProductUnit with _$ProductUnit {
  const factory ProductUnit({required String id, required String name, required String symbol}) = _ProductUnit;

  factory ProductUnit.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitFromJson({'id': json['_id'] ?? json['id'], 'name': json['name'], 'symbol': json['symbol']});
}
