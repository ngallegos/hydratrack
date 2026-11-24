import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'avatar_band.dart';
import 'avatar_shape.dart';

class AvatarPainter extends CustomPainter {
  AvatarPainter({
    required this.shape,
    required this.bands,
    required this.wavePhase,
    required this.outlineColor,
    required this.emptyColor,
  });

  final AvatarShape shape;
  final List<AvatarBand> bands;
  final double wavePhase;
  final Color outlineColor;
  final Color emptyColor;

  @override
  void paint(Canvas canvas, Size size) {
    final outline = shape.buildPath(size);

    canvas.drawPath(outline, Paint()..color = emptyColor);

    canvas.save();
    canvas.clipPath(outline);
    final layers = orderedLayers(bands);
    for (final (index, band) in layers.indexed) {
      canvas.drawPath(
        layerPath(size, band, index),
        Paint()..color = Color(band.colorValue),
      );
    }
    canvas.restore();

    canvas.drawPath(
      outline,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round
        ..color = outlineColor,
    );
  }

  /// Highest surface first. Each layer is painted down to the bottom of the
  /// avatar, so lower layers cover the lower part of the ones above and what
  /// stays visible of a layer is the slice between its own surface and the
  /// surface of the layer beneath it. Ties put the band that starts higher
  /// first, so a zero-height band is covered by the one below it.
  @visibleForTesting
  static List<AvatarBand> orderedLayers(List<AvatarBand> bands) {
    return [...bands]..sort((a, b) {
      final byTop = b.end.compareTo(a.end);
      return byTop != 0 ? byTop : b.start.compareTo(a.start);
    });
  }

  /// The region from this band's wavy surface down to the avatar's bottom.
  /// Every layer waves on its own: [index] offsets the phase and alternates
  /// the direction, so category boundaries don't move in lockstep.
  @visibleForTesting
  Path layerPath(Size size, AvatarBand band, int index) {
    final top = size.height * (1 - band.end);
    final height = size.height * (band.end - band.start);
    final atBrim = band.end >= 0.999;
    final amplitude = atBrim ? 0.0 : math.min(size.height * 0.012, height / 2);
    final phase = (index.isEven ? wavePhase : -wavePhase) + index * 2.1;

    final path = Path()..moveTo(0, size.height);
    for (var x = 0.0; x <= size.width; x += 2) {
      final y =
          top +
          amplitude * math.sin(phase + x / size.width * 2 * math.pi * 1.5);
      path.lineTo(x, y);
    }
    return path
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldRepaint(AvatarPainter old) =>
      old.shape != shape ||
      old.wavePhase != wavePhase ||
      old.outlineColor != outlineColor ||
      old.emptyColor != emptyColor ||
      !listEquals(old.bands, bands);
}
