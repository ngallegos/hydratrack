import 'dart:ui' show lerpDouble;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/drink_category.dart';

part 'avatar_band.freezed.dart';

/// One colored slice of the avatar fill. [start] and [end] are fractions of
/// the avatar's height measured from the bottom, within 0..1.
@freezed
abstract class AvatarBand with _$AvatarBand {
  const factory AvatarBand({
    required String categoryId,
    required int colorValue,
    required double start,
    required double end,
  }) = _AvatarBand;
}

/// Stacks one band per category, in category sort order, each as tall as its
/// share of [goalMl]. Anything past the goal is clipped at the top.
List<AvatarBand> computeAvatarBands({
  required Map<String, double> hydrationByCategory,
  required List<DrinkCategory> categories,
  required int goalMl,
}) {
  if (goalMl <= 0) return const [];

  final ordered = [...categories]
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  final bands = <AvatarBand>[];
  var cursor = 0.0;

  for (final category in ordered) {
    final ml = hydrationByCategory[category.id];
    if (ml == null || ml <= 0) continue;

    final start = cursor.clamp(0.0, 1.0);
    cursor += ml / goalMl;
    final end = cursor.clamp(0.0, 1.0);
    if (end > start) {
      bands.add(
        AvatarBand(
          categoryId: category.id,
          colorValue: category.colorValue,
          start: start,
          end: end,
        ),
      );
    }
  }
  return bands;
}

/// Interpolates between two band lists so the fill animates smoothly when
/// intake changes. Bands are matched by category; one that only exists on a
/// side grows from, or shrinks to, zero height at its own start.
List<AvatarBand> lerpAvatarBands(
  List<AvatarBand> from,
  List<AvatarBand> to,
  double t,
) {
  final remaining = {for (final band in from) band.categoryId: band};
  final result = <AvatarBand>[];

  for (final target in to) {
    final source =
        remaining.remove(target.categoryId) ??
        target.copyWith(end: target.start);
    result.add(
      target.copyWith(
        start: lerpDouble(source.start, target.start, t)!,
        end: lerpDouble(source.end, target.end, t)!,
      ),
    );
  }

  for (final leaving in remaining.values) {
    result.add(
      leaving.copyWith(end: lerpDouble(leaving.end, leaving.start, t)!),
    );
  }
  return result;
}
