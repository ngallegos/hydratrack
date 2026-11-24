import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/avatar/avatar_band.dart';
import 'package:hydratrack/features/avatar/avatar_painter.dart';
import 'package:hydratrack/features/avatar/avatar_shape.dart';
import 'package:material_ui/material_ui.dart';

const _size = Size(200, 400);

AvatarBand _band(String id, double start, double end) =>
    AvatarBand(categoryId: id, colorValue: 0xFF000000, start: start, end: end);

AvatarPainter _painter({double phase = 0, List<AvatarBand> bands = const []}) =>
    AvatarPainter(
      shape: AvatarShape.bottle,
      bands: bands,
      wavePhase: phase,
      outlineColor: Colors.black,
      emptyColor: Colors.white,
    );

/// Which sample points along a band's flat top edge fall inside the layer.
/// A wavy edge dips above and below the flat line, so this varies with the
/// wave's shape and phase.
List<bool> _edgeProfile(Path path, double end) {
  final y = _size.height * (1 - end);
  return [
    for (var x = 2.0; x < _size.width; x += 5) path.contains(Offset(x, y)),
  ];
}

void main() {
  group('orderedLayers', () {
    test('puts the highest surface first', () {
      final layers = AvatarPainter.orderedLayers([
        _band('low', 0, 0.3),
        _band('high', 0.6, 0.9),
        _band('mid', 0.3, 0.6),
      ]);

      expect(layers.map((b) => b.categoryId), ['high', 'mid', 'low']);
    });

    test('paints a zero-height band before the band beneath it', () {
      final layers = AvatarPainter.orderedLayers([
        _band('below', 0, 0.5),
        _band('growing', 0.5, 0.5),
      ]);

      expect(layers.map((b) => b.categoryId), ['growing', 'below']);
    });

    test('does not modify the list it is given', () {
      final bands = [_band('a', 0, 0.2), _band('b', 0.2, 0.4)];

      AvatarPainter.orderedLayers(bands);

      expect(bands.map((b) => b.categoryId), ['a', 'b']);
    });
  });

  group('layerPath', () {
    final painter = _painter();

    test('every layer has a wavy surface, not only the top one', () {
      final bottom = _band('water', 0, 0.4);
      final middle = _band('coffee', 0.4, 0.6);

      for (final (index, band) in [bottom, middle].indexed) {
        final flatTop = _size.height * (1 - band.end);
        final bounds = painter.layerPath(_size, band, index).getBounds();

        expect(bounds.top, lessThan(flatTop - 0.5), reason: band.categoryId);
      }
    });

    test('a full avatar has a flat brim', () {
      final bounds = painter
          .layerPath(_size, _band('full', 0, 1), 0)
          .getBounds();

      expect(bounds.top, 0);
    });

    test('extends down to the bottom of the avatar', () {
      final bounds = painter
          .layerPath(_size, _band('mid', 0.4, 0.6), 1)
          .getBounds();

      expect(bounds.bottom, _size.height);
    });

    test('layers wave out of step with each other', () {
      final band = _band('same', 0, 0.5);

      expect(
        _edgeProfile(painter.layerPath(_size, band, 0), band.end),
        isNot(_edgeProfile(painter.layerPath(_size, band, 1), band.end)),
      );
    });

    test('every layer moves as the animation advances', () {
      final band = _band('moving', 0, 0.5);
      final later = _painter(phase: math.pi);

      for (final index in [0, 1, 2]) {
        expect(
          _edgeProfile(painter.layerPath(_size, band, index), band.end),
          isNot(_edgeProfile(later.layerPath(_size, band, index), band.end)),
          reason: 'layer $index',
        );
      }
    });

    test('a thin band waves less so it cannot cross its neighbours', () {
      final thin = _band('thin', 0.5, 0.51);
      final flatTop = _size.height * (1 - thin.end);
      final height = _size.height * (thin.end - thin.start);

      final bounds = painter.layerPath(_size, thin, 0).getBounds();

      expect(flatTop - bounds.top, lessThanOrEqualTo(height / 2 + 0.01));
    });
  });

  group('shouldRepaint', () {
    test('repaints when the wave phase changes', () {
      expect(_painter(phase: 1).shouldRepaint(_painter()), isTrue);
    });

    test('does not repaint when nothing changed', () {
      final bands = [_band('a', 0, 0.5)];

      expect(
        _painter(bands: bands).shouldRepaint(_painter(bands: [...bands])),
        isFalse,
      );
    });
  });
}
