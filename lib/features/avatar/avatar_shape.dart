import 'dart:ui';

import 'package:flutter/painting.dart';

enum AvatarShape {
  bottle(label: 'Bottle', aspectRatio: 0.55),
  drop(label: 'Drop', aspectRatio: 0.8),
  cactus(label: 'Cactus', aspectRatio: 0.75),
  fish(label: 'Fish', aspectRatio: 1.6);

  const AvatarShape({required this.label, required this.aspectRatio});

  final String label;

  /// width / height
  final double aspectRatio;

  Path buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    return switch (this) {
      AvatarShape.bottle => _bottle(w, h),
      AvatarShape.drop => _drop(w, h),
      AvatarShape.cactus => _cactus(w, h),
      AvatarShape.fish => _fish(w, h),
    };
  }
}

Path _bottle(double w, double h) {
  final path = Path()
    ..moveTo(.35 * w, 0)
    ..lineTo(.65 * w, 0)
    ..lineTo(.65 * w, .12 * h)
    ..cubicTo(.65 * w, .2 * h, .9 * w, .2 * h, .9 * w, .35 * h)
    ..lineTo(.9 * w, .92 * h)
    ..quadraticBezierTo(.9 * w, h, .8 * w, h)
    ..lineTo(.2 * w, h)
    ..quadraticBezierTo(.1 * w, h, .1 * w, .92 * h)
    ..lineTo(.1 * w, .35 * h)
    ..cubicTo(.1 * w, .2 * h, .35 * w, .2 * h, .35 * w, .12 * h)
    ..close();
  return path;
}

Path _drop(double w, double h) {
  return Path()
    ..moveTo(.5 * w, 0)
    ..cubicTo(.65 * w, .25 * h, .95 * w, .45 * h, .95 * w, .7 * h)
    ..arcToPoint(
      Offset(.05 * w, .7 * h),
      radius: Radius.elliptical(.45 * w, .3 * h),
    )
    ..cubicTo(.05 * w, .45 * h, .35 * w, .25 * h, .5 * w, 0)
    ..close();
}

Path _cactus(double w, double h) {
  RRect round(double l, double t, double r, double b, double radius) =>
      RRect.fromLTRBR(l * w, t * h, r * w, b * h, Radius.circular(radius * w));

  final parts = [
    round(.34, 0, .66, 1, .16),
    round(.06, .28, .26, .62, .1),
    round(.14, .5, .42, .62, .04),
    round(.74, .16, .94, .5, .1),
    round(.58, .38, .86, .5, .04),
  ];

  return parts
      .map((r) => Path()..addRRect(r))
      .reduce((a, b) => Path.combine(PathOperation.union, a, b));
}

Path _fish(double w, double h) {
  final body = Path()..addOval(Rect.fromLTRB(0, .2 * h, .78 * w, .8 * h));
  final tail = Path()
    ..moveTo(.68 * w, .5 * h)
    ..lineTo(w, .12 * h)
    ..lineTo(.92 * w, .5 * h)
    ..lineTo(w, .88 * h)
    ..close();
  return Path.combine(PathOperation.union, body, tail);
}
