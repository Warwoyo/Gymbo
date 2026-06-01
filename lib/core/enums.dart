// Shared domain enums used across features.

/// The three supported workout day types.
enum DayType {
  push,
  pull,
  leg;

  String get label {
    switch (this) {
      case DayType.push:
        return 'Push Day';
      case DayType.pull:
        return 'Pull Day';
      case DayType.leg:
        return 'Leg Day';
    }
  }
}

/// Equipment categories found in a typical commercial gym.
enum EquipmentType {
  barbell,
  dumbbell,
  cable,
  machine,
  smithMachine,
  bodyweight,
  plateLoaded,
  resistanceBand,
  kettlebell,
  other;

  String get label {
    switch (this) {
      case EquipmentType.barbell:
        return 'Barbell';
      case EquipmentType.dumbbell:
        return 'Dumbbell';
      case EquipmentType.cable:
        return 'Cable';
      case EquipmentType.machine:
        return 'Machine';
      case EquipmentType.smithMachine:
        return 'Smith Machine';
      case EquipmentType.bodyweight:
        return 'Bodyweight';
      case EquipmentType.plateLoaded:
        return 'Plate Loaded Machine';
      case EquipmentType.resistanceBand:
        return 'Resistance Band';
      case EquipmentType.kettlebell:
        return 'Kettlebell';
      case EquipmentType.other:
        return 'Other';
    }
  }

  /// Default load increment in kg for this equipment type.
  bool get isFreeWeightDumbbell => this == EquipmentType.dumbbell;
}

/// Primary training goal selected on the profile.
enum TrainingGoal {
  strength,
  hypertrophy,
  muscularEndurance,
  generalFitness;

  String get label {
    switch (this) {
      case TrainingGoal.strength:
        return 'Strength';
      case TrainingGoal.hypertrophy:
        return 'Hypertrophy';
      case TrainingGoal.muscularEndurance:
        return 'Muscular Endurance';
      case TrainingGoal.generalFitness:
        return 'General Fitness';
    }
  }
}

/// Self-reported training experience.
enum TrainingExperience {
  beginner,
  intermediate,
  advanced;

  String get label {
    switch (this) {
      case TrainingExperience.beginner:
        return 'Beginner';
      case TrainingExperience.intermediate:
        return 'Intermediate';
      case TrainingExperience.advanced:
        return 'Advanced';
    }
  }
}

/// Lifecycle states of a workout session.
enum WorkoutSessionStatus {
  notStarted,
  active,
  resting,
  paused,
  completed,
  autoCompleted,
  abandoned;

  bool get isOpen =>
      this == WorkoutSessionStatus.active ||
      this == WorkoutSessionStatus.resting ||
      this == WorkoutSessionStatus.paused;

  bool get isFinished =>
      this == WorkoutSessionStatus.completed ||
      this == WorkoutSessionStatus.autoCompleted ||
      this == WorkoutSessionStatus.abandoned;

  String get label {
    switch (this) {
      case WorkoutSessionStatus.notStarted:
        return 'Not started';
      case WorkoutSessionStatus.active:
        return 'Active';
      case WorkoutSessionStatus.resting:
        return 'Resting';
      case WorkoutSessionStatus.paused:
        return 'Paused';
      case WorkoutSessionStatus.completed:
        return 'Completed';
      case WorkoutSessionStatus.autoCompleted:
        return 'Auto-completed';
      case WorkoutSessionStatus.abandoned:
        return 'Abandoned';
    }
  }
}
