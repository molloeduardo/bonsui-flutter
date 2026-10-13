import 'package:flutter/widgets.dart';

class BonsuiToggleButtonsItem {
  final String? label;
  final IconData? icon;
  final Widget? child;
  final bool? isSelected;
  final Color? color;
  final bool? isDisabled;
  final dynamic value;

  BonsuiToggleButtonsItem({
    this.label,
    this.icon,
    this.isSelected,
    this.color,
    this.isDisabled,
    this.value,
    this.child,
  });
}
