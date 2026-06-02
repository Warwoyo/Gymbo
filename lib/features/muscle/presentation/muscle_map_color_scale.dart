import 'package:flutter/material.dart';

/// What the 0–100 score in a [MuscleMapMode] means.
enum MuscleMapMode { workoutImpact, recovery }

/// Maps muscle scores to colours for the body map. These are intentionally
/// simple, legible buckets — they are heuristics for visual feedback, not
/// precise measurements.
class MuscleMapColorScale {
  const MuscleMapColorScale();

  /// Neutral colour for untrained / unknown muscles.
  static const Color neutral = Color(0xFF303030);
  static const Color stroke = Color(0xFF555555);

  // Workout-impact palette (cool -> hot).
  static const Color lightImpact = Color(0xFFFFD54F); // yellow
  static const Color moderateImpact = Color(0xFFFFB300); // amber
  static const Color highImpact = Color(0xFFFF9800); // orange
  static const Color veryHighImpact = Color(0xFFFF5722); // deep orange
  static const Color maxImpact = Color(0xFFE53935); // red

  // Recovery palette (recovered -> fatigued).
  static const Color recovered = Color(0xFF2ECC71); // green
  static const Color lightFatigue = Color(0xFFCDDC39); // yellow-green
  static const Color moderateFatigue = Color(0xFFFF9800); // orange
  static const Color fatigued = Color(0xFFE53935); // red

  /// Higher score = trained harder = hotter colour.
  Color workoutImpactColor(double score) {
    if (score <= 0) return neutral;
    if (score < 20) return lightImpact;
    if (score < 40) return moderateImpact;
    if (score < 60) return highImpact;
    if (score < 80) return veryHighImpact;
    return maxImpact;
  }

  /// Higher recovery percent = greener.
  Color recoveryColor(double recoveryPercent) {
    if (recoveryPercent >= 80) return recovered;
    if (recoveryPercent >= 60) return lightFatigue;
    if (recoveryPercent >= 35) return moderateFatigue;
    return fatigued;
  }

  Color colorFor(MuscleMapMode mode, double score) =>
      mode == MuscleMapMode.workoutImpact
          ? workoutImpactColor(score)
          : recoveryColor(score);

  /// Legend entries (label, colour) for the given mode.
  List<(String, Color)> legend(MuscleMapMode mode) {
    if (mode == MuscleMapMode.workoutImpact) {
      return const [
        ('Not trained', neutral),
        ('Light', lightImpact),
        ('Moderate', highImpact),
        ('High', maxImpact),
      ];
    }
    return const [
      ('Recovered', recovered),
      ('Light fatigue', lightFatigue),
      ('Moderate', moderateFatigue),
      ('Fatigued', fatigued),
    ];
  }
}

/// `#RRGGBB` hex for an SVG `fill`/`stroke` attribute.
String colorToHex(Color color) {
  final rgb = (color.toARGB32()) & 0x00FFFFFF;
  return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
