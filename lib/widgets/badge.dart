import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/cupertino.dart';

class BonsuiBadge extends StatelessWidget {
  const BonsuiBadge({
    super.key,
    this.label,
    this.icon,
    this.iconSize,
    this.color,
    this.padding,
    this.shape,
    this.fontSize,
    this.child,
    this.useTransparency,
    this.width,
  });

  final String? label;
  final IconData? icon;
  final Color? color;
  final double? iconSize;
  final EdgeInsets? padding;
  final BonsuiShape? shape;
  final double? fontSize;
  final Widget? child;
  final bool? useTransparency;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
          color: _getBackgroundColor(), borderRadius: _getShape()),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: _getVerticalPadding(),
              horizontal: label == null && icon != null ? 6 : 14,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child != null) child!,
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: label != null ? 5 : 0),
                child: Icon(
                  icon,
                  size: iconSize ?? _getIconSize(),
                  color: BonsuiUtils.darken(
                      color ?? BonsuiDesign.primaryColor, 0.2),
                ),
              ),
            if (label != null)
              BonsuiText(
                label!,
                color:
                    BonsuiUtils.darken(color ?? BonsuiDesign.primaryColor, 0.2),
                lineHeight: 0,
                size: fontSize ?? 12,
                weight: FontWeight.w600,
              ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (color != null) {
      if (useTransparency != null && useTransparency!) {
        return color!.withValues(alpha: 0.15);
      }
      return BonsuiUtils.lighten(color!, 0.31);
    }
    if (useTransparency != null && useTransparency!) {
      return BonsuiDesign.primaryColor.withValues(alpha: 0.15);
    }
    return BonsuiUtils.lighten(BonsuiDesign.primaryColor, 0.31);
  }

  double _getVerticalPadding() {
    if (icon != null && label == null) {
      return 6;
    }
    if (icon != null && label != null) {
      return 8;
    }
    return 10;
  }

  double _getIconSize() {
    if (label == null) {
      return 22;
    }
    if (fontSize != null) {
      return fontSize! + 6;
    }
    return 18;
  }

  BorderRadius _getShape() {
    BonsuiShape shapeSelected = BonsuiShape.rounded;
    if (shape != null) {
      shapeSelected = shape!;
    } else {
      shapeSelected = BonsuiShape.rounded;
    }
    return Utils.getBorderRadius(shapeSelected);
  }
}
