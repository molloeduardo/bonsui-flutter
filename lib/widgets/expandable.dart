import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiExpandableCard extends StatefulWidget {
  const BonsuiExpandableCard({
    super.key,
    required this.title,
    required this.child,
    this.filled = true,
    this.color,
    this.icon,
    this.shape,
    this.onTap,
    this.padding,
  });

  final String title;
  final Widget child;
  final bool filled;
  final Color? color;
  final IconData? icon;
  final BonsuiShape? shape;
  final Function? onTap;
  final EdgeInsets? padding;

  @override
  State<BonsuiExpandableCard> createState() => _BonsuiExpandableCardState();
}

class _BonsuiExpandableCardState extends State<BonsuiExpandableCard>
    with TickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    super.initState();
  }

  void _toggleContainer() {
    if (!_isOpen) {
      _controller.forward();
    } else {
      _controller.animateBack(0,
          duration:
              BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!);
    }
    _isOpen = !_isOpen;
    if (widget.onTap != null) {
      widget.onTap!(_isOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Utils.getBorderRadius(widget.shape),
      splashFactory: Utils.getSplashFactory(),
      onTap: () => setState(() => _toggleContainer()),
      child: Ink(
        decoration: BoxDecoration(
          color: widget.filled
              ? widget.color != null
                  ? widget.color!.withValues(alpha: 0.1)
                  : BonsuiDesign.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: Utils.getBorderRadius(widget.shape),
          boxShadow: widget.color != null
              ? [
                  BoxShadow(
                    color: BonsuiDesign.useDarkMode
                        ? Colors.black.withValues(alpha: 0.35)
                        : Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: BonsuiDesign.spacing,
            horizontal: BonsuiDesign.spacing * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.icon != null)
                        Padding(
                          padding: EdgeInsets.only(right: BonsuiDesign.spacing),
                          child: Icon(
                            widget.icon,
                            color: widget.color ?? BonsuiDesign.primaryColor,
                            size: 20,
                          ),
                        ),
                      BonsuiText(
                        widget.title,
                        lineHeight: 0,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
                    duration: BonsuiDesign
                        .animationDurations[BonsuiAnimationDuration.medium]!,
                    child: Icon(
                      Icons.expand_more,
                      color: BonsuiDesign.useDarkMode
                          ? Colors.white
                          : BonsuiDesign.textColor,
                    ),
                  )
                ],
              ),
              SizeTransition(
                sizeFactor: _animation,
                axis: Axis.vertical,
                child: Padding(
                  padding: widget.padding ??
                      EdgeInsets.only(
                        top: BonsuiDesign.spacing / 2,
                        bottom: BonsuiDesign.spacing / 3,
                      ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
