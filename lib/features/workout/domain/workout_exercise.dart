/// An exercise performed within a workout session.
class WorkoutExercise {
  const WorkoutExercise({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.orderIndex,
    this.startedAt,
    this.endedAt,
    this.notes,
  });

  final String id;
  final String sessionId;
  final String exerciseId;
  final int orderIndex;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final String? notes;
}
