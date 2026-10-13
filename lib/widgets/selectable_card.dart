import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiSelectableCard extends StatelessWidget {
  const BonsuiSelectableCard({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.child,
    this.selected,
    this.shape,
    this.onPressed,
    this.color,
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final Widget? child;
  final bool? selected;
  final BonsuiShape? shape;
  final Function? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected ?? false,
      child: Material(
        clipBehavior: Clip.antiAlias,
        animationDuration:
            BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
        color: BonsuiDesign.useDarkMode
            ? const Color(0xff181818)
            : Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: Utils.getBorderRadius(shape),
          side: BorderSide(
            color: selected != null && selected!
                ? color != null
                    ? color!.withAlpha(200)
                    : BonsuiDesign.primaryColor.withAlpha(200)
                : BonsuiDesign.useDarkMode
                    ? const Color(0xff333333)
                    : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: InkWell(
          splashFactory: BonsuiUtils.getSplashFactory(),
          borderRadius: Utils.getBorderRadius(shape),
          onTap: onPressed != null ? () => onPressed!() : null,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color != null
                          ? color!.withAlpha(20)
                          : BonsuiDesign.primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      icon,
                      size: 30,
                      color: color ?? BonsuiDesign.primaryColor.withAlpha(200),
                    ),
                  ),
                ),
              if (title != null || description != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      BonsuiText(
                        title!,
                        weight: FontWeight.w600,
                        size: 15,
                      ),
                    if (description != null)
                      BonsuiText(
                        description!,
                        size: 14,
                      ),
                  ],
                ),
              if (child != null) child!
            ]),
          ),
        ),
      ),
    );
  }
}
