import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/features/muscle/presentation/muscle_map_color_resolver.dart';
import 'package:gymbo/features/muscle/presentation/muscle_map_color_scale.dart';
import 'package:gymbo/features/muscle/presentation/svg_muscle_colorizer.dart';

void main() {
  const scale = MuscleMapColorScale();
  const resolver = MuscleMapColorResolver();
  const colorizer = SvgMuscleColorizer();

  group('workout impact colour scale', () {
    test('0 -> neutral', () {
      expect(scale.workoutImpactColor(0), MuscleMapColorScale.neutral);
    });
    test('10 -> light impact', () {
      expect(scale.workoutImpactColor(10), MuscleMapColorScale.lightImpact);
    });
    test('50 -> high/orange', () {
      expect(scale.workoutImpactColor(50), MuscleMapColorScale.highImpact);
    });
    test('90 -> max/red', () {
      expect(scale.workoutImpactColor(90), MuscleMapColorScale.maxImpact);
    });
  });

  group('recovery colour scale', () {
    test('90 -> recovered', () {
      expect(scale.recoveryColor(90), MuscleMapColorScale.recovered);
    });
    test('70 -> light fatigue', () {
      expect(scale.recoveryColor(70), MuscleMapColorScale.lightFatigue);
    });
    test('45 -> moderate fatigue', () {
      expect(scale.recoveryColor(45), MuscleMapColorScale.moderateFatigue);
    });
    test('20 -> fatigued', () {
      expect(scale.recoveryColor(20), MuscleMapColorScale.fatigued);
    });
  });

  group('path colour resolver', () {
    test('chest 100 colours both front chest paths red', () {
      final colors = resolver.resolvePathColors(
        scores: {MuscleGroup.chest: 100},
        mode: MuscleMapMode.workoutImpact,
        front: true,
      );
      expect(colors['chest_left'], MuscleMapColorScale.maxImpact);
      expect(colors['chest_right'], MuscleMapColorScale.maxImpact);
    });

    test('triceps 50 colours back triceps paths orange', () {
      final colors = resolver.resolvePathColors(
        scores: {MuscleGroup.triceps: 50},
        mode: MuscleMapMode.workoutImpact,
        front: false,
      );
      expect(colors['triceps_left'], MuscleMapColorScale.highImpact);
      expect(colors['triceps_right'], MuscleMapColorScale.highImpact);
    });

    test('muscle not mapped to this side is ignored, no crash', () {
      final colors = resolver.resolvePathColors(
        scores: {MuscleGroup.hipAdductors: 80, MuscleGroup.chest: 90},
        mode: MuscleMapMode.workoutImpact,
        front: true,
      );
      expect(colors.containsKey('chest_left'), isTrue);
      // hipAdductors has no front path -> nothing added for it.
      expect(colors.length, 2);
    });
  });

  group('svg colorizer', () {
    const svg =
        '<svg><rect id="chest_left" fill="#303030"/><rect id="abs" fill="#303030"/></svg>';

    test('recolours matching id and leaves others', () {
      final out = colorizer.recolorSvg(svg, const {
        'chest_left': Color(0xFFE53935),
      });
      expect(out.contains('fill="#E53935"'), isTrue);
      // abs keeps its original fill.
      expect(out.contains('id="abs"'), isTrue);
    });

    test('missing id in svg does not crash', () {
      final out = colorizer.recolorSvg(svg, const {
        'nonexistent_muscle': Color(0xFF00FF00),
        'chest_left': Color(0xFFE53935),
      });
      expect(out.contains('#E53935'), isTrue);
    });

    test('malformed svg returns source unchanged', () {
      const bad = '<svg><rect id=';
      final out = colorizer.recolorSvg(bad, const {'x': Color(0xFFFFFFFF)});
      expect(out, bad);
    });
  });

  test('colorToHex formats #RRGGBB', () {
    expect(colorToHex(const Color(0xFFE53935)), '#E53935');
    expect(colorToHex(const Color(0xFF2ECC71)), '#2ECC71');
  });
}
