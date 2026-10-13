import 'dart:ui';

import 'package:bonsui/enums/text.dart';
import 'package:flutter/material.dart';

class BonsuiGradient {
  final BonsuiGradientType? type;
  final List<Color> colors;
  final Alignment? begin;
  final Alignment? end;

  BonsuiGradient({
    this.type,
    required this.colors,
    this.begin,
    this.end,
  });
}
