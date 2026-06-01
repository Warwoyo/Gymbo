import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/enums.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../../profile/domain/user_profile.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../recommendations/domain/recommendation_engine.dart';
import '../../recommendations/domain/workout_recommendation.dart';
import '../domain/workout_exercise.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import '../domain/workout_set.dart';
import 'rest_timer_controller.dart';

const _uuid = Uuid();

/// A session-exercise together with its catalog details and logged sets.
class WorkoutExerciseView {
  const WorkoutExerciseView({
    required this.workoutExercise,
    required this.exercise,
    required this.sets,
  });

  final WorkoutExercise workoutExercise;
  final Exercise exercise;
  final List<WorkoutSet> sets;

  List<WorkoutSet> get workingSets =>
      sets.where((s) => !s.isWarmup).toList(growable: false);

  WorkoutSet? get lastWorkingSet =>
      workingSets.isEmpty ? null : workingSets.last;
}

/// A recommendation plus the performance-based load adjustment applied to it.
class RecommendationView {
  const RecommendationView({
    required this.recommendation,
    required this.direction,
    required this.finalLoadKg,
  });

  final WorkoutRecommendation recommendation;
  final AdjustmentDirection direction;
  final double finalLoadKg;
}

class ActiveWorkoutState {
  const ActiveWorkoutState({
    required this.session,
    required this.exercises,
    this.selectedExerciseId,
    this.recommendation,
  });

  final WorkoutSession session;
  final List<WorkoutExerciseView> exercises;
  final String? selectedExerciseId;
  final RecommendationView? recommendation;

  WorkoutExerciseView? get selected {
    if (selectedExerciseId == null) return null;
    for (final e in exercises) {
      if (e.exercise.id == selectedExerciseId) return e;
    }
    return null;
  }

  ActiveWorkoutState copyWith({
    WorkoutSession? session,
    List<WorkoutExerciseView>? exercises,
    String? selectedExerciseId,
    RecommendationView? recommendation,
    bool clearRecommendation = false,
  }) {
    return ActiveWorkoutState(
      session: session ?? this.session,
      exercises: exercises ?? this.exercises,
      selectedExerciseId: selectedExerciseId ?? this.selectedExerciseId,
      recommendation:
          clearRecommendation ? null : (recommendation ?? this.recommendation),
    );
  }
}

final activeWorkoutProvider = AsyncNotifierProvider.family<WorkoutController,
    ActiveWorkoutState, String>(WorkoutController.new);

