import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';

class BonsuiSlider extends StatefulWidget {
  const BonsuiSlider({
    super.key,
    this.onChanged,
    this.value,
    this.min,
    this.max,
    this.thumbColor,
    this.activeColor,
    this.disabled,
  });

  final ValueChanged<double>? onChanged;
  final double? value;
  final double? min;
  final double? max;
  final Color? thumbColor;
  final Color? activeColor;
  final bool? disabled;

  @override
  State<BonsuiSlider> createState() => _BonsuiSliderState();
}

class _BonsuiSliderState extends State<BonsuiSlider> {
  late double _value;

  double get _min => widget.min ?? 0;
  double get _max => widget.max ?? 1;

  @override
  void initState() {
    super.initState();

    _value = widget.value ?? _min;
  }

  @override
  void didUpdateWidget(covariant BonsuiSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _value = widget.value ?? _min;
    }

    _value = _value.clamp(_min, _max);
  }

  void _onChanged(double value) {
    setState(() {
      _value = value;
    });

    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    if (BonsuiUtils.isIos()) {
      return _IosStyleSlider(
        value: _value,
        min: _min,
        max: _max,
        thumbColor: widget.thumbColor ?? Colors.white,
        activeColor: widget.activeColor ?? BonsuiDesign.primaryColor,
        onChanged: _onChanged,
        disabled: widget.disabled == true,
      );
    }

    return Slider(
      value: _value.clamp(_min, _max),
      min: _min,
      max: _max,
      thumbColor: widget.thumbColor ?? BonsuiDesign.primaryColor,
      activeColor: widget.activeColor ?? BonsuiDesign.primaryColor,
      onChanged: widget.disabled == true ? null : _onChanged,
    );
  }
}

class _IosStyleSlider extends StatelessWidget {
  const _IosStyleSlider({
    required this.value,
    required this.min,
    required this.max,
    required this.thumbColor,
    required this.activeColor,
    required this.onChanged,
    required this.disabled,
  });

  final double value;
  final double min;
  final double max;
  final Color thumbColor;
  final Color activeColor;
  final ValueChanged<double> onChanged;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final normalizedValue =
        max == min ? 0.0 : ((value - min) / (max - min)).clamp(0.0, 1.0);

    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 7,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Container(
                            width: constraints.maxWidth,
                            color: const Color(0xFFE2E2E2),
                          ),
                          Container(
                            width: constraints.maxWidth * normalizedValue,
                            color: activeColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 0,
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbColor: thumbColor,
              thumbShape: _IosPillThumbShape(
                color: thumbColor,
              ),
              overlayColor: Colors.transparent,
              overlayShape: SliderComponentShape.noOverlay,
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
              tickMarkShape: SliderTickMarkShape.noTickMark,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              onChanged: disabled == true ? null : onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _IosPillThumbShape extends SliderComponentShape {
  const _IosPillThumbShape({
    required this.color,
  });

  final Color color;
  static const double _width = 48;
  static const double _height = 24;
  static const double _activeWidth = 48;
  static const double _activeHeight = 26;

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete,
  ) {
    return const Size(
      _activeWidth,
      _activeHeight,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final active = Curves.easeOut.transform(
      activationAnimation.value,
    );

    final width = _width + ((_activeWidth - _width) * active);
    final height = _height + ((_activeHeight - _height) * active);

    final animatedCenter = Offset(
      center.dx,
      center.dy + active,
    );

    final rect = Rect.fromCenter(
      center: animatedCenter,
      width: width,
      height: height,
    );

    final thumb = RRect.fromRectAndRadius(
      rect,
      Radius.circular(height / 2),
    );

    final shadowAlpha = 0.12 + (0.04 * active);
    final shadowBlur = 6.0 - (2.0 * active);
    final shadowOffsetY = 4.0 - (1.0 * active);
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(
        alpha: shadowAlpha,
      )
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        shadowBlur,
      );

    canvas.drawRRect(
      thumb.shift(
        Offset(0, shadowOffsetY),
      ),
      shadowPaint,
    );

    final contactShadowPaint = Paint()
      ..color = Colors.black.withValues(
        alpha: 0.08 + (0.04 * active),
      )
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2,
      );

    canvas.drawRRect(
      thumb.shift(
        Offset(
          0,
          2 - active,
        ),
      ),
      contactShadowPaint,
    );

    final thumbPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      thumb,
      thumbPaint,
    );
  }
}
