import 'package:flutter/material.dart';

class BonsuiDialogAction {
  final String label;
  final Function? onPressed;
  final Color? color;
  final IconData? icon;

  BonsuiDialogAction(
      {required this.label, this.onPressed, this.color, this.icon});
}
