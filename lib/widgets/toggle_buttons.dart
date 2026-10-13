import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiToggleButtons extends StatefulWidget {
  const BonsuiToggleButtons({
    super.key,
    required this.options,
    this.onToggle,
    this.shape,
    this.allowJustOne,
    this.size,
    this.textColor,
    this.width,
    this.height,
    this.showBorders,
    this.backgroundColor,
  });

  final List<BonsuiToggleButtonsItem> options;
  final Function(BonsuiToggleButtonsItem)? onToggle;
  final BonsuiShape? shape;
  final bool? allowJustOne;
  final double? size;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool? showBorders;
  final Color? backgroundColor;

  @override
  State<BonsuiToggleButtons> createState() => _BonsuiToggleButtonsState();
}

class _BonsuiToggleButtonsState extends State<BonsuiToggleButtons> {
  List<int> _selectedOptions = [];
  double _size = 16;

  @override
  void initState() {
    _loadSelectedOptions();
    if (widget.size != null) {
      _size = widget.size!;
    }
    super.initState();
  }

  @override
  didUpdateWidget(BonsuiToggleButtons oldWidget) {
    _loadSelectedOptions();
    super.didUpdateWidget(oldWidget);
  }

  void _loadSelectedOptions() {
    _selectedOptions = widget.options
        .asMap()
        .entries
        .where(
          (entry) => entry.value.isSelected != null && entry.value.isSelected!,
        )
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: widget.width != null ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: widget.height != null
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      children: widget.options
          .asMap()
          .map(
            (i, option) => MapEntry(
              i,
              _buildItem(i, option),
            ),
          )
          .values
          .toList(),
    );

    final content = Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: _getGroupBorderRadius(),
      ),
      child: row,
    );

    if (widget.width != null || widget.height != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: content,
      );
    }
    return content;
  }

  Widget _buildItem(int i, BonsuiToggleButtonsItem option) {
    final item = Material(
      color: Colors.transparent,
      borderRadius: _getBorderRadius(i),
      child: AnimatedContainer(
        duration:
            BonsuiDesign.animationDurations[BonsuiAnimationDuration.fast]!,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          border: _getBorder(i),
          borderRadius: _getBorderRadius(i),
          color: _selectedOptions.contains(i)
              ? option.color ?? BonsuiDesign.primaryColor
              : Colors.transparent,
        ),
        child: InkWell(
          splashFactory: Utils.getSplashFactory(),
          borderRadius: _getBorderRadius(i),
          onTap: option.isDisabled == null || !option.isDisabled!
              ? () {
                  if (widget.allowJustOne != null && widget.allowJustOne!) {
                    setState(() {
                      _selectedOptions = [i];
                    });
                  } else {
                    setState(() {
                      if (_selectedOptions.contains(i)) {
                        _selectedOptions.remove(i);
                      } else {
                        _selectedOptions.add(i);
                      }
                    });
                  }
                  if (widget.onToggle != null) {
                    widget.onToggle!(option);
                  }
                }
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _size * 0.8,
              vertical: _size * 0.5,
            ),
            child: Row(
              mainAxisAlignment: widget.width != null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (option.icon != null)
                  TweenAnimationBuilder<Color?>(
                    duration: BonsuiDesign
                        .animationDurations[BonsuiAnimationDuration.fast]!,
                    curve: Curves.easeOut,
                    tween: ColorTween(end: _getColor(i)),
                    builder: (context, color, child) {
                      return Icon(
                        option.icon,
                        color: color,
                        size: _size * 1.5,
                      );
                    },
                  ),
                if (option.label != null)
                  TweenAnimationBuilder<Color?>(
                    duration: BonsuiDesign
                        .animationDurations[BonsuiAnimationDuration.fast]!,
                    curve: Curves.easeOut,
                    tween: ColorTween(end: _getColor(i)),
                    builder: (context, color, child) {
                      return BonsuiText(
                        option.label!,
                        color: color,
                        size: _size,
                        weight: option.isSelected != null && option.isSelected!
                            ? FontWeight.w700
                            : FontWeight.w400,
                      );
                    },
                  ),
                option.child != null ? option.child! : Container(),
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.width != null) {
      return Expanded(child: item);
    }
    return item;
  }

  Color _getColor(int i) {
    if (widget.options[i].isDisabled != null && widget.options[i].isDisabled!) {
      return BonsuiDesign.disabledColor;
    }
    if (widget.textColor != null) {
      return widget.textColor!;
    }
    if (_selectedOptions.contains(i)) {
      return Colors.white;
    }
    if (widget.options[i].color != null) {
      return widget.options[i].color!;
    }
    if (BonsuiDesign.useDarkMode) {
      return BonsuiDesign.whiteColor;
    }
    return BonsuiDesign.textColor;
  }

  Color _getBorderColor(int i) {
    if (BonsuiDesign.useDarkMode) {
      return BonsuiUtils.darken(Colors.grey, 0.3);
    } else {
      return Colors.grey.shade300;
    }
  }

  Border? _getBorder(int i) {
    if (widget.showBorders == false) {
      return null;
    }
    final border = BorderSide(color: _getBorderColor(i));
    return Border(
      top: border,
      bottom: border,
      left: i == 0 ? border : BorderSide.none,
      right: border,
    );
  }

  BorderRadius? _getBorderRadius(int i) {
    if (widget.showBorders == false) {
      return BorderRadius.circular(Utils.getBorderRadiusNumber(widget.shape));
    }
    if (i == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(
          Utils.getBorderRadiusNumber(widget.shape),
        ),
        bottomLeft: Radius.circular(
          Utils.getBorderRadiusNumber(widget.shape),
        ),
      );
    }
    if (i == widget.options.length - 1) {
      return BorderRadius.only(
        topRight: Radius.circular(
          Utils.getBorderRadiusNumber(widget.shape),
        ),
        bottomRight: Radius.circular(
          Utils.getBorderRadiusNumber(widget.shape),
        ),
      );
    }
    return null;
  }

  BorderRadius _getGroupBorderRadius() {
    final radius = Radius.circular(Utils.getBorderRadiusNumber(widget.shape));
    return BorderRadius.horizontal(left: radius, right: radius);
  }
}
