import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';

class BonsuiProgressBar extends StatefulWidget {
  const BonsuiProgressBar({
    super.key,
    required this.percentage,
    this.color,
    this.removeAnimation,
    this.height,
    required this.width,
    this.borderRadius,
    this.label,
    this.showPercentageLabel,
  });

  final double percentage;
  final Color? color;
  final bool? removeAnimation;
  final double? height;
  final double? borderRadius;
  final String? label;
  final bool? showPercentageLabel;
  final double width;

  @override
  State<BonsuiProgressBar> createState() => _BonsuiProgressBarState();
}

class _BonsuiProgressBarState extends State<BonsuiProgressBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: Duration(
              milliseconds:
                  widget.removeAnimation != null && widget.removeAnimation!
                      ? 0
                      : 500,
            ),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: widget.percentage / 100,
            ),
            builder: (context, value, _) => LinearProgressIndicator(
              minHeight: widget.height,
              backgroundColor: widget.color != null
                  ? widget.color!.withAlpha(50)
                  : BonsuiDesign.primaryColor.withAlpha(50),
              color: widget.color ?? BonsuiDesign.primaryColor,
              value: value,
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? BonsuiDesign.borderRadius,
              ),
            ),
          ),
          if (widget.label != null || widget.showPercentageLabel != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: _getLabelsAlignment(),
                children: [
                  if (widget.label != null)
                    BonsuiText(
                      widget.label!,
                      color: widget.color ?? BonsuiDesign.primaryColor,
                      size: 14,
                    ),
                  if (widget.showPercentageLabel != null &&
                      widget.showPercentageLabel!)
                    BonsuiText(
                      _percentageLabel(),
                      color: widget.color ?? BonsuiDesign.primaryColor,
                      size: 14,
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }

  MainAxisAlignment _getLabelsAlignment() {
    if (widget.label != null && widget.showPercentageLabel != null) {
      return MainAxisAlignment.spaceBetween;
    } else if (widget.label != null) {
      return MainAxisAlignment.start;
    } else {
      return MainAxisAlignment.end;
    }
  }

  String _percentageLabel() {
    if (widget.percentage % 1 == 0) {
      return '${widget.percentage.toInt()}%';
    } else {
      return '${widget.percentage.toStringAsFixed(1)}%';
    }
  }
}
