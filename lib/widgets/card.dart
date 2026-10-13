import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class BonsuiCard extends StatelessWidget {
  const BonsuiCard({
    super.key,
    this.child,
    this.icon,
    this.title,
    this.description,
    this.color,
    this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.padding,
    this.border,
    this.width,
    this.height,
    this.shape,
    this.shadow,
  });

  final Widget? child;
  final IconData? icon;
  final String? title;
  final String? description;
  final Color? color;
  final Color? backgroundColor;
  final Function? onPressed;
  final Function? onLongPress;
  final EdgeInsets? padding;
  final Border? border;
  final double? width;
  final double? height;
  final BonsuiShape? shape;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Utils.getBorderRadius(shape),
        boxShadow: shadow ?? [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashFactory: Utils.getSplashFactory(),
            borderRadius: Utils.getBorderRadius(shape),
            onTap: onPressed != null ? () => onPressed!() : null,
            onLongPress: onLongPress != null ? () => onLongPress!() : null,
            child: Ink(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: _getBorder(),
                color: backgroundColor ??
                    (BonsuiDesign.useDarkMode
                        ? const Color(0xff181818)
                        : BonsuiDesign.whiteColor),
                borderRadius: Utils.getBorderRadius(
                  shape,
                ),
              ),
              padding: padding ?? const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon != null
                      ? Padding(
                          padding:
                              EdgeInsets.only(bottom: BonsuiDesign.spacing),
                          child: Icon(
                            icon,
                            size: 40,
                            color: color ?? BonsuiDesign.primaryColor,
                          ),
                        )
                      : Container(),
                  title != null
                      ? BonsuiText(
                          title!,
                          size: 20,
                          weight: FontWeight.w600,
                          color: color,
                        )
                      : Container(),
                  description != null
                      ? BonsuiText(
                          description!,
                          align: TextAlign.center,
                          color: color,
                        )
                      : Container(),
                  child != null ? child! : Container(),
                ],
              ),
            )),
      ),
    );
  }

  BoxBorder? _getBorder() {
    if (border != null) {
      return border;
    }
    if (backgroundColor != null) {
      return Border.all(
        color: BonsuiUtils.darken(backgroundColor!),
        width: 1,
      );
    }
    return Border.all(
      color: BonsuiDesign.useDarkMode
          ? Colors.grey.shade900
          : Colors.grey.shade300,
      width: 1,
    );
  }
}
