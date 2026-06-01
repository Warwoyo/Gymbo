import '../../../core/enums.dart';

/// Default recommendation profile for a [TrainingGoal].
///
/// Encodes the table from the spec (§3 Goal-Based Recommendation Rules):
/// target rep range, target set range, the single "next set" target rep,
/// approximate intensity (% of e1RM) and default rest time.
class GoalProfile {
  const GoalProfile({
    required this.goal,
    required this.minReps,
    required this.maxReps,
    required this.targetReps,
    required this.minSets,
    required this.maxSets,
    required this.minIntensityPct,
    required this.maxIntensityPct,
    required this.minRestSeconds,
    required this.maxRestSeconds,
    required this.defaultRestSeconds,
  });

  final TrainingGoal goal;
  final int minReps;
  final int maxReps;

  /// The single target rep value used to compute the next-set load.
  final int targetReps;
  final int minSets;
  final int maxSets;
  final int minIntensityPct;
  final int maxIntensityPct;
  final int minRestSeconds;
  final int maxRestSeconds;
  final int defaultRestSeconds;

  String get repRangeLabel => '$minReps-$maxReps reps';
  String get setRangeLabel => '$minSets-$maxSets sets';
  String get restRangeLabel => '$minRestSeconds-$maxRestSeconds sec';

  static const Map<TrainingGoal, GoalProfile> _profiles = {
    TrainingGoal.strength: GoalProfile(
      goal: TrainingGoal.strength,
      minReps: 3,
      maxReps: 6,
      targetReps: 5,
      minSets: 3,
      maxSets: 5,
      minIntensityPct: 80,
      maxIntensityPct: 90,
      minRestSeconds: 180,
      maxRestSeconds: 300,
      defaultRestSeconds: 180,
    ),
    TrainingGoal.hypertrophy: GoalProfile(
      goal: TrainingGoal.hypertrophy,
      minReps: 6,
      maxReps: 12,
      targetReps: 10,
      minSets: 3,
      maxSets: 5,
      minIntensityPct: 65,
      maxIntensityPct: 85,
      minRestSeconds: 60,
      maxRestSeconds: 120,
      defaultRestSeconds: 90,
    ),
    TrainingGoal.muscularEndurance: GoalProfile(
      goal: TrainingGoal.muscularEndurance,
      minReps: 12,
      maxReps: 20,
      targetReps: 15,
      minSets: 2,
      maxSets: 4,
      minIntensityPct: 40,
      maxIntensityPct: 65,
      minRestSeconds: 30,
      maxRestSeconds: 90,
      defaultRestSeconds: 60,
    ),
    TrainingGoal.generalFitness: GoalProfile(
      goal: TrainingGoal.generalFitness,
      minReps: 8,
      maxReps: 12,
      targetReps: 10,
      minSets: 2,
      maxSets: 4,
      minIntensityPct: 60,
      maxIntensityPct: 75,
      minRestSeconds: 60,
      maxRestSeconds: 120,
      defaultRestSeconds: 90,
    ),
  };

  static GoalProfile forGoal(TrainingGoal goal) => _profiles[goal]!;
}
