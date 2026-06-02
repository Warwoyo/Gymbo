import '../../../core/enums.dart';

class MuscleImpact {
  const MuscleImpact({
    required this.muscle,
    required this.rawScore,
    required this.normalizedScore,
    required this.workingSets,
    required this.volume,
    required this.strongestRole,
  });

  final MuscleGroup muscle;
  final double rawScore;
  final double normalizedScore;
  final int workingSets;
  final double volume;
  final MuscleRole strongestRole;
}

class MuscleRegionImpact {
  const MuscleRegionImpact({
    required this.region,
    required this.rawScore,
    required this.normalizedScore,
  });

  final MuscleRegion region;
  final double rawScore;
  final double normalizedScore;
}

class ExerciseImpactBreakdown {
  const ExerciseImpactBreakdown({
    required this.exerciseId,
    required this.exerciseName,
    required this.muscle,
    required this.role,
    required this.sets,
    required this.volume,
  });

  final String exerciseId;
  final String exerciseName;
  final MuscleGroup muscle;
  final MuscleRole role;
  final int sets;
  final double volume;
}
