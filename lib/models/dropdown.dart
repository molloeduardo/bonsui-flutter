import 'package:flutter/cupertino.dart';

class BonsuiDropdownItem {
  final String? label;
  final Widget? widget;
  final String value;
  final IconData? icon;
  final Color? color;
  final bool? disabled;

  BonsuiDropdownItem({
    this.label,
    this.widget,
    required this.value,
    this.icon,
    this.color,
    this.disabled,
  });
}
