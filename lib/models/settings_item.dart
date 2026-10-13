import 'package:flutter/material.dart';

class BonsuiSettingsItem {
  final IconData? icon;
  final Widget? iconChild;
  final String? description;
  final Widget child;
  final Color? color;
  final VoidCallback? onTap;

  BonsuiSettingsItem({
    this.icon,
    this.iconChild,
    this.description,
    required this.child,
    this.color,
    this.onTap,
  });
}
