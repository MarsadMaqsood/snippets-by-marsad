import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:touch_fx/src/particle/particle.dart';

class TriangleParticle extends Particle {
  /// The rotation angle of the particle in radians.
  ///
  /// This can be used to apply rotation effects when displaying.
  double rotation;

  /// The color used to display the particle.
  Color color;

  TriangleParticle({
    required super.position,
    required super.size,
    required super.opacity,
    required this.rotation,
    required super.velocityX,
    required super.velocityY,
    required this.color,
  });

  @override
  void update() {
    const lifetimeMilliseconds = 1000;
    final timeSinceCreation = DateTime.now().difference(creationTime);

    //calculate the progress value based on how the triangle is alive
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

    final path = Path();
    path.moveTo(position.dx, position.dy - size);
    path.lineTo(position.dx + size, position.dy + size);
    path.lineTo(position.dx - size, position.dy + size);
    path.close();

    //wider, blurry outer glow
    final Paint outerGlowPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.5)
      /// border stroke
      ..style = PaintingStyle.stroke
      // A wider stroke for a bigger glow
      ..strokeWidth = size / 3
      // The blur for the glow
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10);

    // bright, sharp inner glow
    final Paint innerGlowPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.stroke
      // A thinner, sharper stroke for the core
      ..strokeWidth = size / 8;

    canvas.drawPath(path, outerGlowPaint);
    canvas.drawPath(path, innerGlowPaint);
  }
}
