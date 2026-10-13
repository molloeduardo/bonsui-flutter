import 'dart:math' as math;

import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiBottomNavigationBar extends StatefulWidget {
  const BonsuiBottomNavigationBar(
      {super.key,
      required this.items,
      this.onTap,
      required this.currentIndex,
      this.backgroundColor,
      this.selectedColor,
      this.unselectedColor,
      this.showSelectedLabel = true,
      this.showUnselectedLabel,
      this.horizontalLayout = true,
      this.labelSize,
      this.shape = BonsuiShape.rounded});

  final List<BonsuiBottomNavigationBarItem> items;
  final Function(int)? onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool? showSelectedLabel;
  final bool? showUnselectedLabel;
  final bool? horizontalLayout;
  final double? labelSize;
  final BonsuiShape? shape;

  @override
  State<BonsuiBottomNavigationBar> createState() =>
      _BonsuiBottomNavigationBarState();
}

class _BonsuiBottomNavigationBarState extends State<BonsuiBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  int? _bouncingIndex;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && _bouncingIndex != null) {
          setState(() {
            _bouncingIndex = null;
          });
        }
      });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final extraBottomPadding = widget.horizontalLayout == true ? 12.0 : 4.0;
    final bottomPadding = safeAreaBottom > 0
        ? safeAreaBottom + (BonsuiUtils.isIos() ? 0 : extraBottomPadding)
        : extraBottomPadding;
    final minHeight = bottomPadding + 55;

    return Container(
      width: double.infinity,
      height: widget.horizontalLayout == true ? minHeight : null,
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        boxShadow: [
          BoxShadow(
            color: BonsuiDesign.useDarkMode
                ? Colors.grey.shade800.withValues(
                    alpha: 0.25,
                  )
                : Colors.grey.withValues(
                    alpha: 0.25,
                  ),
            blurRadius: 18,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: bottomPadding,
        top: 12,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.map((item) {
              int index = widget.items.indexOf(item);
              bool isSelected = index == widget.currentIndex;
              return InkWell(
                  borderRadius:
                      BorderRadius.circular(_getBorderRadius(isSelected)),
                  radius: _getBorderRadius(isSelected),
                  splashFactory: Utils.getSplashFactory(),
                  highlightColor: _getHighlighColor(item),
                  focusColor: _getHighlighColor(item),
                  splashColor: _getHighlighColor(item),
                  onTap: () {
                    if (index != widget.currentIndex) {
                      setState(() {
                        _bouncingIndex = index;
                      });
                      Future.delayed(const Duration(milliseconds: 100), () {
                        if (!mounted || _bouncingIndex != index) {
                          return;
                        }
                        _bounceController.forward(from: 0);
                      });
                    }
                    if (widget.onTap != null) {
                      widget.onTap!(index);
                    }
                  },
                  child: AnimatedContainer(
                      duration: _containerDuration,
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.horizontalLayout == true
                            ? (isSelected ? 14 : 10)
                            : 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(_getBorderRadius(isSelected)),
                        color: _getItemBackgroundColor(item, isSelected),
                      ),
                      child: widget.horizontalLayout != null &&
                              widget.horizontalLayout == true
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: _getItem(item, isSelected, index),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: _getItem(item, isSelected, index),
                            )));
            }).toList()),
      ),
    );
  }

  Color _getHighlighColor(BonsuiBottomNavigationBarItem item) {
    if (item.color != null) {
      return item.color!.withAlpha(25);
    }
    return BonsuiDesign.primaryColor.withAlpha(25);
  }

  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }
    if (BonsuiDesign.useDarkMode) {
      return const Color(0xff090909);
    }
    return BonsuiUtils.lighten(BonsuiDesign.primaryColor, 0.44);
  }

  Color _getItemBackgroundColor(
      BonsuiBottomNavigationBarItem item, bool isSelected) {
    if (widget.horizontalLayout == true && isSelected) {
      return _getColor(item, true).withValues(alpha: 0.12);
    }
    return Colors.transparent;
  }

  double _getFontSize() {
    if (widget.labelSize != null) {
      return widget.labelSize!;
    }
    if (widget.horizontalLayout == true) {
      return 14;
    }
    return 12;
  }

  Duration get _containerDuration {
    if (widget.horizontalLayout == true) {
      return const Duration(milliseconds: 300);
    }
    return const Duration(milliseconds: 200);
  }

  double _getIconSize(bool isSelected) {
    if (widget.horizontalLayout == true) {
      return 22;
    }
    if (widget.showSelectedLabel == true && isSelected) {
      return 22;
    }
    if (widget.showUnselectedLabel == true && !isSelected) {
      return 24;
    }
    return 28;
  }

  double _getBorderRadius(bool isSelected) {
    return Utils.getBorderRadiusNumber(
        widget.shape ?? BonsuiDesign.defaultElementsShape);
  }

  List<Widget> _getItem(
      BonsuiBottomNavigationBarItem item, bool isSelected, int index) {
    final bool showLabel = _shouldShowLabel(isSelected);
    return [
      if ((item.icon != null &&
              (item.activeWidgetIcon == null ||
                  !isSelected && item.activeWidgetIcon != null)) ||
          (item.activeIcon != null && isSelected))
        _buildBouncingIcon(
          index,
          BonsuiIcon(
            isSelected && item.activeIcon != null
                ? item.activeIcon!
                : item.icon!,
            size: _getIconSize(isSelected),
            color: _getColor(item, isSelected),
          ),
        ),
      if (item.widgetIcon != null && !isSelected)
        _buildBouncingIcon(index, item.widgetIcon!),
      if (item.activeWidgetIcon != null && isSelected)
        _buildBouncingIcon(index, item.activeWidgetIcon!),
      ClipRect(
        child: AnimatedSize(
          duration:
              Duration(milliseconds: widget.horizontalLayout == true ? 300 : 1),
          curve: Curves.easeOutCubic,
          alignment: Alignment.centerLeft,
          child: showLabel
              ? AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.horizontalLayout == true ? 8 : 0,
                      top: widget.horizontalLayout == null ||
                              widget.horizontalLayout == false
                          ? 3
                          : 0,
                    ),
                    child: item.label != null
                        ? BonsuiText(
                            lineHeight: 0,
                            item.label!,
                            size: _getFontSize(),
                            color: _getColor(item, isSelected),
                            weight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          )
                        : null,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    ];
  }

  bool _shouldShowLabel(bool isSelected) {
    if (isSelected && widget.showSelectedLabel == true) {
      return true;
    }
    if (!isSelected && widget.showUnselectedLabel == true) {
      return true;
    }
    return false;
  }

  Widget _buildBouncingIcon(int index, Widget child) {
    return AnimatedBuilder(
      animation: _bounceController,
      child: child,
      builder: (context, iconChild) {
        final bool isBouncing = _bouncingIndex == index;
        if (!isBouncing) {
          return iconChild!;
        }
        final double value = Curves.easeOut.transform(_bounceController.value);
        const double amplitude = 4;
        const double oscillations = 3;
        final double offsetY = -math.sin(value * math.pi * oscillations).abs() *
            amplitude *
            (1 - value);
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: iconChild,
        );
      },
    );
  }

  Color _getColor(BonsuiBottomNavigationBarItem item, bool isSelected) {
    if (item.color != null) {
      if (isSelected) {
        return item.color!;
      }
      return item.color!.withAlpha(120);
    }
    if (isSelected) {
      return widget.selectedColor ?? BonsuiDesign.primaryColor;
    }
    if (widget.unselectedColor != null) {
      return widget.unselectedColor!;
    }
    if (widget.horizontalLayout != null && widget.horizontalLayout == true) {
      return BonsuiDesign.primaryColor;
    } else {
      return Colors.grey.shade500;
    }
  }
}
