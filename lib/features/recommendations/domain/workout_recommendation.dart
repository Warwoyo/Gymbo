/// A computed recommendation for the next working set.
///
/// Transient value object — not persisted to the database.
class WorkoutRecommendation {
  const WorkoutRecommendation({
    required this.exerciseId,
    required this.basedOnSetId,
    required this.estimatedOneRepMaxKg,
    required this.targetReps,
    required this.targetRepRangeMin,
    required this.targetRepRangeMax,
    required this.targetSetsMin,
    required this.targetSetsMax,
    required this.recommendedLoadKg,
    required this.recommendedLoadRangeMinKg,
    required this.recommendedLoadRangeMaxKg,
    required this.restSeconds,
    required this.explanation,
    this.lowReliability = false,
  });

  final String exerciseId;
  final String basedOnSetId;
  final double estimatedOneRepMaxKg;
  final int targetReps;
  final int targetRepRangeMin;
  final int targetRepRangeMax;
  final int targetSetsMin;
  final int targetSetsMax;
  final double recommendedLoadKg;
  final double recommendedLoadRangeMinKg;
  final double recommendedLoadRangeMaxKg;
  final int restSeconds;
  final String explanation;

  /// True when based on a high-rep set (>12) — estimate is less precise.
  final bool lowReliability;
}
