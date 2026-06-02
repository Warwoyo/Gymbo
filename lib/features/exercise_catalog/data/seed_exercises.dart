import '../../../core/enums.dart';
import '../../muscle/domain/muscle_target.dart';

/// A plain seed definition used to populate the exercise catalog on first run.
class SeedExercise {
  const SeedExercise({
    required this.name,
    required this.dayType,
    required this.primaryMuscleGroup,
    this.secondaryMuscleGroups = const [],
    required this.movementPattern,
    required this.equipmentType,
    required this.exerciseCategory,
    this.isBodyweight = false,
    this.isUnilateral = false,
    this.defaultIncrementKg,
    this.muscleTargets = const [],
    this.tags = const [],
    this.notes,
  });

  final String name;
  final DayType dayType;
  final String primaryMuscleGroup;
  final List<String> secondaryMuscleGroups;
  final String movementPattern;
  final EquipmentType equipmentType;
  final ExerciseCategory exerciseCategory;
  final bool isBodyweight;
  final bool isUnilateral;
  final double? defaultIncrementKg;
  final List<MuscleTarget> muscleTargets;
  final List<String> tags;
  final String? notes;
}

/// Generic Push/Pull/Leg seed catalog (no brand or location names).
const List<SeedExercise> kSeedExercises = [
  // ---------------- Push Day ----------------
  SeedExercise(
    name: 'Barbell Bench Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Horizontal Push',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Dumbbell Bench Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Horizontal Push',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Incline Dumbbell Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Upper Chest',
    secondaryMuscleGroups: ['Front Delts', 'Triceps'],
    movementPattern: 'Incline Push',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Machine Chest Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Horizontal Push',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineCompound,
  ),
  SeedExercise(
    name: 'Cable Chest Fly',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    movementPattern: 'Horizontal Adduction',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Pec Deck Fly',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    movementPattern: 'Horizontal Adduction',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
  SeedExercise(
    name: 'Overhead Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Shoulders',
    secondaryMuscleGroups: ['Triceps', 'Upper Chest'],
    movementPattern: 'Vertical Push',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Dumbbell Shoulder Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Shoulders',
    secondaryMuscleGroups: ['Triceps'],
    movementPattern: 'Vertical Push',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Machine Shoulder Press',
    dayType: DayType.push,
    primaryMuscleGroup: 'Shoulders',
    secondaryMuscleGroups: ['Triceps'],
    movementPattern: 'Vertical Push',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineCompound,
  ),
  SeedExercise(
    name: 'Lateral Raise',
    dayType: DayType.push,
    primaryMuscleGroup: 'Side Delts',
    movementPattern: 'Lateral Raise',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.isolation,
    defaultIncrementKg: 1.0,
  ),
  SeedExercise(
    name: 'Cable Lateral Raise',
    dayType: DayType.push,
    primaryMuscleGroup: 'Side Delts',
    movementPattern: 'Lateral Raise',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
    isUnilateral: true,
    defaultIncrementKg: 1.0,
  ),
  SeedExercise(
    name: 'Triceps Pushdown',
    dayType: DayType.push,
    primaryMuscleGroup: 'Triceps',
    movementPattern: 'Elbow Extension',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Overhead Cable Triceps Extension',
    dayType: DayType.push,
    primaryMuscleGroup: 'Triceps',
    movementPattern: 'Elbow Extension',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Dip',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Vertical Push',
    equipmentType: EquipmentType.bodyweight,
    exerciseCategory: ExerciseCategory.bodyweight,
    isBodyweight: true,
  ),
  SeedExercise(
    name: 'Assisted Dip',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Vertical Push',
    equipmentType: EquipmentType.assistedBodyweight,
    exerciseCategory: ExerciseCategory.assistedBodyweight,
    defaultIncrementKg: 5.0,
    notes: 'Weight = assistance. Reduce assistance to progress.',
  ),
  SeedExercise(
    name: 'Push-Up',
    dayType: DayType.push,
    primaryMuscleGroup: 'Chest',
    secondaryMuscleGroups: ['Triceps', 'Front Delts'],
    movementPattern: 'Horizontal Push',
    equipmentType: EquipmentType.bodyweight,
    exerciseCategory: ExerciseCategory.bodyweight,
    isBodyweight: true,
  ),

  // ---------------- Pull Day ----------------
  SeedExercise(
    name: 'Pull-Up',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Lats',
    secondaryMuscleGroups: ['Biceps', 'Upper Back'],
    movementPattern: 'Vertical Pull',
    equipmentType: EquipmentType.bodyweight,
    exerciseCategory: ExerciseCategory.bodyweight,
    isBodyweight: true,
  ),
  SeedExercise(
    name: 'Assisted Pull-Up',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Lats',
    secondaryMuscleGroups: ['Biceps', 'Upper Back'],
    movementPattern: 'Vertical Pull',
    equipmentType: EquipmentType.assistedBodyweight,
    exerciseCategory: ExerciseCategory.assistedBodyweight,
    defaultIncrementKg: 5.0,
    notes: 'Weight = assistance. Reduce assistance to progress.',
  ),
  SeedExercise(
    name: 'Lat Pulldown',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Lats',
    secondaryMuscleGroups: ['Biceps'],
    movementPattern: 'Vertical Pull',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.compoundUpper,
  ),
  SeedExercise(
    name: 'Seated Cable Row',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Mid Back',
    secondaryMuscleGroups: ['Lats', 'Biceps'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.compoundUpper,
  ),
  SeedExercise(
    name: 'Chest-Supported Row',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Mid Back',
    secondaryMuscleGroups: ['Lats', 'Biceps'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineCompound,
  ),
  SeedExercise(
    name: 'Barbell Row',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Mid Back',
    secondaryMuscleGroups: ['Lats', 'Biceps', 'Spinal Erectors'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Dumbbell Row',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Lats',
    secondaryMuscleGroups: ['Mid Back', 'Biceps'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundUpper,
    isUnilateral: true,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Machine Row',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Mid Back',
    secondaryMuscleGroups: ['Lats', 'Biceps'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineCompound,
  ),
  SeedExercise(
    name: 'Face Pull',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Rear Delts',
    secondaryMuscleGroups: ['Upper Back'],
    movementPattern: 'Horizontal Pull',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Rear Delt Fly',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Rear Delts',
    movementPattern: 'Horizontal Abduction',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.isolation,
    defaultIncrementKg: 1.0,
  ),
  SeedExercise(
    name: 'Barbell Curl',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Biceps',
    movementPattern: 'Elbow Flexion',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Dumbbell Curl',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Biceps',
    movementPattern: 'Elbow Flexion',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.isolation,
    defaultIncrementKg: 1.0,
  ),
  SeedExercise(
    name: 'Cable Curl',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Biceps',
    movementPattern: 'Elbow Flexion',
    equipmentType: EquipmentType.cable,
    exerciseCategory: ExerciseCategory.isolation,
  ),
  SeedExercise(
    name: 'Hammer Curl',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Biceps',
    secondaryMuscleGroups: ['Forearms'],
    movementPattern: 'Elbow Flexion',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.isolation,
    defaultIncrementKg: 1.0,
  ),
  SeedExercise(
    name: 'Preacher Curl',
    dayType: DayType.pull,
    primaryMuscleGroup: 'Biceps',
    movementPattern: 'Elbow Flexion',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),

  // ---------------- Leg Day ----------------
  SeedExercise(
    name: 'Back Squat',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes', 'Spinal Erectors'],
    movementPattern: 'Squat',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Front Squat',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes', 'Upper Back'],
    movementPattern: 'Squat',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Smith Machine Squat',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes'],
    movementPattern: 'Squat',
    equipmentType: EquipmentType.smithMachine,
    exerciseCategory: ExerciseCategory.compoundLower,
  ),
  SeedExercise(
    name: 'Leg Press',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes'],
    movementPattern: 'Squat',
    equipmentType: EquipmentType.plateLoaded,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 5.0,
  ),
  SeedExercise(
    name: 'Hack Squat',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes'],
    movementPattern: 'Squat',
    equipmentType: EquipmentType.plateLoaded,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 5.0,
  ),
  SeedExercise(
    name: 'Romanian Deadlift',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Hamstrings',
    secondaryMuscleGroups: ['Glutes', 'Spinal Erectors'],
    movementPattern: 'Hip Hinge',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Deadlift',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Posterior Chain',
    secondaryMuscleGroups: ['Glutes', 'Hamstrings', 'Back'],
    movementPattern: 'Hip Hinge',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Leg Extension',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    movementPattern: 'Knee Extension',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
  SeedExercise(
    name: 'Lying Leg Curl',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Hamstrings',
    movementPattern: 'Knee Flexion',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
  SeedExercise(
    name: 'Seated Leg Curl',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Hamstrings',
    movementPattern: 'Knee Flexion',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
  SeedExercise(
    name: 'Walking Lunge',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes', 'Hamstrings'],
    movementPattern: 'Lunge',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    isUnilateral: true,
    defaultIncrementKg: 2.0,
  ),
  SeedExercise(
    name: 'Bulgarian Split Squat',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Quads',
    secondaryMuscleGroups: ['Glutes'],
    movementPattern: 'Lunge',
    equipmentType: EquipmentType.dumbbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    isUnilateral: true,
    defaultIncrementKg: 2.0,
  ),
  SeedExercise(
    name: 'Hip Thrust',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Glutes',
    secondaryMuscleGroups: ['Hamstrings'],
    movementPattern: 'Hip Extension',
    equipmentType: EquipmentType.barbell,
    exerciseCategory: ExerciseCategory.compoundLower,
    defaultIncrementKg: 2.5,
  ),
  SeedExercise(
    name: 'Standing Calf Raise',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Calves',
    movementPattern: 'Ankle Plantarflexion',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
  SeedExercise(
    name: 'Seated Calf Raise',
    dayType: DayType.leg,
    primaryMuscleGroup: 'Calves',
    movementPattern: 'Ankle Plantarflexion',
    equipmentType: EquipmentType.machine,
    exerciseCategory: ExerciseCategory.machineIsolation,
  ),
];


List<MuscleTarget> muscleTargetsForSeed(SeedExercise seed) {
  final explicit = seed.muscleTargets;
  if (explicit.isNotEmpty) return explicit;
  final targets = <MuscleTarget>[];
  MuscleGroup? map(String value) {
    final v = value.toLowerCase();
    if (v.contains('chest')) return MuscleGroup.chest;
    if (v.contains('triceps')) return MuscleGroup.triceps;
    if (v.contains('biceps')) return MuscleGroup.biceps;
    if (v.contains('forearm')) return MuscleGroup.forearms;
    if (v.contains('shoulder') || v.contains('delt')) return MuscleGroup.shoulders;
    if (v.contains('trap')) return MuscleGroup.traps;
    if (v.contains('lat') || v.contains('back') || v.contains('row')) return MuscleGroup.back;
    if (v.contains('erector') || v.contains('lower back')) return MuscleGroup.lowerBack;
    if (v.contains('quad')) return MuscleGroup.quads;
    if (v.contains('hamstring')) return MuscleGroup.hamstrings;
    if (v.contains('glute')) return MuscleGroup.glutes;
    if (v.contains('calf')) return MuscleGroup.calves;
    if (v.contains('ab') || v.contains('core')) return MuscleGroup.abs;
    if (v.contains('oblique')) return MuscleGroup.obliques;
    if (v.contains('adductor')) return MuscleGroup.hipAdductors;
    if (v.contains('abductor')) return MuscleGroup.hipAbductors;
    if (v.contains('posterior chain')) return MuscleGroup.hamstrings;
    return null;
  }

  void add(MuscleGroup? muscle, MuscleRole role) {
    if (muscle == null) return;
    if (targets.any((t) => t.muscle == muscle)) return;
    targets.add(MuscleTarget(muscle: muscle, role: role));
  }

  add(map(seed.primaryMuscleGroup), MuscleRole.primary);
  for (final secondary in seed.secondaryMuscleGroups) {
    add(map(secondary), MuscleRole.secondary);
  }
  return targets;
}

List<String> tagsForSeed(SeedExercise seed) {
  final tags = <String>{seed.dayType.name};
  if (seed.tags.isNotEmpty) tags.addAll(seed.tags);
  switch (seed.dayType) {
    case DayType.push:
      tags.add('upper');
    case DayType.pull:
      tags.add('upper');
    case DayType.leg:
      tags.add('lower');
  }
  if (seed.exerciseCategory == ExerciseCategory.core) tags.add('core');
  if (seed.isBodyweight) tags.add('bodyweight');
  tags.add(seed.equipmentType.name);
  return tags.toList(growable: false);
}
