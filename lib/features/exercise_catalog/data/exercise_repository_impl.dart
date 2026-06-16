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
        userProfileId: row.userProfileId,
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
      userProfileId: base.userProfileId,
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
    await _seedMissingExercises();
    await _seedMissingMuscleTargets();
  }

  Future<void> _seedMissingExercises() async {
    final now = DateTime.now();
    for (final seed in kSeedExercises) {
      final existing = await (_db.select(_db.exercises)
            ..where((t) => t.name.equals(seed.name)))
          .getSingleOrNull();
      if (existing != null) continue;

      await _db.into(_db.exercises).insert(_companionForSeed(seed, now));
    }
  }

  ExercisesCompanion _companionForSeed(SeedExercise seed, DateTime now) {
    return ExercisesCompanion.insert(
      id: _uuid.v4(),
      name: seed.name,
      dayType: Value(seed.dayType),
      primaryMuscleGroup: seed.primaryMuscleGroup,
      secondaryMuscleGroups: Value(_encodeList(seed.secondaryMuscleGroups)),
      movementPattern: Value(seed.movementPattern),
      equipmentType: seed.equipmentType,
      exerciseCategory: Value(seed.exerciseCategory),
      isBodyweight: Value(seed.isBodyweight),
      isUnilateral: Value(seed.isUnilateral),
      defaultIncrementKg: Value(seed.defaultIncrementKg),
      minimumRecommendedReps: Value(minimumRecommendedRepsForSeed(seed)),
      maximumRecommendedReps: Value(maximumRecommendedRepsForSeed(seed)),
      defaultRestSeconds: Value(defaultRestSecondsForSeed(seed)),
      recommendedSetRangeMin: Value(recommendedSetRangeMinForSeed(seed)),
      recommendedSetRangeMax: Value(recommendedSetRangeMaxForSeed(seed)),
      tags: Value(_encodeList(tagsForSeed(seed))),
      notes: Value(seed.notes),
      isCustom: const Value(false),
      createdAt: now,
      updatedAt: now,
    );
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

  Expression<bool> _profileScope($ExercisesTable t, String? userProfileId) {
    final global = t.userProfileId.isNull();
    return userProfileId == null
        ? global
        : global | t.userProfileId.equals(userProfileId);
  }

  @override
  Future<List<Exercise>> listByDayType(
    DayType dayType, {
    String? userProfileId,
  }) async {
    final rows = await (_db.select(_db.exercises)
          ..where(
            (t) => t.dayType.equalsValue(dayType) & _profileScope(t, userProfileId),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return Future.wait(rows.map(_mapWithTargets));
  }

  @override
  Future<List<Exercise>> listAll({String? userProfileId}) async {
    final rows = await (_db.select(_db.exercises)
          ..where((t) => _profileScope(t, userProfileId))
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
    await _validateCustomExercise(exercise);
    await _db.into(_db.exercises).insertOnConflictUpdate(
          ExercisesCompanion.insert(
            id: exercise.id,
            name: exercise.name.trim(),
            userProfileId: Value(exercise.userProfileId),
            dayType: Value(exercise.dayType ?? DayType.push),
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
    await _replaceTargets(exercise);
    return exercise;
  }

  @override
  Future<bool> nameExists(
    String name, {
    String? userProfileId,
    String? excludingId,
  }) async {
    final normalized = name.trim().toLowerCase();
    if (normalized.isEmpty) return false;
    final rows = await (_db.select(_db.exercises)
          ..where((t) => _profileScope(t, userProfileId)))
        .get();
    return rows.any(
      (row) =>
          row.name.trim().toLowerCase() == normalized && row.id != excludingId,
    );
  }

  @override
  Future<Exercise> updateCustom(Exercise exercise) async {
    final existing = await (_db.select(_db.exercises)
          ..where((t) => t.id.equals(exercise.id) & t.isCustom.equals(true)))
        .getSingleOrNull();
    if (existing == null) {
      throw StateError('Custom exercise not found.');
    }

    await _validateCustomExercise(exercise, excludingId: exercise.id);
    await (_db.update(_db.exercises)..where((t) => t.id.equals(exercise.id)))
        .write(
      ExercisesCompanion(
        name: Value(exercise.name.trim()),
        userProfileId: Value(exercise.userProfileId),
        dayType: Value(exercise.dayType),
        primaryMuscleGroup: Value(exercise.primaryMuscleGroup),
        secondaryMuscleGroups:
            Value(_encodeList(exercise.secondaryMuscleGroups)),
        tags: Value(_encodeList(exercise.tags)),
        movementPattern: Value(exercise.movementPattern),
        equipmentType: Value(exercise.equipmentType),
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
        updatedAt: Value(exercise.updatedAt),
      ),
    );
    await _replaceTargets(exercise);
    return exercise;
  }

  @override
  Future<void> deleteCustom(String id) async {
    await (_db.delete(_db.exerciseMuscleTargets)
          ..where((t) => t.exerciseId.equals(id)))
        .go();
    await (_db.delete(_db.exercises)
          ..where((t) => t.id.equals(id) & t.isCustom.equals(true)))
        .go();
  }

  Future<void> _validateCustomExercise(
    Exercise exercise, {
    String? excludingId,
  }) async {
    if (exercise.name.trim().isEmpty) {
      throw ArgumentError.value(exercise.name, 'name', 'Name cannot be empty.');
    }
    final duplicate = await nameExists(
      exercise.name,
      userProfileId: exercise.userProfileId,
      excludingId: excludingId,
    );
    if (duplicate) {
      throw StateError('Exercise name already exists for this profile.');
    }
  }

  Future<void> _replaceTargets(Exercise exercise) async {
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
  }
}
