import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/material.dart';

class BonsuiRating extends StatefulWidget {
  const BonsuiRating({
    super.key,
    this.max,
    this.icon,
    this.onTap,
    required this.rating,
    this.color,
    this.disabled,
    this.size,
  });

  final int? max;
  final IconData? icon;
  final Function(int)? onTap;
  final int rating;
  final Color? color;
  final bool? disabled;
  final double? size;

  @override
  State<BonsuiRating> createState() => _BonsuiRatingState();
}

class _BonsuiRatingState extends State<BonsuiRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.max ?? 5, (index) {
        return GestureDetector(
          onTap:
              widget.disabled == true ? null : () => widget.onTap!(index + 1),
          child: TweenAnimationBuilder<Color?>(
            duration:
                BonsuiDesign.animationDurations[BonsuiAnimationDuration.fast]!,
            curve: Curves.easeOut,
            tween: ColorTween(end: _getColor(index)),
            builder: (context, color, child) {
              return Icon(
                widget.icon ?? BonsuiIcons.star,
                color: color,
                size: widget.size ?? 30,
              );
            },
          ),
        );
      }),
    );
  }

  Color _getColor(int index) {
    if (index < widget.rating) {
      return widget.color ?? Colors.yellow.shade600;
    }
    return Colors.grey.withAlpha(60);
  }
}
