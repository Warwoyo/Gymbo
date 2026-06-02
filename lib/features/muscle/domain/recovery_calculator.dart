import 'dart:math' as math;

import '../../../core/enums.dart';
import 'muscle_impact.dart';
import 'muscle_recovery.dart';

class RecoveryCalculator {
  const RecoveryCalculator();

  double remainingStrain({
    required double impactScore,
    required DateTime workoutEndedAt,
    required DateTime now,
    required double halfLifeHours,
  }) {
    final hours = now.difference(workoutEndedAt).inMinutes / 60.0;
    if (hours <= 0) return impactScore;
    return impactScore * math.pow(0.5, hours / halfLifeHours);
  }

  double getRecoveryHalfLifeHours(
    MuscleGroup muscle,
    MuscleRegion region,
    double impactScore,
    bool highFailure,
  ) {
    var base = switch (region) {
      MuscleRegion.legs => 48.0,
      MuscleRegion.back => 42.0,
      MuscleRegion.chest || MuscleRegion.shoulders => 36.0,
      MuscleRegion.arms => 30.0,
      MuscleRegion.core => 24.0,
    };
    if (impactScore >= 75) base += 12;
    if (highFailure) base += 12;
    return base;
  }

  RecoveryLevel levelFor(double recoveryPercent) {
    if (recoveryPercent >= 80) return RecoveryLevel.recovered;
    if (recoveryPercent >= 60) return RecoveryLevel.lightFatigue;
    if (recoveryPercent >= 35) return RecoveryLevel.moderateFatigue;
    return RecoveryLevel.fatigued;
  }

  MuscleRecoveryState calculateMuscle({
    required MuscleGroup muscle,
    required DateTime now,
    required List<WorkoutImpactContribution> impacts,
  }) {
    final region = regionForMuscle(muscle);
    final contributions = <RecoveryContribution>[];
    DateTime? last;
    var strain = 0.0;
    for (final impact in impacts) {
      final halfLife = getRecoveryHalfLifeHours(
        muscle,
        region,
        impact.impact.normalizedScore,
        impact.highFailure,
      );
      final remaining = remainingStrain(
        impactScore: impact.impact.normalizedScore,
        workoutEndedAt: impact.workoutEndedAt,
        now: now,
        halfLifeHours: halfLife,
      );
      strain += remaining;
      if (last == null || impact.workoutEndedAt.isAfter(last)) {
        last = impact.workoutEndedAt;
      }
      contributions.add(RecoveryContribution(
        workoutSessionId: impact.workoutSessionId,
        workoutEndedAt: impact.workoutEndedAt,
        originalImpact: impact.impact.normalizedScore,
        remainingStrain: remaining,
        topExercises: impact.topExercises,
      ));
    }
    final recovery = (100 - strain).clamp(0.0, 100.0);
    return MuscleRecoveryState(
      muscle: muscle,
      region: region,
      recoveryPercent: recovery,
      currentStrain: strain,
      lastTrainedAt: last,
      daysSinceLastTrained: last == null ? -1 : now.difference(last).inDays,
      level: levelFor(recovery),
      contributions: contributions..sort((a, b) => b.remainingStrain.compareTo(a.remainingStrain)),
    );
  }
}

class WorkoutImpactContribution {
  const WorkoutImpactContribution({
    required this.workoutSessionId,
    required this.workoutEndedAt,
    required this.impact,
    this.highFailure = false,
    this.topExercises = const [],
  });

  final String workoutSessionId;
  final DateTime workoutEndedAt;
  final MuscleImpact impact;
  final bool highFailure;
  final List<String> topExercises;
}
