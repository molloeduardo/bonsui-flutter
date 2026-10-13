import 'package:bonsui/bonsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonsuiSwitch extends StatefulWidget {
  const BonsuiSwitch({
    super.key,
    this.checked,
    this.onChanged,
    this.color,
    this.label,
    this.disabled,
    this.spaceBetween,
    this.alignment,
  });

  final bool? checked;
  final Function? onChanged;
  final Color? color;
  final String? label;
  final bool? disabled;
  final bool? spaceBetween;
  final Alignment? alignment;

  @override
  State<BonsuiSwitch> createState() => _BonsuiSwitchState();
}

class _BonsuiSwitchState extends State<BonsuiSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: widget.spaceBetween != null && widget.spaceBetween!
            ? MainAxisSize.max
            : MainAxisSize.min,
        mainAxisAlignment: widget.spaceBetween != null && widget.spaceBetween!
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.label != null &&
              (widget.spaceBetween != null && widget.spaceBetween!))
            _getLabel(4),
          if (BonsuiUtils.isIos()) _getIosSwitch(),
          if (!BonsuiUtils.isIos()) _getAndroidSwitch(),
          if (widget.label != null &&
              (widget.spaceBetween == null || !widget.spaceBetween!))
            _getLabel(14),
        ]);
  }

  BonsuiText _getLabel(double padding) {
    return BonsuiText(
      widget.label!,
      lineHeight: 0,
      padding: EdgeInsets.only(left: padding),
      weight: FontWeight.w600,
      size: 14,
    );
  }

  Widget _getIosSwitch() {
    return SizedBox(
      width: 43,
      child: Transform.scale(
        scale: 0.7,
        alignment: widget.alignment ?? Alignment.centerRight,
        child: CupertinoSwitch(
          inactiveTrackColor:
              BonsuiDesign.useDarkMode ? const Color(0xff303030) : null,
          activeTrackColor: _getColor(),
          value: widget.checked ?? false,
          onChanged: widget.onChanged != null && _isToggable()
              ? (value) => widget.onChanged!(value)
              : null,
        ),
      ),
    );
  }

  Widget _getAndroidSwitch() {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        trackColor: WidgetStateProperty.all(
          BonsuiDesign.useDarkMode ? const Color(0xff303030) : null,
        ),
        activeTrackColor: _getColor(),
        value: widget.checked ?? false,
        onChanged: widget.onChanged != null && _isToggable()
            ? (value) => widget.onChanged!(value)
            : null,
      ),
    );
  }

  Color _getColor() {
    if (widget.disabled != null && widget.disabled!) {
      return BonsuiDesign.disabledColor;
    } else if (widget.color != null) {
      return widget.color!;
    } else {
      return BonsuiDesign.primaryColor;
    }
  }

  bool _isToggable() {
    return widget.disabled == null || !widget.disabled!;
  }
}
