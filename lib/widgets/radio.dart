import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiRadio extends StatefulWidget {
  const BonsuiRadio({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
    this.label,
    required this.groupValue,
    this.disabled,
    this.size,
    this.icon,
  });

  final dynamic value;
  final dynamic groupValue;
  final Function onChanged;
  final Color? color;
  final String? label;
  final bool? disabled;
  final double? size;
  final IconData? icon;

  @override
  State<BonsuiRadio> createState() => _BonsuiRadioState();
}

class _BonsuiRadioState extends State<BonsuiRadio> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(50),
              splashFactory: Utils.getSplashFactory(),
              onTap: _onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: widget.size ?? 20,
                height: widget.size ?? 20,
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  border: Border.all(
                    color: _getBorderColor(),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: widget.value == widget.groupValue
                    ? Icon(_getIcon(),
                        color: BonsuiDesign.whiteColor, size: _getIconSize())
                    : null,
              ),
            ),
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: BonsuiText(
                  widget.label!,
                  color: _getTextColor(),
                ),
              )
          ],
        ));
  }

  void _onTap() {
    if (_isToggable()) {
      widget.onChanged(widget.value);
    }
  }

  Color _getTextColor() {
    if (widget.color != null) {
      return widget.color!;
    }
    if (BonsuiDesign.useDarkMode) {
      return BonsuiDesign.whiteColor;
    }
    return BonsuiDesign.textColor;
  }

  IconData _getIcon() {
    if (widget.icon != null) {
      return widget.icon!;
    }
    return BonsuiIcons.circle;
  }

  double _getIconSize() {
    if (widget.size != null) {
      if (widget.icon != null) {
        return widget.size! * 0.8;
      } else {
        return widget.size! * 0.45;
      }
    }
    if (widget.icon != null) {
      return 16;
    }
    return 10;
  }

  Color _getBackgroundColor() {
    if (widget.disabled != null && widget.disabled!) {
      return BonsuiDesign.disabledColor;
    }
    if (widget.value == widget.groupValue) {
      return widget.color ?? BonsuiDesign.primaryColor;
    }
    return Colors.transparent;
  }

  bool _isToggable() {
    return widget.disabled == null || !widget.disabled!;
  }

  Color _getBorderColor() {
    if (widget.disabled != null && widget.disabled!) {
      return BonsuiDesign.disabledColor;
    }
    if (widget.color != null) {
      return widget.color!;
    }
    if (widget.value == widget.groupValue) {
      return BonsuiDesign.primaryColor;
    }
    return Colors.grey;
  }
}
