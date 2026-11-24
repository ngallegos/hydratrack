import 'package:freezed_annotation/freezed_annotation.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
abstract class Drink with _$Drink {
  const factory Drink({
    required String id,
    required String categoryId,
    required String name,
    required int volumeMl,
    required DateTime updatedAt,
    required String deviceId,
    @Default(false) bool starred,
    @Default(false) bool deleted,
  }) = _Drink;

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
}
