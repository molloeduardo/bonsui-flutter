import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../bonsui.dart' show BonsuiUtils;
import '../design.dart';
import '../enums/chart.dart';

class BonsuiChart extends StatefulWidget {
  const BonsuiChart({
    super.key,
    required this.xValues,
    required this.yValues,
    this.type = BonsuiChartType.line,
    this.height = 220.0,
    this.colors,
    this.suffix = '',
    this.yUnitOnlyInTooltip = false,
    this.hideLegend = false,
    this.hideValues = false,
    this.centerChild,
  });

  final List<dynamic> xValues;
  final List<dynamic> yValues;
  final BonsuiChartType type;
  final double height;
  final List<Color>? colors;

  final String suffix;

  final bool yUnitOnlyInTooltip;
  final bool hideLegend;
  final bool hideValues;
  final Widget? centerChild;

  @override
  State<BonsuiChart> createState() => _BonsuiChartState();
}

class _BonsuiChartState extends State<BonsuiChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  int? _selectedIndex;
  int? _selectedDatasetIndex;
  final Set<int> _hiddenPieIndexes = {};

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
    if (!listEquals(oldWidget.xValues, widget.xValues) ||
        oldWidget.type != widget.type) {
      _hiddenPieIndexes.clear();
    }
    if (!listEquals(oldWidget.yValues, widget.yValues) ||
        !listEquals(oldWidget.xValues, widget.xValues) ||
        oldWidget.type != widget.type) {
      _selectedIndex = null;
      _selectedDatasetIndex = null;
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

  void _togglePieCategory(int index) {
    setState(() {
      if (!_hiddenPieIndexes.add(index)) {
        _hiddenPieIndexes.remove(index);
      }
      _selectedIndex = null;
      _selectedDatasetIndex = null;
      _animationController.forward(from: 0);
    });
  }

  List<Color> _colors(int count) {
    if (widget.colors != null && widget.colors!.isEmpty) {
      throw ArgumentError.value(
        widget.colors,
        'colors',
        'Must contain at least one color.',
      );
    }
    final colors = widget.colors ??
        [
          BonsuiDesign.primaryColor,
          BonsuiDesign.successColor,
        ];
    return List.generate(count, (index) => colors[index % colors.length]);
  }

  String _formatValue(double value, {bool includeSuffix = true}) {
    final text = value == value.roundToDouble()
        ? value.round().toString()
        : value.toStringAsFixed(1);
    return includeSuffix ? '$text${widget.suffix}' : text;
  }

  String _formatAxisValue(double value) => _formatValue(
        value,
        includeSuffix: !widget.yUnitOnlyInTooltip,
      );

  @override
  Widget build(BuildContext context) {
    final values = widget.yValues
        .map((dataset) => (dataset as List)
            .map((value) => (value as num).toDouble())
            .toList())
        .toList();
    final labels = widget.xValues.map((value) => value.toString()).toList();
    if (widget.type != BonsuiChartType.line) {
      for (final dataset in values) {
        if (dataset.any((value) => !value.isFinite || value < 0)) {
          throw ArgumentError.value(
            widget.yValues,
            'yValues',
            'Pie and donut chart values must be finite and non-negative.',
          );
        }
      }
    }
    final colors = _colors(widget.type != BonsuiChartType.line
        ? values.fold<int>(
            0, (count, dataset) => math.max(count, dataset.length))
        : values.length);

    if (widget.type == BonsuiChartType.line &&
        (values.isEmpty || values.every((dataset) => dataset.isEmpty))) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, widget.height);
        if (widget.type != BonsuiChartType.line) {
          return _buildPie(size, values, labels, colors);
        }
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
                        colors: colors,
                        selectedIndex: _selectedIndex,
                        progress: progress,
                        formatValue: _formatAxisValue,
                      ),
                    ),
                    if (_selectedIndex != null)
                      _buildTooltip(
                        geometry.pointAt(
                          values.indexWhere(
                            (dataset) => _selectedIndex! < dataset.length,
                          ),
                          _selectedIndex!,
                        ),
                        geometry.rect,
                        labels,
                        values,
                        colors,
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPie(
    Size size,
    List<List<double>> values,
    List<String> labels,
    List<Color> colors,
  ) {
    final geometry = _PieGeometry(
      values: [
        for (final dataset in values)
          [
            for (var index = 0; index < dataset.length; index++)
              _hiddenPieIndexes.contains(index) ? 0.0 : dataset[index],
          ],
      ],
      size: size,
      donut: widget.type == BonsuiChartType.donut,
    );
    final legendIndexes = [
      for (var index = 0;
          index < colors.length && index < labels.length;
          index++)
        if (labels[index].isNotEmpty) index,
    ];
    final chart = SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          final progress = Curves.easeOutCubic.transform(
            _animationController.value,
          );
          final selected = geometry.slices.where(
            (slice) =>
                slice.index == _selectedIndex &&
                slice.datasetIndex == _selectedDatasetIndex,
          );
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) {
              final slice = geometry.sliceAt(details.localPosition, progress);
              setState(() {
                final deselect = slice == null ||
                    (slice.index == _selectedIndex &&
                        slice.datasetIndex == _selectedDatasetIndex);
                _selectedIndex = deselect ? null : slice.index;
                _selectedDatasetIndex = deselect ? null : slice.datasetIndex;
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  size: size,
                  painter: _BonsuiPiePainter(
                    geometry: geometry,
                    colors: colors,
                    progress: progress,
                    selectedIndex: _selectedIndex,
                    selectedDatasetIndex: _selectedDatasetIndex,
                    showValues: !widget.hideValues,
                    formatValue: _formatAxisValue,
                    values: values,
                    textScaler: MediaQuery.textScalerOf(context),
                    textDirection: Directionality.of(context),
                  ),
                ),
                if (widget.type == BonsuiChartType.donut &&
                    widget.centerChild != null)
                  Positioned.fromRect(
                    rect: Rect.fromCircle(
                      center: geometry.center,
                      radius: math.max(0, geometry.holeRadius - 2),
                    ),
                    child: ClipOval(
                      child: Center(child: widget.centerChild),
                    ),
                  ),
                if (selected.isNotEmpty)
                  _buildTooltip(
                    geometry.pointFor(selected.first),
                    Offset.zero & size,
                    labels,
                    values,
                    colors,
                    datasetIndex: selected.first.datasetIndex,
                  ),
              ],
            ),
          );
        },
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        chart,
        if (!widget.hideLegend && legendIndexes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final index in legendIndexes)
                    Semantics(
                      toggled: !_hiddenPieIndexes.contains(index),
                      child: TextButton(
                        onPressed: () => _togglePieCategory(index),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(48, 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: Colors.grey.shade600,
                          splashFactory: BonsuiUtils.getSplashFactory(),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              labels[index],
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                decoration: _hiddenPieIndexes.contains(index)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTooltip(
    Offset point,
    Rect bounds,
    List<String> labels,
    List<List<double>> values,
    List<Color> colors, {
    int? datasetIndex,
  }) {
    final index = _selectedIndex!;
    const tooltipWidth = 90.0;
    final maxLeft = bounds.right - tooltipWidth;
    final left = (point.dx - tooltipWidth / 2)
        .clamp(bounds.left, maxLeft < bounds.left ? bounds.left : maxLeft);

    return Positioned(
      left: left,
      top: (point.dy - 52).clamp(0.0, double.infinity),
      child: IgnorePointer(
        child: TweenAnimationBuilder<double>(
          key: ValueKey((datasetIndex, index)),
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
                for (var series = 0; series < values.length; series++)
                  if ((datasetIndex == null || datasetIndex == series) &&
                      index < values[series].length)
                    Text(
                      _formatValue(values[series][index]),
                      style: TextStyle(
                        color: colors[datasetIndex == null ? series : index],
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

class _PieSlice {
  const _PieSlice({
    required this.datasetIndex,
    required this.index,
    required this.startAngle,
    required this.sweepAngle,
    required this.innerRadius,
    required this.outerRadius,
  });

  final int datasetIndex;
  final int index;
  final double startAngle;
  final double sweepAngle;
  final double innerRadius;
  final double outerRadius;
}

class _PieGeometry {
  _PieGeometry({
    required List<List<double>> values,
    required Size size,
    bool donut = false,
  }) : center = Offset(size.width / 2, size.height / 2) {
    final radius = math.max(
      0.0,
      math.min(size.width, size.height) / 2 - 8,
    );
    holeRadius = donut ? radius * 0.5 : 0;
    if (values.isEmpty) return;
    final bandWidth = (radius - holeRadius) / values.length;
    for (var series = 0; series < values.length; series++) {
      final dataset = values[series];
      final maxValue = dataset.fold<double>(0, math.max);
      if (maxValue == 0) continue;
      final total = dataset.fold<double>(
        0,
        (sum, value) => sum + value / maxValue,
      );
      final outerRadius = radius - series * bandWidth;
      final innerRadius = series == values.length - 1
          ? holeRadius
          : outerRadius - bandWidth + math.min(3.0, bandWidth / 4);
      var startAngle = 0.0;
      for (var index = 0; index < dataset.length; index++) {
        final sweepAngle = (dataset[index] / maxValue) / total * math.pi * 2;
        if (sweepAngle > 0) {
          slices.add(_PieSlice(
            datasetIndex: series,
            index: index,
            startAngle: startAngle,
            sweepAngle: sweepAngle,
            innerRadius: innerRadius,
            outerRadius: outerRadius,
          ));
        }
        startAngle += sweepAngle;
      }
    }
  }

  final Offset center;
  late final double holeRadius;
  final List<_PieSlice> slices = [];

  Offset pointFor(_PieSlice slice) {
    final angle = slice.startAngle + slice.sweepAngle / 2 - math.pi / 2;
    final radius = (slice.innerRadius + slice.outerRadius) / 2;
    return center + Offset(math.cos(angle), math.sin(angle)) * radius;
  }

  _PieSlice? sliceAt(Offset position, double progress) {
    final delta = position - center;
    final distance = delta.distance;
    final angle =
        (math.atan2(delta.dy, delta.dx) + math.pi / 2) % (math.pi * 2);
    for (final slice in slices) {
      if (distance >= slice.innerRadius &&
          distance <= slice.outerRadius &&
          angle >= slice.startAngle &&
          angle < slice.startAngle + slice.sweepAngle * progress) {
        return slice;
      }
    }
    return null;
  }
}

class _BonsuiPiePainter extends CustomPainter {
  _BonsuiPiePainter({
    required this.geometry,
    required this.colors,
    required this.progress,
    required this.selectedIndex,
    required this.selectedDatasetIndex,
    required this.showValues,
    required this.formatValue,
    required this.values,
    required this.textScaler,
    required this.textDirection,
  });

  final _PieGeometry geometry;
  final List<Color> colors;
  final double progress;
  final int? selectedIndex;
  final int? selectedDatasetIndex;
  final bool showValues;
  final String Function(double value) formatValue;
  final List<List<double>> values;
  final TextScaler textScaler;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    for (final slice in geometry.slices) {
      final sweep = slice.sweepAngle * progress;
      if (sweep <= 0 || slice.outerRadius <= 0) continue;
      final start = slice.startAngle - math.pi / 2;
      final outer = Rect.fromCircle(
        center: geometry.center,
        radius: slice.outerRadius,
      );
      final path = Path()..addArc(outer, start, sweep);
      if (slice.innerRadius > 0) {
        path.arcTo(
          Rect.fromCircle(center: geometry.center, radius: slice.innerRadius),
          start + sweep,
          -sweep,
          false,
        );
      } else {
        path.lineTo(geometry.center.dx, geometry.center.dy);
      }
      path.close();
      final selected = slice.index == selectedIndex &&
          slice.datasetIndex == selectedDatasetIndex;
      final color = colors[slice.index];
      canvas.drawPath(
        path,
        Paint()
          ..color = selectedIndex == null || selected
              ? color
              : color.withValues(alpha: color.a * 0.5),
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = selected ? 3 : 1,
      );
      if (showValues && progress == 1) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: formatValue(values[slice.datasetIndex][slice.index]),
            style: TextStyle(
              color: BonsuiDesign.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: textDirection,
          textScaler: textScaler,
        )..layout();
        final point = geometry.pointFor(slice);
        final rect = Rect.fromCenter(
          center: point,
          width: textPainter.width + 4,
          height: textPainter.height + 4,
        );
        if ([rect.topLeft, rect.topRight, rect.bottomLeft, rect.bottomRight]
            .every(path.contains)) {
          canvas.save();
          canvas.clipPath(path);
          textPainter.paint(
            canvas,
            point - Offset(textPainter.width / 2, textPainter.height / 2),
          );
          canvas.restore();
        }
        textPainter.dispose();
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BonsuiPiePainter oldDelegate) {
    return oldDelegate.geometry != geometry ||
        !listEquals(oldDelegate.colors, colors) ||
        oldDelegate.progress != progress ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.selectedDatasetIndex != selectedDatasetIndex ||
        oldDelegate.showValues != showValues ||
        oldDelegate.formatValue != formatValue ||
        oldDelegate.values != values ||
        oldDelegate.textScaler != textScaler ||
        oldDelegate.textDirection != textDirection;
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
    required this.colors,
    required this.progress,
    required this.formatValue,
    this.selectedIndex,
  });

  final List<String> xLabels;
  final _ChartGeometry geometry;
  final List<Color> colors;
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
    final lineColor = colors[datasetIndex % colors.length];
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
    final lineColor = colors[datasetIndex % colors.length];
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
        oldDelegate.colors != colors ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.progress != progress;
  }
}
