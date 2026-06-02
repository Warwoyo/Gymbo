import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../../core/services/notification_service.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../../profile/domain/user_profile.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../recommendations/domain/evidence_recommendation_engine.dart';
import '../domain/workout_exercise.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import '../../muscle/domain/muscle_recovery.dart';
import '../domain/workout_set.dart';
import 'rest_timer_controller.dart';
import 'session_providers.dart';

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
  final EvidenceRecommendation? recommendation;

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
    EvidenceRecommendation? recommendation,
    bool clearRecommendation = false,
    bool clearSelection = false,
  }) {
    return ActiveWorkoutState(
      session: session ?? this.session,
      exercises: exercises ?? this.exercises,
      selectedExerciseId:
          clearSelection ? null : (selectedExerciseId ?? this.selectedExerciseId),
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
  EvidenceRecommendationEngine get _engine =>
      ref.read(evidenceEngineProvider);

  late String _sessionId;

  @override
  Future<ActiveWorkoutState> build(String sessionId) async {
    _sessionId = sessionId;
    _configureRestTimer();
    final loaded = await _load();
    await _restoreRestTimer();
    _bindNotifications(loaded.session.status.isOpen);
    return loaded;
  }

  void _bindNotifications(bool sessionOpen) {
    final notif = NotificationService.instance;
    notif.onAction = (id) {
      final rt = ref.read(restTimerProvider.notifier);
      switch (id) {
        case NotifAction.add30:
          rt.addSeconds(_profile?.defaultAddRestSeconds ?? 30);
        case NotifAction.skip:
          rt.skip();
        case NotifAction.end:
          endWorkout();
      }
    };
    if (sessionOpen && (_profile?.restNotificationsEnabled ?? true)) {
      notif.showWorkoutActive();
    }
  }

  void _configureRestTimer() {
    final p = _profile;
    ref.read(restTimerProvider.notifier).configure(
          sessionId: _sessionId,
          options: RestTimerOptions(
            notificationsEnabled: p?.restNotificationsEnabled ?? true,
            soundEnabled: p?.soundEnabled ?? false,
            vibrationEnabled: p?.vibrationEnabled ?? false,
          ),
        );
  }

  Future<void> _restoreRestTimer() async {
    final persisted = await _repo.getRestTimer(_sessionId);
    if (persisted != null) {
      ref.read(restTimerProvider.notifier).restore(persisted);
    }
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
    return ActiveWorkoutState(
      session: session,
      exercises: views,
      selectedExerciseId: selected,
      recommendation: current?.recommendation,
    );
  }

  UserProfile? get _profile => ref.read(activeProfileProvider).valueOrNull;

  TrainingGoal get _goal => _profile?.primaryGoal ?? TrainingGoal.hypertrophy;
  RecommendationStyle get _style =>
      _profile?.recommendationStyle ?? RecommendationStyle.balanced;

  double _incrementFor(Exercise ex) =>
      ex.incrementKg(_profile?.incrementForEquipment(ex.equipmentType));

  Future<void> selectExercise(String exerciseId) async {
    await _repo.ensureExercise(_sessionId, exerciseId);
    await _repo.updateActivity(_sessionId);
    final reloaded = await _load(selectedExerciseId: exerciseId);
    final view = reloaded.selected;
    final rec = view == null ? null : _buildRecommendation(view);
    state = AsyncData(reloaded.copyWith(
      recommendation: rec,
      clearRecommendation: rec == null,
    ));
  }

  /// Builds an evidence-informed recommendation from a view's working sets.
  EvidenceRecommendation? _buildRecommendation(WorkoutExerciseView view) {
    final working = view.workingSets;
    if (working.isEmpty) return null;
    final current = _toInput(working.last);
    final previous =
        working.sublist(0, working.length - 1).map(_toInput).toList();
    return _engine.recommend(RecommendationContext(
      category: view.exercise.exerciseCategory,
      goal: _goal,
      incrementKg: _incrementFor(view.exercise),
      currentSet: current,
      previousWorkingSets: previous,
      style: _style,
      primaryMuscleRecoveryPercent: _primaryRecoveryPercent(view.exercise),
    ));
  }

  double? _primaryRecoveryPercent(Exercise exercise) {
    final recovery = ref.read(recoveryByMuscleProvider).valueOrNull ??
        const <MuscleGroup, MuscleRecoveryState>{};
    final primary = exercise.muscleTargets
        .where((t) => t.role == MuscleRole.primary)
        .map((t) => recovery[t.muscle]?.recoveryPercent)
        .whereType<double>()
        .toList();
    if (primary.isEmpty) return null;
    return primary.reduce((a, b) => a < b ? a : b);
  }

  LoggedSetInput _toInput(WorkoutSet s) => LoggedSetInput(
        weightKg: s.weightKg,
        reps: s.reps,
        rpe: s.rpe,
        rir: s.rir,
        isFailure: s.isFailure,
        isWarmup: s.isWarmup,
        restBeforeSetSeconds: s.restBeforeSetSeconds,
      );

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

    // Rest before this set = time since the previous set completed.
    int? restBefore;
    if (selected.sets.isNotEmpty) {
      final last = selected.sets.last;
      final ref0 = last.completedAt ?? last.createdAt;
      final secs = now.difference(ref0).inSeconds;
      if (secs >= 0) restBefore = secs;
    }

    double? e1rm;
    if (!isWarmup && reps >= 1 && reps <= 30 && weightKg > 0) {
      e1rm = _engine.epleyE1rm(weightKg, reps);
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
      restBeforeSetSeconds: restBefore,
      startedAt: now,
      completedAt: now,
      createdAt: now,
      updatedAt: now,
      notes: notes,
    );

    await _repo.logSet(set);
    await _repo.updateActivity(_sessionId);

    final reloaded = await _load();
    final view = reloaded.selected;
    final rec = view == null ? null : _buildRecommendation(view);
    state = AsyncData(reloaded.copyWith(
      recommendation: rec,
      clearRecommendation: rec == null,
    ));

    // Auto-start the rest timer unless disabled in the profile.
    final restEnabled = _profile?.restTimerEnabled ?? true;
    if (restEnabled) {
      _configureRestTimer();
      final seconds = rec?.recommendedRestSeconds ??
          _engine.recommend(RecommendationContext(
            category: selected.exercise.exerciseCategory,
            goal: _goal,
            incrementKg: _incrementFor(selected.exercise),
            currentSet: LoggedSetInput(weightKg: weightKg, reps: reps),
          )).recommendedRestSeconds;
      await ref.read(restTimerProvider.notifier).start(
            seconds,
            exerciseId: selected.exercise.id,
            afterSetId: set.id,
          );
    }
  }

  Future<void> deleteSet(String setId) async {
    await _repo.deleteSet(setId);
    await _repo.updateActivity(_sessionId);
    final reloaded = await _load();
    final view = reloaded.selected;
    final rec = view == null ? null : _buildRecommendation(view);
    state = AsyncData(reloaded.copyWith(
      recommendation: rec,
      clearRecommendation: rec == null,
    ));
  }

  /// Marks the current exercise complete and clears the selection.
  Future<void> endExercise() async {
    final selected = state.valueOrNull?.selected;
    if (selected != null) {
      await _repo.endWorkoutExercise(selected.workoutExercise.id);
    }
    ref.read(restTimerProvider.notifier).skip();
    final reloaded = await _load();
    state = AsyncData(reloaded.copyWith(
      clearSelection: true,
      clearRecommendation: true,
    ));
  }

  Future<void> touchActivity() => _repo.updateActivity(_sessionId);

  Future<WorkoutSession> endWorkout() async {
    ref.read(restTimerProvider.notifier).skip();
    await _repo.clearRestTimer(_sessionId);
    NotificationService.instance.cancelAll();
    final ended = await _repo.endSession(_sessionId);
    state = AsyncData((await _load()));
    return ended;
  }
}
