/// A single logged set within a workout exercise.
class WorkoutSet {
  const WorkoutSet({
    required this.id,
    required this.workoutExerciseId,
    required this.setNumber,
    required this.weightKg,
    required this.reps,
    this.rpe,
    this.rir,
    this.isWarmup = false,
    this.isFailure = false,
    this.estimatedOneRepMaxKg,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String workoutExerciseId;
  final int setNumber;
  final double weightKg;
  final int reps;
  final double? rpe;
  final int? rir;
  final bool isWarmup;
  final bool isFailure;
  final double? estimatedOneRepMaxKg;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;

  /// Volume load contribution of this set.
  double get volume => weightKg * reps;
}
