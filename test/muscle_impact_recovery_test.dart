import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/features/exercise_catalog/domain/exercise.dart';
import 'package:gymbo/features/muscle/domain/muscle_impact_calculator.dart';
import 'package:gymbo/features/muscle/domain/muscle_target.dart';
import 'package:gymbo/features/muscle/domain/recovery_calculator.dart';
import 'package:gymbo/features/workout/domain/workout_set.dart';

void main() {
  final now = DateTime(2026, 6, 2, 12);

  WorkoutSet set(int n, double kg, int reps, {bool warmup = false}) =>
      WorkoutSet(
        id: 's$n',
        workoutExerciseId: 'we',
        setNumber: n,
        weightKg: kg,
        reps: reps,
        isWarmup: warmup,
        createdAt: now,
        updatedAt: now,
      );

  Exercise exercise(String name, List<MuscleTarget> targets) => Exercise(
        id: name,
        name: name,
        primaryMuscleGroup: 'Test',
        movementPattern: 'Test',
        equipmentType: EquipmentType.dumbbell,
        exerciseCategory: ExerciseCategory.compoundUpper,
        isBodyweight: false,
        isUnilateral: false,
        muscleTargets: targets,
        createdAt: now,
        updatedAt: now,
      );

  test('bench press impact makes chest primary highest and normalized to 100', () {
    final bench = exercise('Dumbbell Bench Press', [
      MuscleTarget(muscle: MuscleGroup.chest, role: MuscleRole.primary),
      MuscleTarget(muscle: MuscleGroup.shoulders, role: MuscleRole.secondary),
      MuscleTarget(muscle: MuscleGroup.triceps, role: MuscleRole.secondary),
    ]);
    final impacts = const MuscleImpactCalculator().calculate([
      ExerciseSetInput(exercise: bench, sets: [set(1, 20, 10), set(2, 20, 10), set(3, 20, 8)]),
    ]);
    final by = {for (final i in impacts) i.muscle: i};
    expect(by[MuscleGroup.chest]!.rawScore, greaterThan(by[MuscleGroup.shoulders]!.rawScore));
    expect(by[MuscleGroup.chest]!.rawScore, greaterThan(by[MuscleGroup.triceps]!.rawScore));
    expect(by[MuscleGroup.shoulders]!.rawScore, closeTo(by[MuscleGroup.triceps]!.rawScore, 0.001));
    expect(by[MuscleGroup.chest]!.normalizedScore, closeTo(100, 0.001));
  });

  test('machine row impact makes back highest with biceps and traps secondary', () {
    final row = exercise('Machine Row', [
      MuscleTarget(muscle: MuscleGroup.back, role: MuscleRole.primary),
      MuscleTarget(muscle: MuscleGroup.biceps, role: MuscleRole.secondary),
      MuscleTarget(muscle: MuscleGroup.traps, role: MuscleRole.secondary),
    ]);
    final impacts = const MuscleImpactCalculator().calculate([
      ExerciseSetInput(exercise: row, sets: [set(1, 40, 10)]),
    ]);
    final by = {for (final i in impacts) i.muscle: i};
    expect(by[MuscleGroup.back]!.rawScore, greaterThan(by[MuscleGroup.biceps]!.rawScore));
    expect(by[MuscleGroup.biceps]!.rawScore, greaterThan(0));
    expect(by[MuscleGroup.traps]!.rawScore, greaterThan(0));
  });

  test('warmup discount contributes less than working set', () {
    final bench = exercise('Bench', [
      MuscleTarget(muscle: MuscleGroup.chest, role: MuscleRole.primary),
    ]);
    final warm = const MuscleImpactCalculator().calculate([
      ExerciseSetInput(exercise: bench, sets: [set(1, 20, 10, warmup: true)]),
    ]).single.rawScore;
    final working = const MuscleImpactCalculator().calculate([
      ExerciseSetInput(exercise: bench, sets: [set(1, 20, 10)]),
    ]).single.rawScore;
    expect(warm, lessThan(working));
  });

  test('recovery decay halves remaining strain by half-life', () {
    final calc = const RecoveryCalculator();
    expect(calc.remainingStrain(impactScore: 80, workoutEndedAt: now.subtract(const Duration(hours: 48)), now: now, halfLifeHours: 48), closeTo(40, 0.01));
    expect(calc.remainingStrain(impactScore: 80, workoutEndedAt: now.subtract(const Duration(hours: 96)), now: now, halfLifeHours: 48), closeTo(20, 0.01));
  });

  test('recovery level thresholds', () {
    final calc = const RecoveryCalculator();
    expect(calc.levelFor(85), RecoveryLevel.recovered);
    expect(calc.levelFor(65), RecoveryLevel.lightFatigue);
    expect(calc.levelFor(45), RecoveryLevel.moderateFatigue);
    expect(calc.levelFor(20), RecoveryLevel.fatigued);
  });
}
