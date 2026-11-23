import 'package:freezed_annotation/freezed_annotation.dart';

part 'drink_category.freezed.dart';
part 'drink_category.g.dart';

@freezed
abstract class DrinkCategory with _$DrinkCategory {
  const factory DrinkCategory({
    required String id,
    required String name,
    required int colorValue,
    required double hydrationFactor,
    required int sortOrder,
    required DateTime updatedAt,
    required String deviceId,
    @Default(false) bool deleted,
  }) = _DrinkCategory;

  factory DrinkCategory.fromJson(Map<String, dynamic> json) =>
      _$DrinkCategoryFromJson(json);
}
