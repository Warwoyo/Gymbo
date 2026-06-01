import '../../../core/enums.dart';
import 'recommendation_engine.dart';
import 'workout_recommendation.dart';

/// Calculates an Epley estimated 1RM for a logged set.
class CalculateEstimatedOneRepMax {
  const CalculateEstimatedOneRepMax(this._engine);
  final RecommendationEngine _engine;

  double call({required double weightKg, required int reps}) =>
      _engine.estimateOneRepMax(weightKg, reps);
}

/// Generates the next-set recommendation from a logged working set.
class GenerateNextSetRecommendation {
  const GenerateNextSetRecommendation(this._engine);
  final RecommendationEngine _engine;

  WorkoutRecommendation call({
    required String exerciseId,
    required String basedOnSetId,
    required double loggedWeightKg,
    required int loggedReps,
    required TrainingGoal goal,
    required double incrementKg,
  }) {
    return _engine.generateRecommendation(
      exerciseId: exerciseId,
      basedOnSetId: basedOnSetId,
      loggedWeightKg: loggedWeightKg,
      loggedReps: loggedReps,
      goal: goal,
      incrementKg: incrementKg,
    );
  }
}
