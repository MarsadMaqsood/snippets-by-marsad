import 'dart:ui';

/// An abstract representation of a visual particle with motion, size, and opacity.
///
/// This class defines the core properties and behavior that any specific type
/// of particle (e.g., `CircleParticle`, `TriangleParticle`) should have.
/// It includes logic for position, velocity, and visual attributes like size and opacity.
abstract class Particle {
  /// The current position of the particle on the canvas.
  Offset position;

  /// The visual size of the particle.
  double size;

  /// The transparency level of the particle
  double opacity;

  /// The horizontal speed of the particle.
  double velocityX;

  /// The vertical speed of the particle.
  double velocityY;

  /// The time when the particle was created.
  ///
  /// Useful for age-based fading or removal.
  final DateTime creationTime;

  /// Creates a [Particle] with the given properties.
  ///
  /// The [position], [size], [opacity], [velocityX], and [velocityY] are required.
  Particle({
    required this.position,
    required this.size,
    required this.opacity,
    required this.velocityX,
    required this.velocityY,
  }) : creationTime = DateTime.now();

  /// Updates the particle's state (position, opacity, etc).
  ///
  /// This method should be implemented by subclasses to define
  /// how the particle behaves over time.
  void update();

  /// Paints the particle on the given [canvas].
  ///
  /// Subclasses should implement this method to render
  /// the particle using its current state.
  void paint(Canvas canvas);
}
