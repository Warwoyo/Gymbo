import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums.dart';
import '../../../data/db/app_database.dart';
import '../../muscle/domain/muscle_target.dart';
import '../domain/exercise.dart';
import '../domain/exercise_repository.dart';
import 'seed_exercises.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Exercise _map(ExerciseRow row) => Exercise(
        id: row.id,
        name: row.name,
        dayType: row.dayType,
        primaryMuscleGroup: row.primaryMuscleGroup,
        secondaryMuscleGroups: _decodeList(row.secondaryMuscleGroups),
        tags: _decodeList(row.tags),
        muscleTargets: const [],
        movementPattern: row.movementPattern,
        equipmentType: row.equipmentType,
        exerciseCategory:
            row.exerciseCategory ?? _deriveCategory(row.equipmentType),
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



  Future<Exercise> _mapWithTargets(ExerciseRow row) async {
    final base = _map(row);
    final targets = await getTargets(base.id);
    return Exercise(
      id: base.id,
      name: base.name,
      dayType: base.dayType,
      primaryMuscleGroup: base.primaryMuscleGroup,
      secondaryMuscleGroups: base.secondaryMuscleGroups,
      tags: base.tags,
      muscleTargets: targets,
      movementPattern: base.movementPattern,
      equipmentType: base.equipmentType,
      exerciseCategory: base.exerciseCategory,
      isBodyweight: base.isBodyweight,
      isUnilateral: base.isUnilateral,
      defaultIncrementKg: base.defaultIncrementKg,
      minimumRecommendedReps: base.minimumRecommendedReps,
      maximumRecommendedReps: base.maximumRecommendedReps,
      defaultRestSeconds: base.defaultRestSeconds,
      recommendedSetRangeMin: base.recommendedSetRangeMin,
      recommendedSetRangeMax: base.recommendedSetRangeMax,
      notes: base.notes,
      isCustom: base.isCustom,
      createdAt: base.createdAt,
      updatedAt: base.updatedAt,
    );
  }

  Future<List<MuscleTarget>> getTargets(String exerciseId) async {
    final rows = await (_db.select(_db.exerciseMuscleTargets)
          ..where((t) => t.exerciseId.equals(exerciseId)))
        .get();
    return rows
        .map((r) => MuscleTarget(
              muscle: r.muscleGroup,
              role: r.role,
              contribution: r.contribution,
            ))
        .toList(growable: false);
  }

  /// Fallback category for legacy rows migrated without one.
  static ExerciseCategory _deriveCategory(EquipmentType eq) {
    switch (eq) {
      case EquipmentType.barbell:
      case EquipmentType.dumbbell:
      case EquipmentType.smithMachine:
        return ExerciseCategory.compoundUpper;
      case EquipmentType.machine:
      case EquipmentType.plateLoaded:
        return ExerciseCategory.machineCompound;
      case EquipmentType.bodyweight:
        return ExerciseCategory.bodyweight;
      case EquipmentType.assistedBodyweight:
        return ExerciseCategory.assistedBodyweight;
      case EquipmentType.cable:
      case EquipmentType.resistanceBand:
      case EquipmentType.kettlebell:
      case EquipmentType.other:
        return ExerciseCategory.isolation;
    }
  }

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

  @override
  Future<int> count() async {
    final countExp = _db.exercises.id.count();
    final query = _db.selectOnly(_db.exercises)..addColumns([countExp]);
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  @override
  Future<void> seedIfEmpty() async {
    if (await count() > 0) {
      await _seedMissingMuscleTargets();
      return;
    }
    final now = DateTime.now();
    await _db.batch((b) {
      for (final s in kSeedExercises) {
        b.insert(
          _db.exercises,
          ExercisesCompanion.insert(
            id: _uuid.v4(),
            name: s.name,
            dayType: s.dayType ?? DayType.push,
            primaryMuscleGroup: s.primaryMuscleGroup,
            secondaryMuscleGroups:
                Value(_encodeList(s.secondaryMuscleGroups)),
            movementPattern: Value(s.movementPattern),
            equipmentType: s.equipmentType,
            exerciseCategory: Value(s.exerciseCategory),
            isBodyweight: Value(s.isBodyweight),
            isUnilateral: Value(s.isUnilateral),
            defaultIncrementKg: Value(s.defaultIncrementKg),
            tags: Value(_encodeList(tagsForSeed(s))),
            notes: Value(s.notes),
            isCustom: const Value(false),
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    });
    await _seedMissingMuscleTargets();
  }

  Future<void> _seedMissingMuscleTargets() async {
    for (final seed in kSeedExercises) {
      final row = await (_db.select(_db.exercises)
            ..where((t) => t.name.equals(seed.name)))
          .getSingleOrNull();
      if (row == null) continue;
      final existing = await (_db.select(_db.exerciseMuscleTargets)
            ..where((t) => t.exerciseId.equals(row.id)))
          .get();
      if (existing.isNotEmpty) continue;
      for (final target in muscleTargetsForSeed(seed)) {
        await _db.into(_db.exerciseMuscleTargets).insert(
              ExerciseMuscleTargetsCompanion.insert(
                id: _uuid.v4(),
                exerciseId: row.id,
                muscleGroup: target.muscle,
                role: target.role,
                contribution: target.contribution,
              ),
            );
      }
    }
  }

  @override
  Future<List<Exercise>> listByDayType(DayType dayType) async {
    final rows = await (_db.select(_db.exercises)
          ..where((t) => t.dayType.equalsValue(dayType))
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return Future.wait(rows.map(_mapWithTargets));
  }

  @override
  Future<List<Exercise>> listAll() async {
    final rows = await (_db.select(_db.exercises)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return Future.wait(rows.map(_mapWithTargets));
  }

  @override
  Future<Exercise?> getById(String id) async {
    final row = await (_db.select(_db.exercises)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapWithTargets(row);
  }

  @override
  Future<Exercise> createCustom(Exercise exercise) async {
    await _db.into(_db.exercises).insertOnConflictUpdate(
          ExercisesCompanion.insert(
            id: exercise.id,
            name: exercise.name,
            dayType: exercise.dayType ?? DayType.push,
            primaryMuscleGroup: exercise.primaryMuscleGroup,
            secondaryMuscleGroups:
                Value(_encodeList(exercise.secondaryMuscleGroups)),
            tags: Value(_encodeList(exercise.tags)),
            movementPattern: Value(exercise.movementPattern),
            equipmentType: exercise.equipmentType,
            exerciseCategory: Value(exercise.exerciseCategory),
            isBodyweight: Value(exercise.isBodyweight),
            isUnilateral: Value(exercise.isUnilateral),
            defaultIncrementKg: Value(exercise.defaultIncrementKg),
            minimumRecommendedReps: Value(exercise.minimumRecommendedReps),
            maximumRecommendedReps: Value(exercise.maximumRecommendedReps),
            defaultRestSeconds: Value(exercise.defaultRestSeconds),
            recommendedSetRangeMin: Value(exercise.recommendedSetRangeMin),
            recommendedSetRangeMax: Value(exercise.recommendedSetRangeMax),
            notes: Value(exercise.notes),
            isCustom: const Value(true),
            createdAt: exercise.createdAt,
            updatedAt: exercise.updatedAt,
          ),
        );
    await (_db.delete(_db.exerciseMuscleTargets)
          ..where((t) => t.exerciseId.equals(exercise.id)))
        .go();
    for (final target in exercise.muscleTargets) {
      await _db.into(_db.exerciseMuscleTargets).insert(
            ExerciseMuscleTargetsCompanion.insert(
              id: _uuid.v4(),
              exerciseId: exercise.id,
              muscleGroup: target.muscle,
              role: target.role,
              contribution: target.contribution,
            ),
          );
    }
    return exercise;
  }
}
