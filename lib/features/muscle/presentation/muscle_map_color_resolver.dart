import 'package:flutter/material.dart';

import '../../../core/enums.dart';
import '../domain/muscle_svg_mapping.dart';
import 'muscle_map_color_scale.dart';

/// Converts per-[MuscleGroup] scores into per-SVG-path colours for one side
/// (front or back) of the body map.
class MuscleMapColorResolver {
  const MuscleMapColorResolver([this.scale = const MuscleMapColorScale()]);

  final MuscleMapColorScale scale;

  Map<String, Color> resolvePathColors({
    required Map<MuscleGroup, double> scores,
    required MuscleMapMode mode,
    required bool front,
  }) {
    final mapping = MuscleSvgMapping.forSide(isFront: front);
    final result = <String, Color>{};
    scores.forEach((muscle, score) {
      final ids = mapping[muscle];
      if (ids == null) return; // muscle not shown on this side
      final color = scale.colorFor(mode, score);
      for (final id in ids) {
        result[id] = color;
      }
    });
    return result;
  }
}
