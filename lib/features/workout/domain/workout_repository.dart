import '../../../core/enums.dart';
import 'persisted_rest_timer.dart';
import 'workout_exercise.dart';
import 'workout_session.dart';
import 'workout_set.dart';
import 'workout_summary.dart';

/// One data point in an exercise's progress history.
class ExerciseProgressPoint {
  const ExerciseProgressPoint({
    required this.date,
    required this.bestEstimatedOneRepMaxKg,
    required this.topWeightKg,
    required this.topWeightReps,
    required this.totalVolume,
  });

  final DateTime date;
  final double bestEstimatedOneRepMaxKg;
  final double topWeightKg;
  final int topWeightReps;
  final double totalVolume;
}

abstract class WorkoutRepository {
  Future<WorkoutSession> startSession({
    required String userProfileId,
    required DayType dayType,
  });

  Future<WorkoutSession?> getActiveSession(String userProfileId);
  Future<WorkoutSession?> getSession(String sessionId);

  Future<void> updateActivity(String sessionId, [DateTime? at]);
  Future<void> setStatus(String sessionId, WorkoutSessionStatus status);
  Future<WorkoutSession> endSession(String sessionId);

  /// Auto-completes any open session inactive for >= [timeoutMinutes].
  /// Returns the number of sessions auto-completed.
  Future<int> autoEndInactiveSessions({required int timeoutMinutes});

  /// Returns the existing session-exercise or creates it.
  Future<WorkoutExercise> ensureExercise(String sessionId, String exerciseId);
  Future<List<WorkoutExercise>> getSessionExercises(String sessionId);
  Future<void> endWorkoutExercise(String workoutExerciseId);

  Future<WorkoutSet> logSet(WorkoutSet set);
  Future<void> updateSet(WorkoutSet set);
  Future<void> deleteSet(String setId);
  Future<List<WorkoutSet>> getSets(String workoutExerciseId);

  Future<WorkoutSummary> getSummary(String sessionId);
  Future<List<WorkoutSession>> listHistory(String userProfileId);
  Future<WorkoutSession?> lastFinishedSession(String userProfileId);

  Future<List<ExerciseProgressPoint>> getExerciseProgress({
    required String userProfileId,
    required String exerciseId,
  });

  // Rest-timer persistence (spec §8).
  Future<void> saveRestTimer(PersistedRestTimer timer);
  Future<PersistedRestTimer?> getRestTimer(String sessionId);
  Future<void> clearRestTimer(String sessionId);
}
