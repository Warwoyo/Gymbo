class WorkoutTemplateExercise {
  const WorkoutTemplateExercise({
    required this.id,
    required this.templateId,
    required this.exerciseId,
    required this.orderIndex,
    this.targetSets,
    this.targetReps,
    this.notes,
  });

  final String id;
  final String templateId;
  final String exerciseId;
  final int orderIndex;
  final int? targetSets;
  final int? targetReps;
  final String? notes;
}
