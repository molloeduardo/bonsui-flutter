import 'dart:ui' show ClipOp;

import 'package:bonsui/bonsui.dart';
import 'package:bonsui/widgets/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports a missing scaffold', () {
    expect(
      () => BonsuiConfetti.show(
        scaffoldKey: GlobalKey<BonsuiScaffoldState>(),
      ),
      throwsStateError,
    );
  });

  testWidgets('uses the default key and removes the completed effect',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: BonsuiConfetti.key)),
    );
    BonsuiConfetti.show();
    await tester.pump();

    final effect = tester.widget<BonsuiConfettiEffect>(
      find.byType(BonsuiConfettiEffect),
    );
    expect(effect.count, 100);
    expect(effect.explosion, isTrue);
    expect(effect.position, Alignment.topCenter);
    expect(tester.getSize(find.byType(BonsuiConfettiEffect)),
        tester.getSize(find.byType(Scaffold)));
    await tester.pumpAndSettle();
    expect(find.byType(BonsuiConfettiEffect), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('supports custom origins, counts and overlapping bursts',
      (tester) async {
    final key = GlobalKey<BonsuiScaffoldState>();
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: BonsuiScaffold(
          key: key,
          body: Center(
            child: TextButton(
              onPressed: () => taps++,
              child: const Text('Tap'),
            ),
          ),
        ),
      ),
    );
    BonsuiConfetti.show(
      scaffoldKey: key,
      count: 37,
      position: Alignment.center,
      duration: const Duration(seconds: 1),
    );
    key.currentState!.showConfetti(
      count: 12,
      position: Alignment.bottomRight,
      duration: const Duration(seconds: 2),
    );
    await tester.pump();
    final effects = tester
        .widgetList<BonsuiConfettiEffect>(find.byType(BonsuiConfettiEffect))
        .toList();
    expect(effects.map((effect) => effect.count), [37, 12]);
    expect(effects.map((effect) => effect.position),
        [Alignment.center, Alignment.bottomRight]);
    final paints = tester
        .widgetList<CustomPaint>(
          find.descendant(
            of: find.byType(BonsuiConfettiEffect),
            matching: find.byType(CustomPaint),
          ),
        )
        .toList();
    for (var i = 0; i < paints.length; i++) {
      final canvas = _ParticleCanvas();
      const size = Size(800, 600);
      paints[i].painter!.paint(canvas, size);
      expect(canvas.particleCount, effects[i].count);
      expect(canvas.origins, everyElement(effects[i].position.alongSize(size)));
    }
    await tester.tap(find.text('Tap'));
    expect(taps, 1);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pump();
    expect(find.byType(BonsuiConfettiEffect), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(BonsuiConfettiEffect), findsNothing);
  });

  testWidgets('falling mode spreads particles and moves them downward',
      (tester) async {
    final key = GlobalKey<BonsuiScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: key)),
    );
    BonsuiConfetti.show(
      scaffoldKey: key,
      count: 40,
      position: Alignment.topLeft,
      explosion: false,
    );
    key.currentState!.showConfetti(
      count: 25,
      position: Alignment.center,
      explosion: false,
    );
    await tester.pump();
    final effects = tester
        .widgetList<BonsuiConfettiEffect>(find.byType(BonsuiConfettiEffect))
        .toList();
    expect(effects.map((effect) => effect.explosion), everyElement(isFalse));
    List<_ParticleCanvas> paintParticles() {
      final paints = tester.widgetList<CustomPaint>(
        find.descendant(
          of: find.byType(BonsuiConfettiEffect),
          matching: find.byType(CustomPaint),
        ),
      );
      return paints.map((paint) {
        final canvas = _ParticleCanvas();
        paint.painter!.paint(canvas, const Size(800, 600));
        return canvas;
      }).toList();
    }

    await tester.pump();
    final initial = paintParticles();
    for (final canvas in initial) {
      expect(canvas.particleCount, 1);
    }
    await tester.pump(const Duration(milliseconds: 600));
    final early = paintParticles();
    for (var i = 0; i < effects.length; i++) {
      expect(early[i].particleCount, greaterThan(1));
      expect(early[i].particleCount, lessThan(effects[i].count ~/ 2));
    }
    await tester.pump(const Duration(milliseconds: 1300));
    final first = paintParticles();
    await tester.pump(const Duration(milliseconds: 100));
    final second = paintParticles();
    for (var i = 0; i < effects.length; i++) {
      final origin = effects[i].position.alongSize(const Size(800, 600));
      final xs = first[i].origins.map((offset) => offset.dx).toList()..sort();
      final ys = first[i].origins.map((offset) => offset.dy).toList()..sort();
      expect(xs.last - xs.first, greaterThan(730));
      expect(xs.first, lessThan(800 / effects[i].count));
      expect(xs.last, greaterThan(800 - 800 / effects[i].count));
      expect(ys.last - ys.first, greaterThan(100));
      expect(xs.first, greaterThanOrEqualTo(0));
      expect(xs.last, lessThanOrEqualTo(800));
      expect(ys.first, greaterThanOrEqualTo(origin.dy));
      expect(first[i].particleCount, effects[i].count);
      expect(second[i].particleCount, effects[i].count);
      for (var j = 0; j < effects[i].count; j++) {
        expect(second[i].origins[j].dx, first[i].origins[j].dx);
        expect(first[i].origins[j].dy, greaterThan(origin.dy));
        expect(second[i].origins[j].dy, greaterThan(first[i].origins[j].dy));
      }
    }
    await tester.pumpAndSettle();
    expect(find.byType(BonsuiConfettiEffect), findsNothing);
  });

  testWidgets('both modes mix small, medium and large particles',
      (tester) async {
    final key = GlobalKey<BonsuiScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: key)),
    );
    for (final explosion in [true, false]) {
      BonsuiConfetti.show(
        scaffoldKey: key,
        count: 30,
        explosion: explosion,
      );
    }
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1900));
    final paints = tester.widgetList<CustomPaint>(
      find.descendant(
        of: find.byType(BonsuiConfettiEffect),
        matching: find.byType(CustomPaint),
      ),
    );
    expect(paints.length, 2);
    for (final paint in paints) {
      final canvas = _ParticleCanvas();
      paint.painter!.paint(canvas, const Size(800, 600));
      final widths = canvas.rectangles.map((rect) => rect.width).toList()
        ..sort();
      expect(widths.length, 30);
      expect(widths.first, greaterThanOrEqualTo(3));
      expect(widths.first, lessThan(3 + 13 / 3));
      expect(widths.last, greaterThanOrEqualTo(3 + 26 / 3));
      expect(widths.last, lessThanOrEqualTo(16));
      expect(widths.last - widths.first, greaterThan(13 / 3));
    }
    await tester.pumpAndSettle();
  });

  testWidgets('haptics are opt-in and fire once per valid burst',
      (tester) async {
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        calls.add(call);
        return null;
      },
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });
    final key = GlobalKey<BonsuiScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: key)),
    );
    calls.clear();
    BonsuiConfetti.show(scaffoldKey: key);
    await tester.pump();
    expect(calls.where((call) => call.method == 'HapticFeedback.vibrate'),
        isEmpty);

    BonsuiConfetti.show(scaffoldKey: key, useHapticFeedback: true);
    key.currentState!.showConfetti(
      explosion: false,
      useHapticFeedback: true,
    );
    await tester.pump();
    expect(
      calls
          .where((call) => call.method == 'HapticFeedback.vibrate')
          .map((call) => call.arguments),
      ['HapticFeedbackType.lightImpact', 'HapticFeedbackType.lightImpact'],
    );
    calls.clear();
    expect(
      () => BonsuiConfetti.show(
        scaffoldKey: key,
        count: 0,
        useHapticFeedback: true,
      ),
      throwsArgumentError,
    );
    await tester.pumpAndSettle();
    expect(calls.where((call) => call.method == 'HapticFeedback.vibrate'),
        isEmpty);
  });

  testWidgets('rejects invalid input', (tester) async {
    final key = GlobalKey<BonsuiScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: key)),
    );
    for (final count in [0, -1]) {
      expect(() => BonsuiConfetti.show(scaffoldKey: key, count: count),
          throwsArgumentError);
    }

    for (final duration in [Duration.zero, const Duration(seconds: -1)]) {
      expect(() => BonsuiConfetti.show(scaffoldKey: key, duration: duration),
          throwsArgumentError);
    }
    for (final position in [
      const Alignment(2, 0),
      const Alignment(0, double.nan),
      const Alignment(double.infinity, 0),
    ]) {
      expect(() => BonsuiConfetti.show(scaffoldKey: key, position: position),
          throwsArgumentError);
    }
    await tester.pump();
    expect(find.byType(BonsuiConfettiEffect), findsNothing);
  });

  testWidgets('disposes running effects when the scaffold is removed',
      (tester) async {
    final key = GlobalKey<BonsuiScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(home: BonsuiScaffold(key: key)),
    );
    BonsuiConfetti.show(scaffoldKey: key);
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 4));
    expect(tester.takeException(), isNull);
    expect(() => BonsuiConfetti.show(scaffoldKey: key), throwsStateError);
  });
}

class _ParticleCanvas extends Fake implements Canvas {
  int particleCount = 0;
  final List<Offset> origins = [];
  final List<Rect> rectangles = [];

  @override
  void save() {}

  @override
  void restore() {}

  @override
  void clipRect(
    Rect rect, {
    ClipOp clipOp = ClipOp.intersect,
    bool doAntiAlias = true,
  }) {}

  @override
  void translate(double dx, double dy) => origins.add(Offset(dx, dy));

  @override
  void rotate(double radians) {}

  @override
  void drawRect(Rect rect, Paint paint) {
    particleCount++;
    rectangles.add(rect);
  }
}
