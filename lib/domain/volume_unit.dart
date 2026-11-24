import '../core/format.dart';

class SliderSpec {
  const SliderSpec(this.min, this.max, this.step);

  final double min;
  final double max;
  final double step;

  int get divisions => ((max - min) / step).round();
}

/// Volumes are always stored in millilitres; a unit only changes how they
/// are shown and entered.
enum VolumeUnit {
  ml(
    label: 'mL',
    mlPerUnit: 1,
    volumeSlider: SliderSpec(50, 1000, 50),
    goalSlider: SliderSpec(1000, 6000, 50),
  ),
  flOz(
    label: 'fl oz',
    mlPerUnit: 29.5735,
    volumeSlider: SliderSpec(2, 34, 0.5),
    goalSlider: SliderSpec(34, 200, 1),
  );

  const VolumeUnit({
    required this.label,
    required this.mlPerUnit,
    required this.volumeSlider,
    required this.goalSlider,
  });

  final String label;
  final double mlPerUnit;

  /// Range for a single drink, and for a daily goal, in this unit.
  final SliderSpec volumeSlider;
  final SliderSpec goalSlider;

  double fromMl(num ml) => ml / mlPerUnit;

  int toMl(double value) => (value * mlPerUnit).round();

  String format(num ml) {
    if (this == VolumeUnit.ml) return formatMl(ml.round());
    final text = fromMl(ml).toStringAsFixed(1);
    return '${text.endsWith('.0') ? text.substring(0, text.length - 2) : text} $label';
  }
}
