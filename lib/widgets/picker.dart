import 'package:bonsui/bonsui.dart';
import 'package:flutter/cupertino.dart';

class BonsuiPicker extends StatefulWidget {
  const BonsuiPicker(
      {super.key,
      required this.selectedIndex,
      this.onSelected,
      required this.options,
      this.label,
      this.height,
      this.itemExtent});

  final int selectedIndex;
  final Function(int)? onSelected;
  final List<String> options;
  final String? label;
  final double? height;
  final double? itemExtent;

  @override
  State<BonsuiPicker> createState() => _BonsuiPickerState();
}

class _BonsuiPickerState extends State<BonsuiPicker> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label != null
            ? BonsuiText(
                widget.label!,
                size: 17,
                weight: FontWeight.w600,
              )
            : const SizedBox(),
        SizedBox(
          height: widget.height ??
              (widget.itemExtent != null
                  ? widget.itemExtent! * widget.options.length
                  : 150),
          child: _getPicker(),
        )
      ],
    );
  }

  Widget _getPicker() {
    if (BonsuiUtils.isIos()) {
      return CupertinoPicker(
        itemExtent: widget.itemExtent ?? 40,
        scrollController: FixedExtentScrollController(
          initialItem: selectedIndex,
        ),
        onSelectedItemChanged: (int index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onSelected?.call(index);
        },
        children: widget.options
            .map((e) => Center(
                  child: BonsuiText(
                    e,
                    size: 16,
                  ),
                ))
            .toList(),
      );
    } else {
      return ListWheelScrollView.useDelegate(
        itemExtent: widget.itemExtent ?? 40,
        onSelectedItemChanged: (int index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onSelected?.call(index);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (BuildContext context, int index) {
            return Center(
              child: BonsuiText(
                widget.options[index],
                size: 16,
              ),
            );
          },
          childCount: widget.options.length,
        ),
      );
    }
  }
}
