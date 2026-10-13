import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';

class BonsuiEmptyState extends StatelessWidget {
  const BonsuiEmptyState(
      {super.key,
      this.child,
      this.title,
      this.description,
      this.iconChild,
      this.padding,
      this.icon});

  final IconData? icon;
  final Widget? iconChild;
  final Widget? child;
  final String? title;
  final String? description;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconChild ??
                Icon(
                  icon ?? BonsuiIcons.closeCircle,
                  size: 52,
                  color: BonsuiDesign.primaryColor,
                ),
            BonsuiSpacing.vertical(0.6),
            BonsuiText(
              title ?? Localization.getValue('empty_state_title'),
              size: 19,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
            BonsuiSpacing.vertical(0.1),
            if (description != null)
              BonsuiText(
                description!,
                align: TextAlign.center,
              ),
            if (child != null) ...[
              BonsuiSpacing.vertical(),
              child!,
            ]
          ],
        ),
      ),
    );
  }
}
