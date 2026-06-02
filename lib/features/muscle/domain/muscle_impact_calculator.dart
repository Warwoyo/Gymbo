import 'dart:math' as math;

import '../../../core/enums.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../../workout/domain/workout_set.dart';
import 'muscle_impact.dart';
import 'muscle_target.dart';

class MuscleImpactCalculator {
  const MuscleImpactCalculator({this.estimatedBodyWeightKg});

  final double? estimatedBodyWeightKg;

  List<MuscleImpact> calculate(Iterable<ExerciseSetInput> inputs) {
    final buckets = <MuscleGroup, _Bucket>{};
    for (final input in inputs) {
      if (input.exercise.muscleTargets.isEmpty) continue;
      for (final set in input.sets) {
        final baseVolume = _setVolume(set, input.exercise);
        if (baseVolume <= 0) continue;
        final intensity = _intensityFactor(set);
        final effort = _effortFactor(set);
        final warmup = set.isWarmup ? 0.35 : 1.0;
        for (final target in input.exercise.muscleTargets) {
          final impact = baseVolume * target.contribution * intensity * effort * warmup;
          final b = buckets.putIfAbsent(target.muscle, _Bucket.new);
          b.rawScore += impact;
          b.volume += baseVolume * target.contribution;
          if (!set.isWarmup) b.workingSets += 1;
          if (target.role.index < b.strongestRole.index) b.strongestRole = target.role;
        }
      }
    }
    if (buckets.isEmpty) return const [];
    final maxRaw = buckets.values.map((b) => b.rawScore).reduce(math.max);
    if (maxRaw <= 0) return const [];
    final impacts = buckets.entries.map((e) {
      final b = e.value;
      return MuscleImpact(
        muscle: e.key,
        rawScore: b.rawScore,
        normalizedScore: b.rawScore / maxRaw * 100,
        workingSets: b.workingSets,
        volume: b.volume,
        strongestRole: b.strongestRole,
      );
    }).toList()
      ..sort((a, b) => b.rawScore.compareTo(a.rawScore));
    return impacts;
  }

  List<MuscleRegionImpact> aggregateRegions(List<MuscleImpact> impacts) {
    final totals = <MuscleRegion, double>{};
    for (final impact in impacts) {
      final region = regionForMuscle(impact.muscle);
      totals[region] = (totals[region] ?? 0) + impact.rawScore;
    }
    if (totals.isEmpty) return const [];
    final maxRaw = totals.values.reduce(math.max);
    return totals.entries
        .map((e) => MuscleRegionImpact(
              region: e.key,
              rawScore: e.value,
              normalizedScore: maxRaw <= 0 ? 0 : e.value / maxRaw * 100,
            ))
        .toList()
      ..sort((a, b) => b.rawScore.compareTo(a.rawScore));
  }

  double _setVolume(WorkoutSet set, Exercise exercise) {
    if (set.weightKg > 0) return set.weightKg * set.reps;
    if (exercise.isBodyweight && estimatedBodyWeightKg != null) {
      return estimatedBodyWeightKg! * set.reps;
    }
    return set.reps * 1.0;
  }

  double _intensityFactor(WorkoutSet set) {
    final e1rm = set.estimatedOneRepMaxKg;
    if (e1rm == null || e1rm <= 0 || set.weightKg <= 0) return 1.0;
    final relative = (set.weightKg / e1rm).clamp(0.3, 1.0);
    return 0.75 + relative * 0.5;
  }

  double _effortFactor(WorkoutSet set) {
    if (set.isFailure) return 1.15;
    if (set.rpe != null) return (0.75 + (set.rpe! / 10) * 0.5).clamp(0.8, 1.25);
    if (set.rir != null) return (1.2 - (set.rir! * 0.05)).clamp(0.85, 1.2);
    return 1.0;
  }
}

class ExerciseSetInput {
  const ExerciseSetInput({required this.exercise, required this.sets});

  final Exercise exercise;
  final List<WorkoutSet> sets;
}

class _Bucket {
  double rawScore = 0;
  double volume = 0;
  int workingSets = 0;
  MuscleRole strongestRole = MuscleRole.stabilizer;
}
