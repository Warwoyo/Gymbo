import '../../../core/enums.dart';

class MuscleRecoveryState {
  const MuscleRecoveryState({
    required this.muscle,
    required this.region,
    required this.recoveryPercent,
    required this.currentStrain,
    required this.daysSinceLastTrained,
    required this.level,
    this.lastTrainedAt,
    this.contributions = const [],
  });

  final MuscleGroup muscle;
  final MuscleRegion region;
  final double recoveryPercent;
  final double currentStrain;
  final DateTime? lastTrainedAt;
  final int daysSinceLastTrained;
  final RecoveryLevel level;
  final List<RecoveryContribution> contributions;
}

class RecoveryContribution {
  const RecoveryContribution({
    required this.workoutSessionId,
    required this.workoutEndedAt,
    required this.originalImpact,
    required this.remainingStrain,
    this.topExercises = const [],
  });

  final String workoutSessionId;
  final DateTime workoutEndedAt;
  final double originalImpact;
  final double remainingStrain;
  final List<String> topExercises;
}