class WorkoutController
    extends FamilyAsyncNotifier<ActiveWorkoutState, String> {
  WorkoutRepository get _repo => ref.read(workoutRepositoryProvider);
  RecommendationEngine get _engine => ref.read(recommendationEngineProvider);

  late String _sessionId;

  @override
  Future<ActiveWorkoutState> build(String sessionId) async {
    _sessionId = sessionId;
    return _load();
  }

  Future<ActiveWorkoutState> _load({String? selectedExerciseId}) async {
    final session = await _repo.getSession(_sessionId);
    if (session == null) {
      throw StateError('Workout session not found');
    }
    final workoutExercises = await _repo.getSessionExercises(_sessionId);
    final views = <WorkoutExerciseView>[];
    final exerciseRepo = ref.read(exerciseRepositoryProvider);
    for (final we in workoutExercises) {
      final ex = await exerciseRepo.getById(we.exerciseId);
      if (ex == null) continue;
      final sets = await _repo.getSets(we.id);
      views.add(WorkoutExerciseView(
          workoutExercise: we, exercise: ex, sets: sets));
    }

    final current = state.valueOrNull;
    final selected = selectedExerciseId ?? current?.selectedExerciseId;
    final rec = current?.recommendation;
    return ActiveWorkoutState(
      session: session,
      exercises: views,
      selectedExerciseId: selected,
      recommendation: rec,
    );
  }

  UserProfile? get _profile => ref.read(activeProfileProvider).valueOrNull;

  double get _increment =>
      _profile?.preferredWeightIncrementKg ?? AppConstants.defaultIncrementKg;

  Future<void> selectExercise(String exerciseId) async {
    await _repo.ensureExercise(_sessionId, exerciseId);
    await _repo.updateActivity(_sessionId);
    final reloaded = await _load(selectedExerciseId: exerciseId);
    // Recompute recommendation from the latest working set, if any.
    final view = reloaded.selected;
    RecommendationView? rec;
    if (view?.lastWorkingSet != null) {
      rec = _buildRecommendation(view!.exercise.id, view.lastWorkingSet!);
    }
    state = AsyncData(reloaded.copyWith(
      recommendation: rec,
      clearRecommendation: rec == null,
    ));
  }

  RecommendationView _buildRecommendation(String exerciseId, WorkoutSet basis) {
    final goal = _profile?.primaryGoal ?? TrainingGoal.hypertrophy;
    final rec = _engine.generateRecommendation(
      exerciseId: exerciseId,
      basedOnSetId: basis.id,
      loggedWeightKg: basis.weightKg,
      loggedReps: basis.reps,
      goal: goal,
      incrementKg: _increment,
    );
    final adjustment = _engine.adjustForPerformance(
      currentLoadKg: rec.recommendedLoadKg,
      completedReps: basis.reps,
      targetRepLowerBound: rec.targetRepRangeMin,
      targetRepUpperBound: rec.targetRepRangeMax,
      incrementKg: _increment,
    );
    return RecommendationView(
      recommendation: rec,
      direction: adjustment.direction,
      finalLoadKg: adjustment.adjustedLoadKg,
    );
  }

  Future<void> logSet({
    required double weightKg,
    required int reps,
    bool isWarmup = false,
    bool isFailure = false,
    double? rpe,
    int? rir,
    String? notes,
  }) async {
    final selected = state.valueOrNull?.selected;
    if (selected == null) return;

    final now = DateTime.now();
    double? e1rm;
    if (!isWarmup && reps >= 1 && reps <= 30 && weightKg > 0) {
      e1rm = _engine.estimateOneRepMax(weightKg, reps);
    }

    final set = WorkoutSet(
      id: _uuid.v4(),
      workoutExerciseId: selected.workoutExercise.id,
      setNumber: selected.sets.length + 1,
      weightKg: weightKg,
      reps: reps,
      rpe: rpe,
      rir: rir,
      isWarmup: isWarmup,
      isFailure: isFailure,
      estimatedOneRepMaxKg: e1rm,
      createdAt: now,
      updatedAt: now,
      notes: notes,
    );

    await _repo.logSet(set);
    await _repo.updateActivity(_sessionId);

    final reloaded = await _load();
    final view = reloaded.selected;

    RecommendationView? rec;
    if (!isWarmup && view?.lastWorkingSet != null) {
      rec = _buildRecommendation(view!.exercise.id, view.lastWorkingSet!);
    } else {
      rec = reloaded.recommendation;
    }
    state = AsyncData(reloaded.copyWith(recommendation: rec));

    // Auto-start the rest timer unless disabled in the profile.
    final restEnabled = _profile?.restTimerEnabled ?? true;
    if (restEnabled) {
      final goal = _profile?.primaryGoal ?? TrainingGoal.hypertrophy;
      final seconds =
          rec?.recommendation.restSeconds ?? _engine.defaultRestSeconds(goal);
      ref.read(restTimerProvider.notifier).start(seconds);
    }
  }

  Future<void> deleteSet(String setId) async {
    await _repo.deleteSet(setId);
    await _repo.updateActivity(_sessionId);
    final reloaded = await _load();
    final view = reloaded.selected;
    RecommendationView? rec;
    if (view?.lastWorkingSet != null) {
      rec = _buildRecommendation(view!.exercise.id, view.lastWorkingSet!);
    }
    state = AsyncData(reloaded.copyWith(
      recommendation: rec,
      clearRecommendation: rec == null,
    ));
  }

  Future<void> touchActivity() => _repo.updateActivity(_sessionId);

  Future<WorkoutSession> endWorkout() async {
    ref.read(restTimerProvider.notifier).skip();
    final ended = await _repo.endSession(_sessionId);
    state = AsyncData((await _load()));
    return ended;
  }
}
