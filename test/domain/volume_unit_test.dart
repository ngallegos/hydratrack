import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/domain/volume_unit.dart';

void main() {
  group('VolumeUnit.ml', () {
    test('formats with thousands separators', () {
      expect(VolumeUnit.ml.format(250), '250 ml');
      expect(VolumeUnit.ml.format(2500), '2,500 ml');
    });

    test('rounds fractional millilitres', () {
      expect(VolumeUnit.ml.format(159.6), '160 ml');
    });

    test('converts as the identity', () {
      expect(VolumeUnit.ml.fromMl(250), 250);
      expect(VolumeUnit.ml.toMl(250), 250);
    });
  });

  group('VolumeUnit.flOz', () {
    test('formats to one decimal and drops a trailing .0', () {
      expect(VolumeUnit.flOz.format(250), '8.5 fl oz');
      expect(VolumeUnit.flOz.format(0), '0 fl oz');
      expect(VolumeUnit.flOz.format(2957), '100 fl oz');
    });

    test('converts to and from millilitres', () {
      expect(VolumeUnit.flOz.fromMl(2957.35), closeTo(100, 0.0001));
      expect(VolumeUnit.flOz.toMl(8), 237);
      expect(VolumeUnit.flOz.toMl(16), 473);
    });

    test('round-trips whole ounces within rounding error', () {
      for (final oz in [2.0, 8.0, 12.5, 34.0]) {
        final back = VolumeUnit.flOz.fromMl(VolumeUnit.flOz.toMl(oz));
        expect(back, closeTo(oz, 0.02));
      }
    });
  });

  group('SliderSpec', () {
    test('divisions count the steps in the range', () {
      expect(VolumeUnit.ml.volumeSlider.divisions, 19);
      expect(VolumeUnit.flOz.volumeSlider.divisions, 64);
      expect(VolumeUnit.ml.goalSlider.divisions, 100);
    });

    test('every unit offers a default drink and goal inside its ranges', () {
      for (final unit in VolumeUnit.values) {
        final drink = unit.fromMl(250);
        final goal = unit.fromMl(2500);
        expect(
          drink,
          inInclusiveRange(unit.volumeSlider.min, unit.volumeSlider.max),
        );
        expect(
          goal,
          inInclusiveRange(unit.goalSlider.min, unit.goalSlider.max),
        );
      }
    });
  });
}
