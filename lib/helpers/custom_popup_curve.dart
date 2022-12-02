import 'dart:math';

import 'package:flutter/animation.dart';

class CustomPopInCurve extends Curve {
  const CustomPopInCurve({
    this.a = 0.11,
    this.w = 7.7,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}