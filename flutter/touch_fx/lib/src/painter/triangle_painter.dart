import 'package:flutter/rendering.dart';
import 'package:touch_fx/touch_fx.dart';

class CoolTrianglePainter extends CustomPainter {
  final List<GlowingTriangle> triangles;

  CoolTrianglePainter({required this.triangles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final triangle in triangles) {
      //save the current drawing state
      canvas.save();
      // move to the object's pos
      canvas.translate(triangle.position.dx, triangle.position.dy);
      // perform the rotation from that new center point
      canvas.rotate(triangle.rotation);
      // move the object back to the original pos
      canvas.translate(-triangle.position.dx, -triangle.position.dy);
      triangle.paint(canvas);
      // restore the state for the next drawing object
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CoolTrianglePainter oldDelegate) {
    return triangles.length != oldDelegate.triangles.length ||
        triangles.any((t) => t.opacity > 0);
  }
}
