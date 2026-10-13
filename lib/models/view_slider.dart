import 'package:flutter/material.dart';

class BonsuiViewSliderOption {
  final String title;
  final bool isSelected;
  final Widget content;
  final Padding? contentPadding;

  BonsuiViewSliderOption({
    required this.title,
    required this.isSelected,
    required this.content,
    this.contentPadding,
  });
}
