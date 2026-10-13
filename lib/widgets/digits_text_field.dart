import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiDigitsTextField extends StatefulWidget {
  const BonsuiDigitsTextField(
      {super.key,
      this.digits = 6,
      this.onChanged,
      this.width,
      this.label,
      this.placeholder,
      this.showBorder,
      this.color,
      this.shape,
      this.borderRadius,
      this.disabled});

  final int digits;
  final Function? onChanged;
  final double? width;
  final String? label;
  final String? placeholder;
  final bool? showBorder;
  final Color? color;
  final BonsuiShape? shape;
  final double? borderRadius;
  final bool? disabled;

  @override
  State<BonsuiDigitsTextField> createState() => _BonsuiDigitsTextFieldState();
}

class _BonsuiDigitsTextFieldState extends State<BonsuiDigitsTextField> {
  final List<TextEditingController> _controllers = [];

  @override
  initState() {
    super.initState();
    for (int i = 0; i < widget.digits; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: BonsuiText(
              widget.label!,
              weight: FontWeight.w600,
            ),
          ),
        SizedBox(
          width: widget.width != null
              ? (widget.width! + widget.digits * 10)
              : double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.digits, (index) {
                return SizedBox(
                  width: widget.width != null
                      ? (widget.width! / widget.digits)
                      : BonsuiUtils.dynamicWidth(context, 80 / widget.digits),
                  child: BonsuiTextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    placeholder: widget.placeholder,
                    borderRadius: _getBorderRadius(),
                    color: widget.color,
                    showBorder: widget.showBorder,
                    disabled: widget.disabled,
                    onChanged: (value) {
                      _onChange(value, index);
                    },
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                  ),
                );
              })),
        ),
      ],
    );
  }

  void _onChange(String value, int index) {
    if (value.isNotEmpty && int.tryParse(value) == null) {
      _controllers[index].text = '';
      return;
    }
    if (value.length > 1) {
      _controllers[index].text = value.substring(1, 2);
    }
    if (value.isNotEmpty && index < widget.digits - 1) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
    if (widget.onChanged != null) {
      String code = '';
      for (var controller in _controllers) {
        code += controller.text;
      }
      widget.onChanged!(code);
    }
  }

  double _getBorderRadius() {
    if (widget.borderRadius != null) {
      return widget.borderRadius!;
    } else {
      return Utils.getBorderRadiusNumber(widget.shape);
    }
  }
}
