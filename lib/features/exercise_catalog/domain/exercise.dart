import '../../../core/enums.dart';
import '../../muscle/domain/muscle_target.dart';
import '../../recommendations/domain/category_defaults.dart';

/// A catalog exercise. Seeded generically and extensible by the user.
class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    this.dayType,
    required this.primaryMuscleGroup,
    this.secondaryMuscleGroups = const [],
    this.tags = const [],
    this.muscleTargets = const [],
    required this.movementPattern,
    required this.equipmentType,
    required this.exerciseCategory,
    required this.isBodyweight,
    required this.isUnilateral,
    this.defaultIncrementKg,
    this.minimumRecommendedReps,
    this.maximumRecommendedReps,
    this.defaultRestSeconds,
    this.recommendedSetRangeMin,
    this.recommendedSetRangeMax,
    this.notes,
    this.isCustom = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final DayType? dayType;
  final String primaryMuscleGroup;
  final List<String> secondaryMuscleGroups;
  final List<String> tags;
  final List<MuscleTarget> muscleTargets;
  final String movementPattern;
  final EquipmentType equipmentType;
  final ExerciseCategory exerciseCategory;
  final bool isBodyweight;
  final bool isUnilateral;

  /// Per-exercise overrides; when null, category defaults are used.
  final double? defaultIncrementKg;
  final int? minimumRecommendedReps;
  final int? maximumRecommendedReps;
  final int? defaultRestSeconds;
  final int? recommendedSetRangeMin;
  final int? recommendedSetRangeMax;

  final String? notes;
  final bool isCustom;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Effective increment (kg), falling back to the category default.
  double incrementKg([double? profileDefault]) =>
      defaultIncrementKg ??
      profileDefault ??
      CategoryDefaults.defaultIncrement(exerciseCategory);
}
