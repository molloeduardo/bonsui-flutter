import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/material.dart';

class BonsuiStepper extends StatefulWidget {
  const BonsuiStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.onStepChange,
    this.hideNumbers,
    this.hideSeparators,
    this.separatorSize,
    this.separatorType,
    this.shape,
    this.disabled,
    this.color,
    this.readonly,
    this.vertical,
    this.activeStepWidth,
  });

  final int totalSteps;
  final int currentStep;
  final Function(int)? onStepChange;
  final bool? hideNumbers;
  final bool? hideSeparators;
  final int? separatorSize;
  final BonsuiStepperSeparatorType? separatorType;
  final BonsuiShape? shape;
  final bool? disabled;
  final Color? color;
  final bool? readonly;
  final bool? vertical;
  final int? activeStepWidth;

  @override
  State<BonsuiStepper> createState() => _BonsuiStepperState();
}

class _BonsuiStepperState extends State<BonsuiStepper> {
  final int _selectedAlpha = 130;

  @override
  Widget build(BuildContext context) {
    if (widget.vertical != null && widget.vertical!) {
      return Column(
        children: _getContent(),
      );
    } else {
      return Row(
        children: _getContent(),
      );
    }
  }

  List<Widget> _getContent() {
    return List.generate(widget.totalSteps, (index) {
      if (widget.vertical != null && widget.vertical!) {
        return Column(
          children: _getInnerContent(index),
        );
      } else {
        return Row(
          children: _getInnerContent(index),
        );
      }
    });
  }

  List<Widget> _getInnerContent(int index) {
    return [
      GestureDetector(
        onTap: () => _goToStep(index),
        child: AnimatedContainer(
          duration:
              BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
          curve: Curves.easeIn,
          width: _getWidth(index),
          height: _getHeight(index),
          decoration: BoxDecoration(
            color: _getColor(index),
            borderRadius: BorderRadius.circular(
              _getBorderRadius(),
            ),
          ),
          child: widget.hideNumbers == null || !widget.hideNumbers!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: BonsuiDesign.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : null,
        ),
      ),

      if (widget.vertical != null &&
          widget.vertical! &&
          (widget.separatorType == null ||
              widget.separatorType == BonsuiStepperSeparatorType.dots))
        const SizedBox(
          height: 4,
        )
      else if (widget.separatorType == null ||
          widget.separatorType == BonsuiStepperSeparatorType.dots)
        const SizedBox(
          width: 4,
        ),

      // Dashes separator
      if ((widget.hideSeparators == null || !widget.hideSeparators!) &&
          index < widget.totalSteps - 1)
        _getSeparator(index)
    ];
  }

  Widget _getSeparator(int step) {
    int size = 3;
    if (widget.separatorSize != null) {
      size = widget.separatorSize!;
    }
    if (widget.vertical != null && widget.vertical!) {
      return Column(
        children: _getSeparatorContent(size, step),
      );
    } else {
      return Row(
        children: _getSeparatorContent(size, step),
      );
    }
  }

  List<Padding> _getSeparatorContent(int size, int step) {
    if (widget.separatorType == null ||
        widget.separatorType == BonsuiStepperSeparatorType.dots) {
      return List.generate(
        size,
        (index) => Padding(
          padding: widget.vertical != null && widget.vertical!
              ? const EdgeInsets.only(bottom: 4)
              : const EdgeInsets.only(right: 4),
          child: AnimatedContainer(
            duration: BonsuiDesign
                .animationDurations[BonsuiAnimationDuration.medium]!,
            curve: Curves.easeIn,
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: (step + 1) < widget.currentStep
                  ? widget.color != null
                      ? widget.color!.withAlpha(_selectedAlpha)
                      : BonsuiDesign.primaryColor.withAlpha(_selectedAlpha)
                  : BonsuiDesign.useDarkMode
                      ? Colors.grey.shade800
                      : Colors.black12,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      return [
        Padding(
          padding: EdgeInsets.zero,
          child: AnimatedContainer(
            duration: BonsuiDesign
                .animationDurations[BonsuiAnimationDuration.medium]!,
            curve: Curves.easeIn,
            width: widget.vertical != null && widget.vertical!
                ? 2
                : widget.separatorSize != null
                    ? widget.separatorSize!.toDouble()
                    : 50,
            height: widget.vertical != null && widget.vertical!
                ? widget.separatorSize != null
                    ? widget.separatorSize!.toDouble()
                    : 50
                : 2,
            decoration: BoxDecoration(
              color: (step + 1) < widget.currentStep
                  ? widget.color != null
                      ? widget.color!.withAlpha(_selectedAlpha)
                      : BonsuiDesign.primaryColor.withAlpha(_selectedAlpha)
                  : BonsuiDesign.useDarkMode
                      ? Colors.grey.shade800
                      : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )
      ];
    }
  }

  double _getWidth(int index) {
    if (widget.hideNumbers == null || !widget.hideNumbers!) {
      return 24;
    }
    if (widget.currentStep == (index + 1) &&
        (widget.vertical == null || !widget.vertical!)) {
      if (widget.activeStepWidth != null) {
        return widget.activeStepWidth!.toDouble();
      }
      return 42;
    } else {
      return 12;
    }
  }

  double _getHeight(int index) {
    if (widget.hideNumbers == null || !widget.hideNumbers!) {
      return 24;
    } else {
      if (widget.vertical != null &&
          widget.vertical! &&
          widget.currentStep == (index + 1)) {
        return 42;
      }
      return 12;
    }
  }

  double _getBorderRadius() {
    if (widget.shape == null || widget.shape == BonsuiShape.rounded) {
      return 20;
    }
    if (widget.shape == BonsuiShape.squared) {
      return 0;
    }
    return BonsuiDesign.borderRadius;
  }

  Color _getColor(int index) {
    Color baseColor = BonsuiDesign.primaryColor;
    if (widget.color != null) {
      baseColor = widget.color!;
    }
    if (widget.disabled != null && widget.disabled!) {
      if (BonsuiDesign.useDarkMode) {
        return BonsuiUtils.darken(BonsuiDesign.disabledColor, 0.5);
      } else {
        return BonsuiDesign.disabledColor;
      }
    }
    if (widget.hideSeparators == null || !widget.hideSeparators!) {
      if ((index + 1) < widget.currentStep) {
        return baseColor.withAlpha(_selectedAlpha);
      } else if ((index + 1) == widget.currentStep) {
        return baseColor;
      } else {
        if (BonsuiDesign.useDarkMode) {
          return Colors.grey.shade900;
        }
        return Colors.black12;
      }
    }
    if (widget.currentStep == (index + 1)) {
      if (widget.color == null) {
        return BonsuiDesign.primaryColor;
      } else {
        return widget.color!;
      }
    }
    if (BonsuiDesign.useDarkMode) {
      return Colors.grey.shade900;
    }
    return Colors.black12;
  }

  void _goToStep(int step) {
    if (widget.onStepChange != null &&
        (widget.disabled == null || !widget.disabled!) &&
        (widget.readonly == null || !widget.readonly!)) {
      widget.onStepChange!(step + 1);
    }
  }
}
