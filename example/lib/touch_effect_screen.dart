import 'dart:math';

import 'package:flutter/material.dart';
import 'package:touch_fx/touch_fx.dart';

class TouchEffectScreen extends StatefulWidget {
  const TouchEffectScreen({super.key});

  @override
  State<TouchEffectScreen> createState() => _TouchEffectScreenState();
}

class _TouchEffectScreenState extends State<TouchEffectScreen>
    with SingleTickerProviderStateMixin {
  List<GlowingTriangle> triangles = [];
  late AnimationController _controller;
  static const int maxTriangles = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        // Update the position and opacity of the remaining triangles
        // and remove those that have faded out.
        triangles.removeWhere((t) => t.opacity <= 0);
        for (final triangle in triangles) {
          triangle.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTriangles(Offset position) {
    final random = Random();
    const int numberOfTrianglesPerTouch = 1;

    for (int i = 0; i < numberOfTrianglesPerTouch; i++) {
      // if we hit our max limit, remove the oldest triangle (from the beginning of the list)
      if (triangles.length >= maxTriangles) {
        triangles.removeAt(0);
      }

      final color = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1.0,
      );

      triangles.add(
        GlowingTriangle(
          position: position,
          size: random.nextDouble() * 20,
          opacity: 1.0,
          rotation: random.nextDouble() * 2 * pi,
          velocityX: random.nextDouble() * 4 - 2,
          velocityY: random.nextDouble() * 4 - 2,
          color: color,
        ),
      );
    }
    //
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          _addTriangles(details.localPosition);
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: CoolTrianglePainter(triangles: triangles),
        ),
      ),
    );
  }
}
