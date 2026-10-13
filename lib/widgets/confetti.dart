import 'dart:math' as math;

import 'package:flutter/material.dart';

class BonsuiConfettiEffect extends StatefulWidget {
  const BonsuiConfettiEffect({
    super.key,
    required this.count,
    this.explosion = true,
    required this.position,
    required this.duration,
    required this.onCompleted,
  });

  final int count;
  final bool explosion;
  final Alignment position;
  final Duration duration;
  final VoidCallback onCompleted;

  @override
  State<BonsuiConfettiEffect> createState() => _BonsuiConfettiEffectState();
}

class _BonsuiConfettiEffectState extends State<BonsuiConfettiEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    final position = widget.position;
    final centered = position == Alignment.center;
    final direction = math.atan2(-position.y, -position.x);
    final emissionOrder = List.generate(widget.count, (index) => index)
      ..shuffle(random);
    _particles = List.generate(widget.count, (index) {
      final angle = centered
          ? random.nextDouble() * math.pi * 2
          : direction + (random.nextDouble() - 0.5) * math.pi;
      final speed = 150 + random.nextDouble() * 250;
      return _ConfettiParticle(
        delay: widget.explosion
            ? 0
            : emissionOrder[index] / widget.count * 0.6,
        spawnOffset: widget.explosion
            ? Offset.zero
            : Offset(
                (index + random.nextDouble()) / widget.count,
                random.nextDouble() * 60,
              ),
        velocity: widget.explosion
            ? Offset(math.cos(angle), math.sin(angle)) * speed
            : Offset(0, 80 + random.nextDouble() * 120),
        rotation: random.nextDouble() * math.pi * 2,
        spin: (random.nextDouble() - 0.5) * 12,
        size: 3 + ((index % 3 + random.nextDouble()) / 3) * 13,
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
      );
    });
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) widget.onCompleted();
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _ConfettiPainter(
            animation: _controller,
            particles: _particles,
            position: widget.position,
            duration: widget.duration,
            explosion: widget.explosion,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ConfettiParticle {
  const _ConfettiParticle({
    required this.spawnOffset,
    required this.delay,
    required this.velocity,
    required this.rotation,
    required this.spin,
    required this.size,
    required this.color,
  });

  final Offset velocity;
  final Offset spawnOffset;
  final double delay;
  final double rotation;
  final double spin;
  final double size;
  final Color color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({
    required this.animation,
    required this.particles,
    required this.position,
    required this.duration,
    required this.explosion,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final List<_ConfettiParticle> particles;
  final Alignment position;
  final Duration duration;
  final bool explosion;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = position.alongSize(size);
    final seconds = duration.inMicroseconds / Duration.microsecondsPerSecond;
    final opacity = ((1 - animation.value) * 4).clamp(0.0, 1.0);
    final paint = Paint();
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    for (final particle in particles) {
      final progress = animation.value - particle.delay;
      if (progress < 0) continue;
      final elapsed = progress * seconds;
      final spawn = explosion
          ? origin
          : Offset(
              particle.spawnOffset.dx * size.width,
              origin.dy + particle.spawnOffset.dy,
            );
      final offset = spawn +
          particle.velocity * elapsed +
          Offset(0, (explosion ? 225 : 70) * elapsed * elapsed);
      paint.color = particle.color.withValues(alpha: opacity);
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(particle.rotation + particle.spin * elapsed);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: particle.size,
          height: particle.size * 0.6,
        ),
        paint,
      );
      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return animation != oldDelegate.animation ||
        particles != oldDelegate.particles ||
        position != oldDelegate.position ||
        explosion != oldDelegate.explosion ||
        duration != oldDelegate.duration;
  }
}
