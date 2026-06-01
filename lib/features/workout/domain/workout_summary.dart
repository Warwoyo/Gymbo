import '../../../core/enums.dart';
import 'workout_session.dart';
import 'workout_set.dart';

/// Per-exercise breakdown inside a summary.
class ExerciseSummary {
  const ExerciseSummary({
    required this.workoutExerciseId,
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
    required this.bestEstimatedOneRepMaxKg,
    required this.isPersonalRecord,
  });

  final String workoutExerciseId;
  final String exerciseId;
  final String exerciseName;
  final List<WorkoutSet> sets;
  final double bestEstimatedOneRepMaxKg;

  /// True when this session set a new all-time e1RM for the exercise.
  final bool isPersonalRecord;

  List<WorkoutSet> get workingSets =>
      sets.where((s) => !s.isWarmup).toList(growable: false);
}

/// Aggregated, read-only view of a completed workout.
class WorkoutSummary {
  const WorkoutSummary({
    required this.session,
    required this.exercises,
  });

  final WorkoutSession session;
  final List<ExerciseSummary> exercises;

  DayType get dayType => session.dayType;
  DateTime get startedAt => session.startedAt;
  DateTime? get endedAt => session.endedAt;

  Duration get duration =>
      (session.endedAt ?? session.lastActivityAt).difference(session.startedAt);

  int get numberOfExercises => exercises.length;

  List<WorkoutSet> get _allWorkingSets =>
      exercises.expand((e) => e.workingSets).toList(growable: false);

  int get totalWorkingSets => _allWorkingSets.length;

  int get totalReps =>
      _allWorkingSets.fold(0, (sum, s) => sum + s.reps);

  /// Total volume load = sum(weightKg * reps) across working sets.
  double get totalVolumeLoad =>
      _allWorkingSets.fold(0.0, (sum, s) => sum + s.volume);

  List<ExerciseSummary> get personalRecords =>
      exercises.where((e) => e.isPersonalRecord).toList(growable: false);
}
