import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiInfo extends StatelessWidget {
  const BonsuiInfo({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.iconColor,
    this.fontSize,
    this.color,
    this.type,
    this.shape,
    this.child,
    this.padding,
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final double? fontSize;
  final Color? color;
  final BonsuiInfoType? type;
  final BonsuiShape? shape;
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: BonsuiDesign.spacing * 2.2,
            vertical: BonsuiDesign.spacing * 2.2,
          ),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: Utils.getBorderRadius(
          shape,
        ),
        border: Border.all(
          color: BonsuiUtils.darken(_getColor(), 0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: BonsuiDesign.spacing * 2),
            child: Icon(
              _getIcon(),
              size: fontSize != null ? fontSize! * 1.8 : 24,
              color: _getIconColor(),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BonsuiSpacing.vertical(0.04),
                if (title != null)
                  BonsuiText(
                    title!,
                    weight: FontWeight.w700,
                    color: BonsuiDesign.textColor,
                    size: fontSize != null ? fontSize! + 1 : 15,
                  ),
                if (description != null)
                  BonsuiText(
                    description!,
                    color: BonsuiDesign.textColorLight,
                    weight: FontWeight.w500,
                    size: fontSize ?? 14,
                    padding: const EdgeInsets.only(top: 4),
                    lineHeight: 0,
                  ),
                if (child != null) child!,
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (icon != null) {
      return icon!;
    }
    switch (type) {
      case BonsuiInfoType.success:
        return BonsuiIcons.checkCircleOutlined;
      case BonsuiInfoType.warning:
        return BonsuiIcons.warningOutlined;
      case BonsuiInfoType.error:
        return BonsuiIcons.error;
      case BonsuiInfoType.info:
      default:
        return BonsuiIcons.info;
    }
  }

  Color _getIconColor() {
    if (iconColor != null) {
      return iconColor!;
    }
    if (color != null) {
      return color!;
    }
    switch (type) {
      case BonsuiInfoType.success:
        return BonsuiDesign.successColor;
      case BonsuiInfoType.warning:
        return BonsuiDesign.warningColor;
      case BonsuiInfoType.error:
        return BonsuiDesign.dangerColor;
      case BonsuiInfoType.info:
        return BonsuiDesign.infoColor;
      default:
        return BonsuiDesign.textColorLight;
    }
  }

  Color _getColor() {
    if (color != null) {
      return color!;
    }
    switch (type) {
      case BonsuiInfoType.success:
        return BonsuiUtils.lighten(
          BonsuiDesign.successColor,
          0.3,
        );
      case BonsuiInfoType.warning:
        return BonsuiUtils.lighten(
          BonsuiDesign.warningColor,
          0.3,
        );
      case BonsuiInfoType.error:
        return BonsuiUtils.lighten(
          BonsuiDesign.dangerColor,
          0.3,
        );
      case BonsuiInfoType.info:
        return BonsuiUtils.lighten(
          BonsuiDesign.infoColor,
          0.3,
        );
      default:
        return const Color(0xffF9F9FB);
    }
  }
}
