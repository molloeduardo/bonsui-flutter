import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../design.dart';

class BonsuiChart extends StatefulWidget {
  const BonsuiChart({
    super.key,
    required this.xValues,
    required this.yValues,
    this.height = 220.0,
    this.lineColors,
    this.yUnit,
    this.yUnitOnlyInTooltip = false,
  });

  final List<dynamic> xValues;
  final List<dynamic> yValues;
  final double height;
  final List<Color>? lineColors;

  final String? yUnit;

  final bool yUnitOnlyInTooltip;

  @override
  State<BonsuiChart> createState() => _BonsuiChartState();
}

class _BonsuiChartState extends State<BonsuiChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void didUpdateWidget(covariant BonsuiChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.yValues, widget.yValues)) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap(Offset position, _ChartGeometry geometry) {
    final index = geometry.nearestIndex(position);
    setState(() => _selectedIndex = index == _selectedIndex ? null : index);
  }

  List<Color> _colors(int count) {
    final colors = widget.lineColors ??
        [
          BonsuiDesign.primaryColor,
          BonsuiDesign.successColor,
        ];
    return List.generate(count, (index) => colors[index % colors.length]);
  }

  String _formatValue(double value, {bool includeUnit = true}) {
    final text = value == value.roundToDouble()
        ? value.round().toString()
        : value.toStringAsFixed(1);
    return includeUnit && widget.yUnit != null ? '$text ${widget.yUnit}' : text;
  }

  String _formatAxisValue(double value) => _formatValue(
        value,
        includeUnit: !widget.yUnitOnlyInTooltip,
      );

  @override
  Widget build(BuildContext context) {
    final values = widget.yValues
        .map((dataset) => (dataset as List)
            .map((value) => (value as num).toDouble())
            .toList())
        .toList();
    final labels = widget.xValues.map((value) => value.toString()).toList();
    final colors = _colors(values.length);

    if (values.isEmpty || values.every((dataset) => dataset.isEmpty)) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, widget.height);
        final geometry = _ChartGeometry(values: values, size: size);

        return SizedBox(
          height: widget.height,
          width: double.infinity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) => _handleTap(details.localPosition, geometry),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                final progress = CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOutCubic,
                ).value;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: size,
                      painter: _BonsuiChartPainter(
                        xLabels: labels,
                        geometry: geometry,
                        lineColors: colors,
                        selectedIndex: _selectedIndex,
                        progress: progress,
                        formatValue: _formatAxisValue,
                      ),
                    ),
                    if (_selectedIndex != null)
                      _buildTooltip(geometry, labels, values, colors),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTooltip(
    _ChartGeometry geometry,
    List<String> labels,
    List<List<double>> values,
    List<Color> colors,
  ) {
    final index = _selectedIndex!;
    final point = geometry.pointAt(0, index);
    const tooltipWidth = 90.0;
    final maxLeft = geometry.rect.right - tooltipWidth;
    final left = (point.dx - tooltipWidth / 2).clamp(geometry.rect.left,
        maxLeft < geometry.rect.left ? geometry.rect.left : maxLeft);

    return Positioned(
      left: left,
      top: (point.dy - 52).clamp(0.0, double.infinity),
      child: IgnorePointer(
        child: TweenAnimationBuilder<double>(
          key: ValueKey(index),
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,
          builder: (context, value, child) => Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: value,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
          child: Container(
            width: tooltipWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _labelAt(labels, index),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                ),
                const SizedBox(height: 2),
                for (var datasetIndex = 0;
                    datasetIndex < values.length;
                    datasetIndex++)
                  if (index < values[datasetIndex].length)
                    Text(
                      _formatValue(values[datasetIndex][index]),
                      style: TextStyle(
                        color: colors[datasetIndex],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelAt(List<String> labels, int index) {
    return index < labels.length ? labels[index] : '';
  }
}

class _ChartGeometry {
  _ChartGeometry({required this.values, required Size size})
      : rect = Rect.fromLTWH(
          yAxisWidth,
          0,
          size.width - yAxisWidth,
          size.height - xAxisHeight,
        ) {
    final allValues = values.expand((dataset) => dataset).toList();
    final maxValue = allValues.reduce((a, b) => a > b ? a : b);
    final minValue = allValues.reduce((a, b) => a < b ? a : b);
    final hasDecimalValues = allValues.any((v) => v != v.roundToDouble());
    final range = maxValue == minValue ? 1.0 : maxValue - minValue;
    final niceRange = _niceNumber(range, round: false);
    var step = _niceNumber(niceRange / (_targetGridLines - 1), round: true);
    if (!hasDecimalValues && step < 0.5) step = 0.5;

    var min = (minValue / step).floor() * step;
    var max = (maxValue / step).ceil() * step;
    if (min >= minValue) min -= step;
    if (max <= maxValue) max += step;

    gridMin = min;
    gridMax = max;
    gridValues = List.generate(
      ((max - min) / step).round() + 1,
      (index) => min + index * step,
    );
  }

  static const yAxisWidth = 30.0;
  static const xAxisHeight = 46.0;
  static const _pointInset = 7.0;
  static const _targetGridLines = 5;

  final List<List<double>> values;
  final Rect rect;
  late final double gridMin;
  late final double gridMax;
  late final List<double> gridValues;

  static double _niceNumber(double value, {required bool round}) {
    final exponent = (math.log(value) / math.ln10).floor();
    final magnitude = math.pow(10, exponent).toDouble();
    final fraction = value / magnitude;
    double niceFraction;

    if (round) {
      if (fraction < 1.5) {
        niceFraction = 1;
      } else if (fraction < 3) {
        niceFraction = 2;
      } else if (fraction < 7) {
        niceFraction = 5;
      } else {
        niceFraction = 10;
      }
    } else {
      if (fraction <= 1) {
        niceFraction = 1;
      } else if (fraction <= 2) {
        niceFraction = 2;
      } else if (fraction <= 5) {
        niceFraction = 5;
      } else {
        niceFraction = 10;
      }
    }

    return niceFraction * magnitude;
  }

  double yForValue(double value) {
    final ratio = (value - gridMin) / (gridMax - gridMin);
    return rect.bottom - ratio * rect.height;
  }

  double xForIndex(int index) {
    final plotWidth = rect.width - _pointInset * 2;
    final pointCount = values.fold<int>(
        0, (count, dataset) => math.max(count, dataset.length));
    if (pointCount == 1) return rect.left + rect.width / 2;
    return rect.left + _pointInset + (index / (pointCount - 1)) * plotWidth;
  }

  Offset pointAt(int datasetIndex, int index) => Offset(
        xForIndex(index),
        yForValue(values[datasetIndex][index]),
      );

  int? nearestIndex(Offset position, {double maxDistance = 24}) {
    int? closestIndex;
    var closestDistance = double.infinity;
    for (var datasetIndex = 0; datasetIndex < values.length; datasetIndex++) {
      for (var i = 0; i < values[datasetIndex].length; i++) {
        final distance = (pointAt(datasetIndex, i) - position).distance;
        if (distance < closestDistance) {
          closestDistance = distance;
          closestIndex = i;
        }
      }
    }
    return closestDistance <= maxDistance ? closestIndex : null;
  }
}

class _BonsuiChartPainter extends CustomPainter {
  _BonsuiChartPainter({
    required this.xLabels,
    required this.geometry,
    required this.lineColors,
    required this.progress,
    required this.formatValue,
    this.selectedIndex,
  });

  final List<String> xLabels;
  final _ChartGeometry geometry;
  final List<Color> lineColors;
  final int? selectedIndex;
  final double progress;
  final String Function(double value) formatValue;

  static const _maxXLabels = 5;
  static const _dotRadius = 4.0;
  static const _xLabelSpacing = 18.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (geometry.values.every((dataset) => dataset.isEmpty)) return;

    _drawGrid(canvas);

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
      geometry.rect.left,
      -4000,
      geometry.rect.width * progress,
      8000,
    ));
    for (var datasetIndex = 0;
        datasetIndex < geometry.values.length;
        datasetIndex++) {
      if (geometry.values[datasetIndex].isEmpty) continue;
      _drawArea(canvas, datasetIndex);
      _drawLineAndDots(canvas, datasetIndex);
    }
    canvas.restore();

    _drawXLabels(canvas);
  }

  void _drawGrid(Canvas canvas) {
    final rect = geometry.rect;
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    final textStyle = TextStyle(color: Colors.grey.shade600, fontSize: 11);

    for (final value in geometry.gridValues) {
      final y = geometry.yForValue(value);

      canvas.drawLine(Offset(rect.left, y), Offset(rect.right, y), gridPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: formatValue(value), style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(_ChartGeometry.yAxisWidth - textPainter.width - 6,
            y - textPainter.height / 2),
      );
    }
  }

  Path _linePath(int datasetIndex) {
    final path = Path();
    final values = geometry.values[datasetIndex];
    for (var i = 0; i < values.length; i++) {
      final point = geometry.pointAt(datasetIndex, i);
      i == 0
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
    }
    return path;
  }

  void _drawArea(Canvas canvas, int datasetIndex) {
    final rect = geometry.rect;
    final values = geometry.values[datasetIndex];
    final lineColor = lineColors[datasetIndex % lineColors.length];
    if (values.length == 1) {
      final point = geometry.pointAt(datasetIndex, 0);
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lineColor.withValues(alpha: 0.25),
            lineColor.withValues(alpha: 0.0),
          ],
        ).createShader(rect);

      canvas.drawRect(
        Rect.fromLTRB(rect.left, point.dy, rect.right, rect.bottom),
        paint,
      );
      return;
    }

    final path = _linePath(datasetIndex)
      ..lineTo(geometry.xForIndex(values.length - 1), rect.bottom)
      ..lineTo(geometry.xForIndex(0), rect.bottom)
      ..close();

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withValues(alpha: 0.25),
          lineColor.withValues(alpha: 0.0),
        ],
      ).createShader(rect);

    canvas.drawPath(path, paint);
  }

  void _drawLineAndDots(Canvas canvas, int datasetIndex) {
    final values = geometry.values[datasetIndex];
    final lineColor = lineColors[datasetIndex % lineColors.length];
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(_linePath(datasetIndex), linePaint);

    final dotPaint = Paint()..color = lineColor;
    final dotBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (var i = 0; i < values.length; i++) {
      final point = geometry.pointAt(datasetIndex, i);
      final radius = i == selectedIndex ? _dotRadius + 1.5 : _dotRadius;
      canvas.drawCircle(point, radius, dotPaint);
      canvas.drawCircle(point, radius, dotBorderPaint);
    }
  }

  void _drawXLabels(Canvas canvas) {
    final rect = geometry.rect;
    final textStyle = TextStyle(color: Colors.grey.shade600, fontSize: 11);

    for (final index in _labelIndexes()) {
      final textPainter = TextPainter(
        text: TextSpan(text: xLabels[index], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      final x = geometry.xForIndex(index);
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, rect.bottom + _xLabelSpacing),
      );
    }
  }

  List<int> _labelIndexes() {
    if (xLabels.isEmpty) {
      return [];
    }
    if (xLabels.length <= _maxXLabels) {
      return List.generate(xLabels.length, (index) => index);
    }
    final step = (xLabels.length - 1) / (_maxXLabels - 1);
    return List.generate(_maxXLabels, (index) => (index * step).round());
  }

  @override
  bool shouldRepaint(covariant _BonsuiChartPainter oldDelegate) {
    return oldDelegate.geometry.values != geometry.values ||
        oldDelegate.xLabels != xLabels ||
        oldDelegate.lineColors != lineColors ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.progress != progress;
  }
}
