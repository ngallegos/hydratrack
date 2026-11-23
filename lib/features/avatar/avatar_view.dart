import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'avatar_band.dart';
import 'avatar_painter.dart';
import 'avatar_shape.dart';

class AvatarView extends StatefulWidget {
  const AvatarView({
    required this.shape,
    required this.bands,
    required this.semanticsLabel,
    this.animateWave = true,
    super.key,
  });

  final AvatarShape shape;
  final List<AvatarBand> bands;
  final String semanticsLabel;
  final bool animateWave;

  @override
  State<AvatarView> createState() => _AvatarViewState();
}

class _AvatarViewState extends State<AvatarView> with TickerProviderStateMixin {
  late final AnimationController _wave = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );
  late final AnimationController _fill = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
    value: 1,
  );
  late List<AvatarBand> _from = widget.bands;
  late List<AvatarBand> _to = widget.bands;

  @override
  void initState() {
    super.initState();
    if (widget.animateWave) _wave.repeat();
  }

  @override
  void didUpdateWidget(AvatarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animateWave != oldWidget.animateWave) {
      widget.animateWave ? _wave.repeat() : _wave.stop();
    }
    if (!listEquals(oldWidget.bands, widget.bands)) {
      _from = _currentBands;
      _to = widget.bands;
      _fill.forward(from: 0);
    }
  }

  List<AvatarBand> get _currentBands =>
      lerpAvatarBands(_from, _to, Curves.easeOut.transform(_fill.value));

  @override
  void dispose() {
    _wave.dispose();
    _fill.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: widget.semanticsLabel,
      image: true,
      child: AspectRatio(
        aspectRatio: widget.shape.aspectRatio,
        child: AnimatedBuilder(
          animation: Listenable.merge([_wave, _fill]),
          builder: (context, _) => CustomPaint(
            painter: AvatarPainter(
              shape: widget.shape,
              bands: _currentBands,
              wavePhase: _wave.value * 2 * math.pi,
              outlineColor: colors.outline,
              emptyColor: colors.surfaceContainerHighest,
            ),
          ),
        ),
      ),
    );
  }
}
