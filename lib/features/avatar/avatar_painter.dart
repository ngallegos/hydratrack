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
    final fillTop = bands.fold(0.0, (top, band) => math.max(top, band.end));
    for (final band in bands) {
      final isSurface = band.end == fillTop && fillTop < 0.999;
      canvas.drawPath(
        _bandPath(size, band, withWave: isSurface),
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

  Path _bandPath(Size size, AvatarBand band, {required bool withWave}) {
    final top = size.height * (1 - band.end);
    final bottom = size.height * (1 - band.start);
    if (!withWave) {
      return Path()..addRect(Rect.fromLTRB(0, top, size.width, bottom));
    }

    final amplitude = math.min(size.height * 0.012, (bottom - top) / 2);
    final path = Path()..moveTo(0, bottom);
    for (var x = 0.0; x <= size.width; x += 2) {
      final y =
          top +
          amplitude * math.sin(wavePhase + x / size.width * 2 * math.pi * 1.5);
      path.lineTo(x, y);
    }
    return path
      ..lineTo(size.width, bottom)
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
