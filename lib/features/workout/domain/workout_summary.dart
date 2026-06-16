import '../../../core/enums.dart';
import '../../muscle/domain/muscle_impact.dart';
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
    this.trend = PerformanceTrend.stable,
    this.recommendedSetsMin = 0,
    this.recommendedSetsMax = 0,
  });

  final String workoutExerciseId;
  final String exerciseId;
  final String exerciseName;
  final List<WorkoutSet> sets;
  final double bestEstimatedOneRepMaxKg;

  /// True when this session set a new all-time e1RM for the exercise.
  final bool isPersonalRecord;
  final PerformanceTrend trend;
  final int recommendedSetsMin;
  final int recommendedSetsMax;

  List<WorkoutSet> get workingSets =>
      sets.where((s) => !s.isWarmup).toList(growable: false);

  double get totalVolume =>
      workingSets.fold(0.0, (sum, s) => sum + s.volume);

  WorkoutSet? get bestSet {
    WorkoutSet? best;
    for (final s in workingSets) {
      if (best == null || s.volume > best.volume) best = s;
    }
    return best;
  }

  /// Non-overclaiming advice for next time, based on the within-session trend.
  String get nextTimeAdvice {
    switch (trend) {
      case PerformanceTrend.improved:
        return 'Consider increasing your starting load next time.';
      case PerformanceTrend.declined:
        return 'Consider reducing load or adding rest next time.';
      case PerformanceTrend.stable:
        return 'Repeat next time and progress when it feels manageable.';
    }
  }
}

/// Aggregated, read-only view of a completed workout.
class WorkoutSummary {
  const WorkoutSummary({
    required this.session,
    required this.exercises,
    this.muscleImpacts = const [],
    this.regionImpacts = const [],
  });

  final WorkoutSession session;
  final List<ExerciseSummary> exercises;
  final List<MuscleImpact> muscleImpacts;
  final List<MuscleRegionImpact> regionImpacts;

  DayType? get dayType => session.dayType;
  DateTime get startedAt => session.startedAt;
  DateTime? get endedAt => session.endedAt;

  Duration get duration =>
      (session.endedAt ?? session.lastActivityAt).difference(session.startedAt);

  int get numberOfExercises => exercises.length;

  List<WorkoutSet> get _allWorkingSets =>
      exercises.expand((e) => e.workingSets).toList(growable: false);

  List<WorkoutSet> get _allWarmupSets =>
      exercises.expand((e) => e.sets.where((s) => s.isWarmup)).toList();

  int get totalWorkingSets => _allWorkingSets.length;
  int get totalWarmupSets => _allWarmupSets.length;

  int get totalReps => _allWorkingSets.fold(0, (sum, s) => sum + s.reps);

  /// Total volume load = sum(weightKg * reps) across working sets.
  double get totalVolumeLoad =>
      _allWorkingSets.fold(0.0, (sum, s) => sum + s.volume);

  List<int> get _rests => _allWorkingSets
      .map((s) => s.restBeforeSetSeconds)
      .whereType<int>()
      .toList();

  int get averageRestSeconds {
    final r = _rests;
    if (r.isEmpty) return 0;
    return (r.reduce((a, b) => a + b) / r.length).round();
  }

  int get longestRestSeconds =>
      _rests.isEmpty ? 0 : _rests.reduce((a, b) => a > b ? a : b);

  double get bestEstimatedOneRepMaxKg => exercises.fold(
      0.0,
      (best, e) =>
          e.bestEstimatedOneRepMaxKg > best ? e.bestEstimatedOneRepMaxKg : best);

  List<ExerciseSummary> get personalRecords =>
      exercises.where((e) => e.isPersonalRecord).toList(growable: false);

  List<MuscleImpact> get primaryMuscleImpacts => muscleImpacts
      .where((m) => m.strongestRole == MuscleRole.primary)
      .toList(growable: false);

  MuscleImpact? get topMuscleImpact =>
      muscleImpacts.isEmpty ? null : muscleImpacts.first;

  ExerciseSummary? get bestExercise {
    ExerciseSummary? best;
    for (final exercise in exercises) {
      if (best == null || exercise.totalVolume > best.totalVolume) {
        best = exercise;
      }
    }
    return best;
  }

  String get mainNextSessionAdvice {
    if (personalRecords.isNotEmpty) {
      return personalRecords.first.nextTimeAdvice;
    }
    final best = bestExercise;
    return best?.nextTimeAdvice ?? 'Log an exercise to build your next plan.';
  }
}
