import '../../../core/enums.dart';

class MuscleTarget {
  MuscleTarget({
    required this.muscle,
    required this.role,
    double? contribution,
  }) : contribution = contribution ?? role.defaultContribution;

  final MuscleGroup muscle;
  final MuscleRole role;

  /// Heuristic multiplier used for muscle impact scoring, not an exact measure.
  final double contribution;
}
