import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiChipChoice extends StatefulWidget {
  const BonsuiChipChoice({
    super.key,
    this.selected,
    required this.items,
    required this.onSelect,
    this.shape,
    this.label,
    this.secondaryLabel,
  });

  final dynamic selected;
  final List<BonsuiChipChoiceItem> items;
  final Function(dynamic) onSelect;
  final BonsuiShape? shape;
  final String? label;
  final String? secondaryLabel;

  @override
  State<BonsuiChipChoice> createState() => _BonsuiChipChoiceState();
}

class _BonsuiChipChoiceState extends State<BonsuiChipChoice> {
  dynamic selectedValue;

  @override
  void initState() {
    if (widget.selected != null) {
      selectedValue = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Column(
          children: [
            if (widget.label != null || widget.secondaryLabel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  children: [
                    if (widget.label != null)
                      BonsuiText(
                        widget.label!,
                        weight: FontWeight.w700,
                        size: 13,
                        align: TextAlign.start,
                      ),
                    if (widget.secondaryLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: BonsuiText(
                          widget.secondaryLabel!,
                          weight: FontWeight.w600,
                          size: 13,
                          align: TextAlign.start,
                          color: Colors.grey.shade500,
                        ),
                      ),
                  ],
                ),
              ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  widget.items.length,
                  (int index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: Utils.getBorderRadius(
                            widget.shape,
                          ),
                          splashFactory: Utils.getSplashFactory(),
                          onTap: widget.items[index].disabled != null &&
                                  widget.items[index].disabled!
                              ? null
                              : () {
                                  setState(() {
                                    if (widget.items[index].value ==
                                        selectedValue) {
                                      selectedValue = null;
                                      widget.onSelect(null);
                                      return;
                                    }
                                    selectedValue = widget.items[index].value;
                                    widget.onSelect(selectedValue);
                                  });
                                },
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                              color: _getChipColor(
                                widget.items[index],
                              ),
                              border: Border.all(
                                color: _getBorderColor(
                                  widget.items[index],
                                ),
                              ),
                              borderRadius: Utils.getBorderRadius(widget.shape),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            duration: BonsuiDesign.animationDurations[
                                BonsuiAnimationDuration.fast]!,
                            child: Row(
                              children: [
                                if (widget.items[index].icon != null)
                                  Row(
                                    children: [
                                      Icon(
                                        widget.items[index].icon,
                                        color: _getTextColor(
                                          widget.items[index],
                                        ),
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                if (widget.items[index].label != null)
                                  Text(
                                    widget.items[index].label!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _getTextColor(
                                        widget.items[index],
                                      ),
                                      fontSize: 13,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Color? _getChipColor(BonsuiChipChoiceItem item) {
    if (item.disabled != null && item.disabled!) {
      return BonsuiDesign.disabledColor.withAlpha(140);
    }
    if (item.value == selectedValue) {
      if (item.color != null) {
        return item.color!;
      } else {
        return BonsuiDesign.primaryColor;
      }
    }
    if (item.solid != null && item.solid!) {
      if (item.color != null) {
        return item.color!.withAlpha(35);
      } else {
        return BonsuiDesign.primaryColor.withAlpha(35);
      }
    }
    return null;
  }

  Color _getBorderColor(BonsuiChipChoiceItem item) {
    if (item.disabled != null && item.disabled!) {
      return BonsuiDesign.disabledColor.withAlpha(140);
    }
    if (item.solid != null && item.solid!) {
      if (item.color != null) {
        return item.color!.withAlpha(item.value == selectedValue ? 255 : 50);
      } else {
        return BonsuiDesign.primaryColor
            .withAlpha(item.value == selectedValue ? 255 : 50);
      }
    }
    if (item.color != null) {
      return item.color!;
    } else {
      return BonsuiDesign.borderColor;
    }
  }

  Color _getTextColor(BonsuiChipChoiceItem item) {
    if (item.disabled != null && item.disabled!) {
      return BonsuiDesign.textColor.withAlpha(100);
    }
    if (item.value == selectedValue) {
      return Colors.white;
    }
    if (item.color != null) {
      return item.color!;
    } else {
      if (BonsuiDesign.useDarkMode) {
        return Colors.white;
      }
      return BonsuiDesign.textColor;
    }
  }
}
