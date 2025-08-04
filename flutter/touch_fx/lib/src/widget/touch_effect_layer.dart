import 'dart:math';

import 'package:flutter/material.dart';
import 'package:touch_fx/src/painter/particle_painter.dart';
import 'package:touch_fx/src/particle/circle_particle.dart';
import 'package:touch_fx/src/particle/particle.dart';
import 'package:touch_fx/src/particle/triangle_particle.dart';
import 'package:touch_fx/touch_fx.dart';

/// A widget that show interactive particle effects based on touch input.
///
/// [TouchEffectLayer] displays animated particles whenever the user interacts
/// with the screen. It is commonly used for visual feedback in gesture-based UI
/// elements, games, or creative visualizations.
///
/// The behavior and appearance of the particles can be customized using
/// [TouchEffectConfig], including shape, size, opacity, and number of particles.
class TouchEffectLayer extends StatefulWidget {
  /// The configuration settings for the touch effect behavior.
  ///
  /// This includes properties like shape, particle size, opacity,
  /// and maximum number of particles.
  final TouchEffectConfig config;

  /// A widget that show interactive particle effects based on touch input.
  ///
  /// [TouchEffectLayer] displays animated particles whenever the user interacts
  /// with the screen. It is commonly used for visual feedback in gesture-based UI
  /// elements, games, or creative visualizations.
  ///
  /// The behavior and appearance of the particles can be customized using
  /// [TouchEffectConfig], including shape, size, opacity, and number of particles.
  const TouchEffectLayer({super.key, required this.config});

  @override
  State<TouchEffectLayer> createState() => _TouchEffectLayerState();
}

class _TouchEffectLayerState extends State<TouchEffectLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

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
        _particles.removeWhere((t) => t.opacity <= 0);
        for (final triangle in _particles) {
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

  void _handleTouch(Offset position) {
    /// The horizontal velocity of the particle, randomly between -2 and 2.
    final velocityX = _random.nextDouble() * 4 - 2;

    /// The vertical velocity of the particle, randomly between -2 and 2.
    final velocityY = _random.nextDouble() * 4 - 2;

    /// The color of the particle, randomly selected from Flutter's primary colors.
    final color = Colors.primaries[_random.nextInt(Colors.primaries.length)];

    /// The size of the particle, using the configured size or a random value between 0 and 20.
    final size = widget.config.size ?? Random().nextDouble() * 20;
    late Particle particle;

    if (widget.config.shape == TouchShape.triangle) {
      particle = TriangleParticle(
        velocityX: velocityX,
        velocityY: velocityY,
        position: position,
        size: size,
        color: color,
        rotation: _random.nextDouble() * 2 * pi,
        opacity: widget.config.opacity,
      );
    } else if (widget.config.shape == TouchShape.circle) {
      particle = CircleParticle(
        velocityX: velocityX,
        velocityY: velocityY,
        position: position,
        size: size,
        color: color,
        opacity: widget.config.opacity,
      );
    }

    setState(() {
      _particles.add(particle);
      if (_particles.length > widget.config.maxParticles) {
        _particles.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) => _handleTouch(details.localPosition),
      onPanUpdate: (details) => _handleTouch(details.localPosition),
      child: CustomPaint(
        painter: ParticlePainter(particles: _particles),
        child: Container(),
      ),
    );
  }
}
