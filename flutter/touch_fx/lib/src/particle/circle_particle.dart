import 'package:flutter/material.dart';

import 'particle.dart';

class CircleParticle extends Particle {
  final Color color;

  CircleParticle({
    required super.position,
    required super.size,
    required super.opacity,
    required super.velocityX,
    required super.velocityY,
    required this.color,
  });

  @override
  void update() {
    const lifetimeMilliseconds = 1000;
    final timeSinceCreation = DateTime.now().difference(creationTime);

    if (timeSinceCreation.inMilliseconds < lifetimeMilliseconds) {
      final progress = timeSinceCreation.inMilliseconds / lifetimeMilliseconds;
      opacity = 1.0 - progress;
    } else {
      opacity = 0.0;
    }

    if (opacity > 0) {
      position = Offset(position.dx + velocityX, position.dy + velocityY);
    }
  }

  @override
  void paint(Canvas canvas) {
    if (opacity <= 0) return;

    final double radius = size;

    final Path circlePath = Path()
      ..addOval(Rect.fromCircle(center: position, radius: radius));

    // Outer glow layer
    final Paint outerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 1.5;

    // Inner sharp stroke
    final Paint innerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 4;

    canvas.drawPath(circlePath, outerPaint);
    canvas.drawPath(circlePath, innerPaint);
  }
}
