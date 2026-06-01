import '../../../core/constants/app_constants.dart';
import '../../../core/enums.dart';
import '../../../core/utils/rounding.dart';
import 'goal_profile.dart';
import 'workout_recommendation.dart';

/// Outcome of a performance-based adjustment for the *next* set.
enum AdjustmentDirection { increase, hold, decrease }

class AdjustmentResult {
  const AdjustmentResult({
    required this.direction,
    required this.adjustedLoadKg,
    required this.factor,
  });

  final AdjustmentDirection direction;
  final double adjustedLoadKg;
  final double factor;
}

/// Pure-Dart implementation of the app's strength-training math.
///
/// This class has no Flutter or database dependencies so it can be unit
/// tested directly. All formulas are taken verbatim from the spec.
class RecommendationEngine {
  const RecommendationEngine();

  /// Epley estimate of one-rep max: `weightKg * (1 + reps / 30)`.
  ///
  /// Throws [ArgumentError] when [weightKg] <= 0 or [reps] is outside 1..30.
  double estimateOneRepMax(double weightKg, int reps) {
    if (weightKg <= 0) {
      throw ArgumentError.value(weightKg, 'weightKg', 'must be greater than 0');
    }
    if (reps < 1 || reps > 30) {
      throw ArgumentError.value(reps, 'reps', 'must be between 1 and 30');
    }
    return weightKg * (1 + reps / 30);
  }

  /// True when the estimate should be flagged as less precise (reps > 12).
  bool isLowReliability(int reps) => reps > 12;

  /// Inverse Epley: load needed to hit [targetReps] given an [e1rm].
  /// `e1rm / (1 + targetReps / 30)`.
  double loadForReps(double e1rm, int targetReps) {
    if (targetReps < 1) {
      throw ArgumentError.value(targetReps, 'targetReps', 'must be >= 1');
    }
    return e1rm / (1 + targetReps / 30);
  }

  /// Default rest seconds for a goal (Strength 180, Hypertrophy 90,
  /// Endurance 60, General Fitness 90).
  int defaultRestSeconds(TrainingGoal goal) =>
      GoalProfile.forGoal(goal).defaultRestSeconds;

  /// Generates a full next-set recommendation from a logged working set.
  ///
  /// [incrementKg] snaps the recommended load to a practical gym increment.
  WorkoutRecommendation generateRecommendation({
    required String exerciseId,
    required String basedOnSetId,
    required double loggedWeightKg,
    required int loggedReps,
    required TrainingGoal goal,
    required double incrementKg,
  }) {
    final profile = GoalProfile.forGoal(goal);
    final e1rm = estimateOneRepMax(loggedWeightKg, loggedReps);

    final rawLoad = loadForReps(e1rm, profile.targetReps);
    final roundedLoad = roundToNearestIncrement(rawLoad, incrementKg);

    // Range: lighter load for the high-rep end, heavier for the low-rep end.
    final minLoad = loadForReps(e1rm, profile.maxReps);
    final maxLoad = loadForReps(e1rm, profile.minReps);

    final reliable = !isLowReliability(loggedReps);
    final explanation = StringBuffer(
      'Based on your logged set and your selected goal.',
    );
    if (!reliable) {
      explanation.write(' Higher-rep estimates may be less precise.');
    }

    return WorkoutRecommendation(
      exerciseId: exerciseId,
      basedOnSetId: basedOnSetId,
      estimatedOneRepMaxKg: roundTo(e1rm, 1),
      targetReps: profile.targetReps,
      targetRepRangeMin: profile.minReps,
      targetRepRangeMax: profile.maxReps,
      targetSetsMin: profile.minSets,
      targetSetsMax: profile.maxSets,
      recommendedLoadKg: roundedLoad,
      recommendedLoadRangeMinKg: roundToNearestIncrement(minLoad, incrementKg),
      recommendedLoadRangeMaxKg: roundToNearestIncrement(maxLoad, incrementKg),
      restSeconds: profile.defaultRestSeconds,
      explanation: explanation.toString(),
      lowReliability: !reliable,
    );
  }

  /// Adjusts the next set's load based on how the last set actually went
  /// (spec §4). [currentLoadKg] is the load just used.
  ///
  /// - reps >= upper + 2  -> increase (5% if reps >= upper+4, else 2.5%)
  /// - reps < lower       -> decrease (10% if reps <= lower-3, else 5%)
  /// - otherwise          -> hold
  AdjustmentResult adjustForPerformance({
    required double currentLoadKg,
    required int completedReps,
    required int targetRepLowerBound,
    required int targetRepUpperBound,
    required double incrementKg,
  }) {
    double factor;
    AdjustmentDirection direction;

    if (completedReps >= targetRepUpperBound + 2) {
      direction = AdjustmentDirection.increase;
      factor = completedReps >= targetRepUpperBound + 4
          ? AppConstants.largeIncreaseFactor
          : AppConstants.increaseFactor;
    } else if (completedReps < targetRepLowerBound) {
      direction = AdjustmentDirection.decrease;
      factor = completedReps <= targetRepLowerBound - 3
          ? AppConstants.largeDecreaseFactor
          : AppConstants.smallDecreaseFactor;
    } else {
      direction = AdjustmentDirection.hold;
      factor = 1.0;
    }

    final adjusted = roundToNearestIncrement(currentLoadKg * factor, incrementKg);
    return AdjustmentResult(
      direction: direction,
      adjustedLoadKg: adjusted,
      factor: factor,
    );
  }
}
