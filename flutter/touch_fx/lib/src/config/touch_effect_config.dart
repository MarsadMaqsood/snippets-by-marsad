import 'package:touch_fx/src/helpers/shape_enum.dart';

/// The configuration settings for the touch effect behavior.
///
/// This includes properties like shape, particle size, opacity,
/// and maximum number of particles.
class TouchEffectConfig {
  /// The shape used for each touch particle.
  ///
  /// This defines the geometric form of the particles that appear
  /// in response to user interaction, such as [TouchShape.circle]
  /// or [TouchShape.triangle]
  final TouchShape shape;

  /// The base size of each particle, in logical pixels.
  ///
  /// If null, the size will default to a random value between `0` and `20`.
  final double? size;

  /// The overall opacity of the particles, between `0.0` (fully transparent)
  /// and `1.0` (fully opaque).
  ///
  /// Defaults to `1.0`.
  final double opacity;

  /// The maximum number of particles allowed on screen at any given moment.
  ///
  /// Defaults to `30`.
  final int maxParticles;

  /// The configuration settings for the touch effect behavior.
  ///
  /// This includes properties like shape, particle size, opacity,
  /// and maximum number of particles.
  TouchEffectConfig({
    required this.shape,
    this.size,
    this.maxParticles = 30,
    this.opacity = 1.0,
  });
}
