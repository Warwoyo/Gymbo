import '../../../core/enums.dart';
import 'workout_repository.dart';
import 'workout_session.dart';
import 'workout_set.dart';
import 'workout_summary.dart';

class StartWorkoutSession {
  const StartWorkoutSession(this._repo);
  final WorkoutRepository _repo;
  Future<WorkoutSession> call({
    required String userProfileId,
    required DayType dayType,
  }) =>
      _repo.startSession(userProfileId: userProfileId, dayType: dayType);
}

class GetActiveWorkoutSession {
  const GetActiveWorkoutSession(this._repo);
  final WorkoutRepository _repo;
  Future<WorkoutSession?> call(String userProfileId) =>
      _repo.getActiveSession(userProfileId);
}

class UpdateWorkoutActivityTimestamp {
  const UpdateWorkoutActivityTimestamp(this._repo);
  final WorkoutRepository _repo;
  Future<void> call(String sessionId) => _repo.updateActivity(sessionId);
}

class LogWorkoutSet {
  const LogWorkoutSet(this._repo);
  final WorkoutRepository _repo;
  Future<WorkoutSet> call(WorkoutSet set) => _repo.logSet(set);
}

class EndWorkoutSession {
  const EndWorkoutSession(this._repo);
  final WorkoutRepository _repo;
  Future<WorkoutSession> call(String sessionId) => _repo.endSession(sessionId);
}

class AutoEndInactiveWorkoutSessions {
  const AutoEndInactiveWorkoutSessions(this._repo);
  final WorkoutRepository _repo;
  Future<int> call({required int timeoutMinutes}) =>
      _repo.autoEndInactiveSessions(timeoutMinutes: timeoutMinutes);
}

class GetWorkoutSummary {
  const GetWorkoutSummary(this._repo);
  final WorkoutRepository _repo;
  Future<WorkoutSummary> call(String sessionId) => _repo.getSummary(sessionId);
}

class ListWorkoutHistory {
  const ListWorkoutHistory(this._repo);
  final WorkoutRepository _repo;
  Future<List<WorkoutSession>> call(String userProfileId) =>
      _repo.listHistory(userProfileId);
}

class GetExerciseProgressHistory {
  const GetExerciseProgressHistory(this._repo);
  final WorkoutRepository _repo;
  Future<List<ExerciseProgressPoint>> call({
    required String userProfileId,
    required String exerciseId,
  }) =>
      _repo.getExerciseProgress(
          userProfileId: userProfileId, exerciseId: exerciseId);
}
