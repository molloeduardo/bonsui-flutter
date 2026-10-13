import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiCheckbox extends StatefulWidget {
  const BonsuiCheckbox({
    super.key,
    this.checked,
    this.onChanged,
    this.color,
    this.label,
    this.disabled,
    this.size,
    this.icon,
  });

  final bool? checked;
  final Function? onChanged;
  final Color? color;
  final String? label;
  final bool? disabled;
  final double? size;
  final IconData? icon;

  @override
  State<BonsuiCheckbox> createState() => _BonsuiCheckboxState();
}

class _BonsuiCheckboxState extends State<BonsuiCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(BonsuiDesign.borderRadius / 2),
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
                borderRadius: BorderRadius.circular(4),
              ),
              child: widget.checked != null && widget.checked!
                  ? Icon(_getIcon(),
                      color: BonsuiDesign.whiteColor, size: _getIconSize())
                  : null,
            ),
          ),
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(
                  left: widget.size != null ? widget.size! / 2 : 8),
              child: BonsuiText(
                widget.label!,
                color: _getTextColor(),
                size: widget.size != null ? widget.size! * 0.9 : 16,
                lineHeight: 0,
              ),
            )
        ]);
  }

  void _onTap() {
    if (widget.onChanged != null && _isToggable()) {
      widget.onChanged!(!(widget.checked ?? false));
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
    return BonsuiIcons.check;
  }

  double _getIconSize() {
    if (widget.size != null) {
      return widget.size! * 0.8;
    }
    return 16;
  }

  Color _getBackgroundColor() {
    if (widget.disabled != null && widget.disabled!) {
      return BonsuiDesign.disabledColor;
    }
    if (widget.checked != null && widget.checked!) {
      return widget.color ?? BonsuiDesign.primaryColor;
    }
    return Colors.transparent;
  }

  Color _getBorderColor() {
    if (widget.disabled != null && widget.disabled!) {
      return BonsuiDesign.disabledColor;
    }
    if (widget.color != null) {
      return widget.color!;
    }
    if (widget.checked != null && widget.checked!) {
      return BonsuiDesign.primaryColor;
    }
    return Colors.grey;
  }

  bool _isToggable() {
    return widget.disabled == null || !widget.disabled!;
  }
}
