import 'package:bonsui/bonsui.dart';
import 'package:flutter/widgets.dart';

class BonsuiHeading extends StatelessWidget {
  const BonsuiHeading(
    this.title, {
    super.key,
    this.color,
    this.align,
    this.maxLines,
    this.size,
    this.lineHeight,
    this.shadows,
    this.weight,
    this.padding,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    this.overflow,
    this.gradient,
  });

  final String title;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final List<Shadow>? shadows;
  final FontWeight? weight;
  final EdgeInsets? padding;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final BonsuiGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return BonsuiText(
      title,
      size: size ?? 26,
      weight: weight ?? FontWeight.w700,
      lineHeight: lineHeight ?? 1.7,
      color: color,
      align: align,
      maxLines: maxLines,
      shadows: shadows,
      padding: padding,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      decoration: decoration,
      overflow: overflow,
      gradient: gradient,
    );
  }
}
