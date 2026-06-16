import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums.dart';
import '../../../data/db/app_database.dart';
import '../../muscle/domain/muscle_impact.dart';
import '../../muscle/domain/muscle_impact_calculator.dart';
import '../../muscle/domain/muscle_recovery.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../../muscle/domain/muscle_target.dart';
import '../../muscle/domain/recovery_calculator.dart';
import '../../recommendations/domain/evidence_recommendation_engine.dart';
import '../domain/auto_end.dart';
import '../domain/persisted_rest_timer.dart';
import '../domain/workout_exercise.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import '../domain/workout_set.dart';
import '../domain/workout_summary.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  static List<String> _decodeList(String raw) {
    if (raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) return decoded.map((e) => e.toString()).toList();
    } catch (_) {}
    return const [];
  }

  static String _encodeList(List<String> values) =>
      values.isEmpty ? '' : jsonEncode(values);

  // ----------------------------- Mappers -----------------------------

  WorkoutSession _mapSession(WorkoutSessionRow r) => WorkoutSession(
        id: r.id,
        userProfileId: r.userProfileId,
        dayType: r.dayType,
        startedAt: r.startedAt,
        endedAt: r.endedAt,
        lastActivityAt: r.lastActivityAt,
        status: r.status,
        sessionName: r.sessionName,
        tags: _decodeList(r.tags),
        notes: r.notes,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      );

  WorkoutExercise _mapExercise(WorkoutExerciseRow r) => WorkoutExercise(
        id: r.id,
        sessionId: r.sessionId,
        exerciseId: r.exerciseId,
        orderIndex: r.orderIndex,
        startedAt: r.startedAt,
        endedAt: r.endedAt,
        notes: r.notes,
      );

  WorkoutSet _mapSet(WorkoutSetRow r) => WorkoutSet(
        id: r.id,
        workoutExerciseId: r.workoutExerciseId,
        setNumber: r.setNumber,
        weightKg: r.weightKg,
        reps: r.reps,
        loadType: r.loadType,
        rpe: r.rpe,
        rir: r.rir,
        isWarmup: r.isWarmup,
        isFailure: r.isFailure,
        estimatedOneRepMaxKg: r.estimatedOneRepMaxKg,
        restBeforeSetSeconds: r.restBeforeSetSeconds,
        restAfterSetSeconds: r.restAfterSetSeconds,
        startedAt: r.startedAt,
        completedAt: r.completedAt,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
        notes: r.notes,
      );

  // ----------------------------- Sessions -----------------------------

  @override
  Future<WorkoutSession> startSession({
    required String userProfileId,
    DayType? dayType,
    List<String> tags = const [],
  }) async {
    final now = DateTime.now();
    final session = WorkoutSession(
      id: _uuid.v4(),
      userProfileId: userProfileId,
      dayType: dayType,
      tags: tags,
      startedAt: now,
      lastActivityAt: now,
      status: WorkoutSessionStatus.active,
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.workoutSessions).insert(
          WorkoutSessionsCompanion.insert(
            id: session.id,
            userProfileId: session.userProfileId,
            dayType: Value(session.dayType ?? DayType.push),
            tags: Value(_encodeList(session.tags)),
            startedAt: session.startedAt,
            lastActivityAt: session.lastActivityAt,
            status: session.status,
            createdAt: session.createdAt,
            updatedAt: session.updatedAt,
          ),
        );
    return session;
  }

  @override
  Future<WorkoutSession?> getActiveSession(String userProfileId) async {
    final row = await (_db.select(_db.workoutSessions)
          ..where((t) =>
              t.userProfileId.equals(userProfileId) &
              t.status.isIn([
                WorkoutSessionStatus.active.name,
                WorkoutSessionStatus.resting.name,
                WorkoutSessionStatus.paused.name,
              ]))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.startedAt, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _mapSession(row);
  }

  @override
  Future<WorkoutSession?> getSession(String sessionId) async {
    final row = await (_db.select(_db.workoutSessions)
          ..where((t) => t.id.equals(sessionId)))
        .getSingleOrNull();
    return row == null ? null : _mapSession(row);
  }

  @override
  Future<void> updateActivity(String sessionId, [DateTime? at]) async {
    final now = at ?? DateTime.now();
    await (_db.update(_db.workoutSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(WorkoutSessionsCompanion(
      lastActivityAt: Value(now),
      updatedAt: Value(now),
    ));
  }

  @override
  Future<void> setStatus(
      String sessionId, WorkoutSessionStatus status) async {
    await (_db.update(_db.workoutSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(WorkoutSessionsCompanion(
      status: Value(status),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<WorkoutSession> endSession(String sessionId) async {
    final now = DateTime.now();
    await (_db.update(_db.workoutSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(WorkoutSessionsCompanion(
      endedAt: Value(now),
      lastActivityAt: Value(now),
      status: const Value(WorkoutSessionStatus.completed),
      updatedAt: Value(now),
    ));
    await _calculateAndStoreImpacts(sessionId);
    return (await getSession(sessionId))!;
  }

  Future<void> _calculateAndStoreImpacts(String sessionId) async {
    final workoutExercises = await getSessionExercises(sessionId);
    final inputs = <ExerciseSetInput>[];
    for (final we in workoutExercises) {
      final exRow = await (_db.select(_db.exercises)
            ..where((t) => t.id.equals(we.exerciseId)))
          .getSingleOrNull();
      if (exRow == null) continue;
      final targetRows = await (_db.select(_db.exerciseMuscleTargets)
            ..where((t) => t.exerciseId.equals(we.exerciseId)))
          .get();
      final exercise = _exerciseFromRow(exRow, targetRows);
      final sets = await getSets(we.id);
      inputs.add(ExerciseSetInput(exercise: exercise, sets: sets));
    }
    final calc = const MuscleImpactCalculator();
    final impacts = calc.calculate(inputs);
    final regions = calc.aggregateRegions(impacts);
    await (_db.delete(_db.workoutMuscleImpacts)
          ..where((t) => t.sessionId.equals(sessionId)))
        .go();
    await (_db.delete(_db.workoutRegionImpacts)
          ..where((t) => t.sessionId.equals(sessionId)))
        .go();
    for (final impact in impacts) {
      await _db.into(_db.workoutMuscleImpacts).insert(
            WorkoutMuscleImpactsCompanion.insert(
              id: _uuid.v4(),
              sessionId: sessionId,
              muscleGroup: impact.muscle,
              rawScore: impact.rawScore,
              normalizedScore: impact.normalizedScore,
              workingSets: impact.workingSets,
              volume: impact.volume,
              strongestRole: impact.strongestRole,
            ),
          );
    }
    for (final region in regions) {
      await _db.into(_db.workoutRegionImpacts).insert(
            WorkoutRegionImpactsCompanion.insert(
              id: _uuid.v4(),
              sessionId: sessionId,
              region: region.region,
              rawScore: region.rawScore,
              normalizedScore: region.normalizedScore,
            ),
          );
    }
  }

  @override
  Future<int> autoEndInactiveSessions({required int timeoutMinutes}) async {
    final open = await (_db.select(_db.workoutSessions)
          ..where((t) => t.status.isIn([
                WorkoutSessionStatus.active.name,
                WorkoutSessionStatus.resting.name,
                WorkoutSessionStatus.paused.name,
              ])))
        .get();

    final now = DateTime.now();
    var count = 0;
    for (final s in open) {
      if (AutoEnd.shouldAutoEnd(
        lastActivityAt: s.lastActivityAt,
        now: now,
        timeoutMinutes: timeoutMinutes,
      )) {
        final deadline = AutoEnd.endTimestamp(
          lastActivityAt: s.lastActivityAt,
          timeoutMinutes: timeoutMinutes,
        );
        await (_db.update(_db.workoutSessions)
              ..where((t) => t.id.equals(s.id)))
            .write(WorkoutSessionsCompanion(
          endedAt: Value(deadline),
          status: const Value(WorkoutSessionStatus.autoCompleted),
          updatedAt: Value(now),
        ));
        count++;
      }
    }
    return count;
  }

  // ----------------------------- Exercises -----------------------------

  @override
  Future<WorkoutExercise> ensureExercise(
      String sessionId, String exerciseId) async {
    final existing = await (_db.select(_db.workoutExercises)
          ..where((t) =>
              t.sessionId.equals(sessionId) &
              t.exerciseId.equals(exerciseId)))
        .getSingleOrNull();
    if (existing != null) return _mapExercise(existing);

    final current = await getSessionExercises(sessionId);
    final now = DateTime.now();
    final we = WorkoutExercise(
      id: _uuid.v4(),
      sessionId: sessionId,
      exerciseId: exerciseId,
      orderIndex: current.length,
      startedAt: now,
    );
    await _db.into(_db.workoutExercises).insert(
          WorkoutExercisesCompanion.insert(
            id: we.id,
            sessionId: we.sessionId,
            exerciseId: we.exerciseId,
            orderIndex: we.orderIndex,
            startedAt: Value(we.startedAt),
          ),
        );
    return we;
  }

  @override
  Future<List<WorkoutExercise>> getSessionExercises(String sessionId) async {
    final rows = await (_db.select(_db.workoutExercises)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm(expression: t.orderIndex)]))
        .get();
    return rows.map(_mapExercise).toList();
  }

  @override
  Future<void> endWorkoutExercise(String workoutExerciseId) async {
    await (_db.update(_db.workoutExercises)
          ..where((t) => t.id.equals(workoutExerciseId)))
        .write(WorkoutExercisesCompanion(endedAt: Value(DateTime.now())));
  }

  // ----------------------------- Sets -----------------------------

  @override
  Future<WorkoutSet> logSet(WorkoutSet set) async {
    await _db.into(_db.workoutSets).insert(
          WorkoutSetsCompanion.insert(
            id: set.id,
            workoutExerciseId: set.workoutExerciseId,
            setNumber: set.setNumber,
            weightKg: set.weightKg,
            reps: set.reps,
            loadType: Value(set.loadType),
            rpe: Value(set.rpe),
            rir: Value(set.rir),
            isWarmup: Value(set.isWarmup),
            isFailure: Value(set.isFailure),
            estimatedOneRepMaxKg: Value(set.estimatedOneRepMaxKg),
            restBeforeSetSeconds: Value(set.restBeforeSetSeconds),
            restAfterSetSeconds: Value(set.restAfterSetSeconds),
            startedAt: Value(set.startedAt),
            completedAt: Value(set.completedAt),
            createdAt: set.createdAt,
            updatedAt: set.updatedAt,
            notes: Value(set.notes),
          ),
        );
    return set;
  }

  @override
  Future<void> updateSet(WorkoutSet set) async {
    await (_db.update(_db.workoutSets)..where((t) => t.id.equals(set.id)))
        .write(WorkoutSetsCompanion(
      weightKg: Value(set.weightKg),
      reps: Value(set.reps),
      loadType: Value(set.loadType),
      rpe: Value(set.rpe),
      rir: Value(set.rir),
      isWarmup: Value(set.isWarmup),
      isFailure: Value(set.isFailure),
      estimatedOneRepMaxKg: Value(set.estimatedOneRepMaxKg),
      updatedAt: Value(DateTime.now()),
      notes: Value(set.notes),
    ));
  }

  @override
  Future<void> deleteSet(String setId) async {
    await (_db.delete(_db.workoutSets)..where((t) => t.id.equals(setId))).go();
  }

  @override
  Future<List<WorkoutSet>> getSets(String workoutExerciseId) async {
    final rows = await (_db.select(_db.workoutSets)
          ..where((t) => t.workoutExerciseId.equals(workoutExerciseId))
          ..orderBy([(t) => OrderingTerm(expression: t.setNumber)]))
        .get();
    return rows.map(_mapSet).toList();
  }

  // ----------------------------- Summary -----------------------------

  @override
  Future<WorkoutSummary> getSummary(String sessionId) async {
    final session = await getSession(sessionId);
    if (session == null) {
      throw StateError('Session $sessionId not found');
    }
    final workoutExercises = await getSessionExercises(sessionId);

    final exerciseSummaries = <ExerciseSummary>[];
    for (final we in workoutExercises) {
      final sets = await getSets(we.id);
      if (sets.isEmpty) continue;

      final name = await _exerciseName(we.exerciseId);
      final working = sets.where((s) => !s.isWarmup).toList();
      double best = 0;
      for (final s in working) {
        final e = s.estimatedOneRepMaxKg ?? 0;
        if (e > best) best = e;
      }

      final allTimeBest = await _allTimeBestBefore(
        userProfileId: session.userProfileId,
        exerciseId: we.exerciseId,
        before: session.startedAt,
      );
      final isPr = best > 0 && best > allTimeBest;

      final trend = EvidenceRecommendationEngine.trendOf(working
          .map((s) => LoggedSetInput(weightKg: s.weightKg, reps: s.reps, loadType: s.loadType))
          .toList());

      exerciseSummaries.add(ExerciseSummary(
        workoutExerciseId: we.id,
        exerciseId: we.exerciseId,
        exerciseName: name,
        sets: sets,
        bestEstimatedOneRepMaxKg: best,
        isPersonalRecord: isPr,
        trend: trend,
      ));
    }

    return WorkoutSummary(
      session: session,
      exercises: exerciseSummaries,
      muscleImpacts: await getMuscleImpacts(sessionId),
      regionImpacts: await getRegionImpacts(sessionId),
    );
  }


  Exercise _exerciseFromRow(
    ExerciseRow row,
    List<ExerciseMuscleTargetRow> targets,
  ) {
    return Exercise(
      id: row.id,
      name: row.name,
      dayType: row.dayType,
      primaryMuscleGroup: row.primaryMuscleGroup,
      secondaryMuscleGroups: _decodeList(row.secondaryMuscleGroups),
      tags: _decodeList(row.tags),
      muscleTargets: targets
          .map((t) => MuscleTarget(
                muscle: t.muscleGroup,
                role: t.role,
                contribution: t.contribution,
              ))
          .toList(growable: false),
      movementPattern: row.movementPattern,
      equipmentType: row.equipmentType,
      exerciseCategory: row.exerciseCategory ?? ExerciseCategory.compoundUpper,
      isBodyweight: row.isBodyweight,
      isUnilateral: row.isUnilateral,
      defaultIncrementKg: row.defaultIncrementKg,
      minimumRecommendedReps: row.minimumRecommendedReps,
      maximumRecommendedReps: row.maximumRecommendedReps,
      defaultRestSeconds: row.defaultRestSeconds,
      recommendedSetRangeMin: row.recommendedSetRangeMin,
      recommendedSetRangeMax: row.recommendedSetRangeMax,
      notes: row.notes,
      isCustom: row.isCustom,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<String> _exerciseName(String exerciseId) async {
    final row = await (_db.select(_db.exercises)
          ..where((t) => t.id.equals(exerciseId)))
        .getSingleOrNull();
    return row?.name ?? 'Exercise';
  }

  /// Best estimated 1RM for an exercise across sessions started before [before].
  Future<double> _allTimeBestBefore({
    required String userProfileId,
    required String exerciseId,
    required DateTime before,
  }) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(
        _db.workoutExercises,
        _db.workoutExercises.id.equalsExp(_db.workoutSets.workoutExerciseId),
      ),
      innerJoin(
        _db.workoutSessions,
        _db.workoutSessions.id.equalsExp(_db.workoutExercises.sessionId),
      ),
    ])
      ..where(_db.workoutExercises.exerciseId.equals(exerciseId) &
          _db.workoutSessions.userProfileId.equals(userProfileId) &
          _db.workoutSessions.startedAt.isSmallerThanValue(before) &
          _db.workoutSets.isWarmup.equals(false));

    final rows = await query.get();
    double best = 0;
    for (final r in rows) {
      final e = r.readTable(_db.workoutSets).estimatedOneRepMaxKg ?? 0;
      if (e > best) best = e;
    }
    return best;
  }

  @override
  Future<List<MuscleImpact>> getMuscleImpacts(String sessionId) async {
    final rows = await (_db.select(_db.workoutMuscleImpacts)
          ..where((t) => t.sessionId.equals(sessionId)))
        .get();
    return rows
        .map((r) => MuscleImpact(
              muscle: r.muscleGroup,
              rawScore: r.rawScore,
              normalizedScore: r.normalizedScore,
              workingSets: r.workingSets,
              volume: r.volume,
              strongestRole: r.strongestRole,
            ))
        .toList(growable: false);
  }

  @override
  Future<List<MuscleRegionImpact>> getRegionImpacts(String sessionId) async {
    final rows = await (_db.select(_db.workoutRegionImpacts)
          ..where((t) => t.sessionId.equals(sessionId)))
        .get();
    return rows
        .map((r) => MuscleRegionImpact(
              region: r.region,
              rawScore: r.rawScore,
              normalizedScore: r.normalizedScore,
            ))
        .toList(growable: false);
  }

  @override
  Future<Map<MuscleGroup, MuscleRecoveryState>> getRecoveryByMuscle(
    String userProfileId, {
    DateTime? now,
  }) async {
    final asOf = now ?? DateTime.now();
    final sessions = await listHistory(userProfileId);
    final byMuscle = <MuscleGroup, List<WorkoutImpactContribution>>{};

    for (final session in sessions) {
      final endedAt = session.endedAt;
      if (endedAt == null) continue;
      final impacts = await getMuscleImpacts(session.id);
      for (final impact in impacts) {
        byMuscle.putIfAbsent(impact.muscle, () => []).add(
              WorkoutImpactContribution(
                workoutSessionId: session.id,
                workoutEndedAt: endedAt,
                impact: impact,
              ),
            );
      }
    }

    const calculator = RecoveryCalculator();
    return {
      for (final muscle in MuscleGroup.values)
        muscle: calculator.calculateMuscle(
          muscle: muscle,
          now: asOf,
          impacts: byMuscle[muscle] ?? const [],
        ),
    };
  }

  // ----------------------------- History -----------------------------

  @override
  Future<List<WorkoutSession>> listHistory(String userProfileId) async {
    final rows = await (_db.select(_db.workoutSessions)
          ..where((t) =>
              t.userProfileId.equals(userProfileId) &
              t.status.isIn([
                WorkoutSessionStatus.completed.name,
                WorkoutSessionStatus.autoCompleted.name,
                WorkoutSessionStatus.abandoned.name,
              ]))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.startedAt, mode: OrderingMode.desc)
          ]))
        .get();
    return rows.map(_mapSession).toList();
  }

  @override
  Future<WorkoutSession?> lastFinishedSession(String userProfileId) async {
    final history = await listHistory(userProfileId);
    return history.isEmpty ? null : history.first;
  }

  @override
  Future<List<ExerciseProgressPoint>> getExerciseProgress({
    required String userProfileId,
    required String exerciseId,
  }) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(
        _db.workoutExercises,
        _db.workoutExercises.id.equalsExp(_db.workoutSets.workoutExerciseId),
      ),
      innerJoin(
        _db.workoutSessions,
        _db.workoutSessions.id.equalsExp(_db.workoutExercises.sessionId),
      ),
    ])
      ..where(_db.workoutExercises.exerciseId.equals(exerciseId) &
          _db.workoutSessions.userProfileId.equals(userProfileId) &
          _db.workoutSets.isWarmup.equals(false));

    final rows = await query.get();

    // Group by session start date (day granularity).
    final byDay = <DateTime, List<WorkoutSet>>{};
    for (final r in rows) {
      final started = r.readTable(_db.workoutSessions).startedAt;
      final day = DateTime(started.year, started.month, started.day);
      byDay.putIfAbsent(day, () => []).add(_mapSet(r.readTable(_db.workoutSets)));
    }

    final points = <ExerciseProgressPoint>[];
    byDay.forEach((day, sets) {
      double bestE1rm = 0;
      double topWeight = 0;
      int topReps = 0;
      double volume = 0;
      for (final s in sets) {
        volume += s.volume;
        final e = s.estimatedOneRepMaxKg ?? 0;
        if (e > bestE1rm) bestE1rm = e;
        if (s.weightKg > topWeight) {
          topWeight = s.weightKg;
          topReps = s.reps;
        }
      }
      points.add(ExerciseProgressPoint(
        date: day,
        bestEstimatedOneRepMaxKg: bestE1rm,
        topWeightKg: topWeight,
        topWeightReps: topReps,
        totalVolume: volume,
      ));
    });

    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  // ----------------------------- Rest timer -----------------------------

  @override
  Future<void> saveRestTimer(PersistedRestTimer t) async {
    await _db.into(_db.restTimerStates).insertOnConflictUpdate(
          RestTimerStatesCompanion.insert(
            sessionId: t.sessionId,
            exerciseId: Value(t.exerciseId),
            afterSetId: Value(t.afterSetId),
            startedAt: t.startedAt,
            endsAt: t.endsAt,
            totalSeconds: t.totalSeconds,
            isRunning: Value(t.isRunning),
            isPaused: Value(t.isPaused),
            pausedAt: Value(t.pausedAt),
            accumulatedPausedSeconds: Value(t.accumulatedPausedSeconds),
            allowSilentNotification: Value(t.allowSilentNotification),
          ),
        );
  }

  @override
  Future<PersistedRestTimer?> getRestTimer(String sessionId) async {
    final r = await (_db.select(_db.restTimerStates)
          ..where((t) => t.sessionId.equals(sessionId)))
        .getSingleOrNull();
    if (r == null) return null;
    return PersistedRestTimer(
      sessionId: r.sessionId,
      exerciseId: r.exerciseId,
      afterSetId: r.afterSetId,
      startedAt: r.startedAt,
      endsAt: r.endsAt,
      totalSeconds: r.totalSeconds,
      isRunning: r.isRunning,
      isPaused: r.isPaused,
      pausedAt: r.pausedAt,
      accumulatedPausedSeconds: r.accumulatedPausedSeconds,
      allowSilentNotification: r.allowSilentNotification,
    );
  }

  @override
  Future<void> clearRestTimer(String sessionId) async {
    await (_db.delete(_db.restTimerStates)
          ..where((t) => t.sessionId.equals(sessionId)))
        .go();
  }
}
