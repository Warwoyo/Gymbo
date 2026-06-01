import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums.dart';
import '../../../data/db/app_database.dart';
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
    if (await count() > 0) return;
    final now = DateTime.now();
    await _db.batch((b) {
      for (final s in kSeedExercises) {
        b.insert(
          _db.exercises,
          ExercisesCompanion.insert(
            id: _uuid.v4(),
            name: s.name,
            dayType: s.dayType,
            primaryMuscleGroup: s.primaryMuscleGroup,
            secondaryMuscleGroups:
                Value(_encodeList(s.secondaryMuscleGroups)),
            movementPattern: Value(s.movementPattern),
            equipmentType: s.equipmentType,
            exerciseCategory: Value(s.exerciseCategory),
            isBodyweight: Value(s.isBodyweight),
            isUnilateral: Value(s.isUnilateral),
            defaultIncrementKg: Value(s.defaultIncrementKg),
            notes: Value(s.notes),
            isCustom: const Value(false),
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    });
  }

  @override
  Future<List<Exercise>> listByDayType(DayType dayType) async {
    final rows = await (_db.select(_db.exercises)
          ..where((t) => t.dayType.equalsValue(dayType))
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return rows.map(_map).toList();
  }

  @override
  Future<Exercise?> getById(String id) async {
    final row = await (_db.select(_db.exercises)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _map(row);
  }

  @override
  Future<Exercise> createCustom(Exercise exercise) async {
    await _db.into(_db.exercises).insertOnConflictUpdate(
          ExercisesCompanion.insert(
            id: exercise.id,
            name: exercise.name,
            dayType: exercise.dayType,
            primaryMuscleGroup: exercise.primaryMuscleGroup,
            secondaryMuscleGroups:
                Value(_encodeList(exercise.secondaryMuscleGroups)),
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
    return exercise;
  }
}
