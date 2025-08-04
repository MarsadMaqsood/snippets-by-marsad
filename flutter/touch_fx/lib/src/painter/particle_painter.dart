import 'package:flutter/rendering.dart';
import 'package:touch_fx/src/particle/circle_particle.dart';
import 'package:touch_fx/src/particle/particle.dart';
import 'package:touch_fx/src/particle/triangle_particle.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      if (particle is TriangleParticle) {
        _drawTriangle(canvas, particle);
      } else if (particle is CircleParticle) {
        _drawCircle(canvas, particle);
      }
    }
  }

  void _drawCircle(Canvas canvas, CircleParticle particle) {
    particle.paint(canvas);
  }

  void _drawTriangle(Canvas canvas, TriangleParticle particle) {
    //save the current drawing state
    canvas.save();
    // move to the object's pos
    canvas.translate(particle.position.dx, particle.position.dy);
    // perform the rotation from that new center point
    canvas.rotate(particle.rotation);
    // move the object back to the original pos
    canvas.translate(-particle.position.dx, -particle.position.dy);
    particle.paint(canvas);
    // restore the state for the next drawing object
    canvas.restore();
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return particles.length != oldDelegate.particles.length ||
        particles.any((t) => t.opacity > 0);
  }
}
