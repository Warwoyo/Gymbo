import '../../../core/enums.dart';

/// Evidence-informed defaults for an exercise [ExerciseCategory] + [TrainingGoal].
///
/// These are heuristics, not guarantees. They define target rep ranges,
/// working-set ranges, rest windows and the minimum rest considered
/// "effective" before the engine will recommend progressing load.
class CategorySpec {
  const CategorySpec({
    required this.repMin,
    required this.repMax,
    required this.setsMin,
    required this.setsMax,
    required this.restMin,
    required this.restMax,
  });

  final int repMin;
  final int repMax;
  final int setsMin;
  final int setsMax;
  final int restMin;
  final int restMax;

  /// Representative rest used when auto-starting the timer.
  int get defaultRestSeconds => ((restMin + restMax) / 2).round();

  /// Rest below this (for the category) is treated as "too short to progress".
  int get minimumEffectiveRest => restMin;
}

class CategoryDefaults {
  CategoryDefaults._();

  /// Look up the spec for a category + goal, falling back sensibly.
  static CategorySpec of(ExerciseCategory category, TrainingGoal goal) {
    final byGoal = _table[category];
    if (byGoal == null) return _fallback(goal);
    return byGoal[goal] ?? byGoal[TrainingGoal.hypertrophy] ?? _fallback(goal);
  }

  static CategorySpec _fallback(TrainingGoal goal) {
    switch (goal) {
      case TrainingGoal.strength:
        return const CategorySpec(
            repMin: 3, repMax: 6, setsMin: 3, setsMax: 5, restMin: 150, restMax: 240);
      case TrainingGoal.muscularEndurance:
        return const CategorySpec(
            repMin: 12, repMax: 20, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90);
      case TrainingGoal.hypertrophy:
      case TrainingGoal.generalFitness:
        return const CategorySpec(
            repMin: 8, repMax: 12, setsMin: 3, setsMax: 4, restMin: 60, restMax: 120);
    }
  }

  static const Map<ExerciseCategory, Map<TrainingGoal, CategorySpec>> _table = {
    ExerciseCategory.compoundUpper: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 6, repMax: 12, setsMin: 3, setsMax: 5, restMin: 90, restMax: 150),
      TrainingGoal.strength: CategorySpec(
          repMin: 3, repMax: 6, setsMin: 3, setsMax: 5, restMin: 150, restMax: 240),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 12, repMax: 20, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 8, repMax: 12, setsMin: 3, setsMax: 4, restMin: 90, restMax: 120),
    },
    ExerciseCategory.compoundLower: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 6, repMax: 12, setsMin: 3, setsMax: 5, restMin: 120, restMax: 180),
      TrainingGoal.strength: CategorySpec(
          repMin: 3, repMax: 6, setsMin: 3, setsMax: 5, restMin: 180, restMax: 300),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 12, repMax: 20, setsMin: 2, setsMax: 4, restMin: 60, restMax: 120),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 8, repMax: 12, setsMin: 3, setsMax: 4, restMin: 120, restMax: 180),
    },
    ExerciseCategory.isolation: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 10, repMax: 15, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.strength: CategorySpec(
          repMin: 6, repMax: 10, setsMin: 2, setsMax: 4, restMin: 60, restMax: 120),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 15, repMax: 25, setsMin: 2, setsMax: 4, restMin: 30, restMax: 75),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 10, repMax: 15, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
    },
    ExerciseCategory.machineCompound: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 8, repMax: 15, setsMin: 3, setsMax: 5, restMin: 75, restMax: 150),
      TrainingGoal.strength: CategorySpec(
          repMin: 5, repMax: 8, setsMin: 3, setsMax: 5, restMin: 120, restMax: 180),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 12, repMax: 20, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 8, repMax: 15, setsMin: 3, setsMax: 4, restMin: 75, restMax: 150),
    },
    ExerciseCategory.machineIsolation: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 10, repMax: 15, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.strength: CategorySpec(
          repMin: 8, repMax: 12, setsMin: 2, setsMax: 4, restMin: 60, restMax: 120),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 15, repMax: 25, setsMin: 2, setsMax: 4, restMin: 30, restMax: 75),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 10, repMax: 15, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
    },
    ExerciseCategory.bodyweight: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 8, repMax: 15, setsMin: 3, setsMax: 5, restMin: 90, restMax: 150),
      TrainingGoal.strength: CategorySpec(
          repMin: 5, repMax: 8, setsMin: 3, setsMax: 5, restMin: 120, restMax: 180),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 15, repMax: 25, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 8, repMax: 15, setsMin: 3, setsMax: 4, restMin: 90, restMax: 150),
    },
    ExerciseCategory.assistedBodyweight: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 6, repMax: 12, setsMin: 3, setsMax: 5, restMin: 90, restMax: 150),
      TrainingGoal.strength: CategorySpec(
          repMin: 4, repMax: 8, setsMin: 3, setsMax: 5, restMin: 120, restMax: 180),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 12, repMax: 20, setsMin: 2, setsMax: 4, restMin: 60, restMax: 120),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 6, repMax: 12, setsMin: 3, setsMax: 4, restMin: 90, restMax: 150),
    },
    ExerciseCategory.core: {
      TrainingGoal.hypertrophy: CategorySpec(
          repMin: 10, repMax: 20, setsMin: 2, setsMax: 4, restMin: 30, restMax: 75),
      TrainingGoal.strength: CategorySpec(
          repMin: 8, repMax: 15, setsMin: 2, setsMax: 4, restMin: 45, restMax: 90),
      TrainingGoal.muscularEndurance: CategorySpec(
          repMin: 15, repMax: 25, setsMin: 2, setsMax: 4, restMin: 30, restMax: 60),
      TrainingGoal.generalFitness: CategorySpec(
          repMin: 10, repMax: 20, setsMin: 2, setsMax: 4, restMin: 30, restMax: 75),
    },
  };

  /// Sensible default load increment (kg) for a category, used when an
  /// exercise has no explicit increment.
  static double defaultIncrement(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.compoundUpper:
      case ExerciseCategory.compoundLower:
        return 2.5;
      case ExerciseCategory.isolation:
        return 1.0;
      case ExerciseCategory.machineCompound:
      case ExerciseCategory.machineIsolation:
        return 2.5;
      case ExerciseCategory.bodyweight:
        return 2.5;
      case ExerciseCategory.assistedBodyweight:
        return 5.0;
      case ExerciseCategory.core:
        return 2.5;
    }
  }
}
