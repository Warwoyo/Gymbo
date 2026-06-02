import 'dart:math' as math;

import 'muscle_recovery.dart';
import 'recovery_calculator.dart';

/// Estimates time until a muscle reaches ~80% recovery (strain <= 20), using
/// the same region half-lives as [RecoveryCalculator]. This is an estimate,
/// not a guarantee — UI copy must say "estimated".
class RecoveryEstimate {
  const RecoveryEstimate([this.calculator = const RecoveryCalculator()]);

  final RecoveryCalculator calculator;

  static const double _targetStrain = 20;

  Duration timeToRecovered(MuscleRecoveryState state) {
    final strain = state.currentStrain;
    if (strain <= _targetStrain) return Duration.zero;
    final halfLife = calculator.getRecoveryHalfLifeHours(
      state.muscle,
      state.region,
      strain,
      false,
    );
    final hours = halfLife * math.log(strain / _targetStrain) / math.ln2;
    return Duration(minutes: (hours * 60).round());
  }

  /// Human label: "Ready", "~6h", "~1d 4h".
  static String label(Duration d) {
    if (d <= Duration.zero) return 'Ready';
    final days = d.inDays;
    final hours = d.inHours % 24;
    if (days > 0) return hours > 0 ? '~${days}d ${hours}h' : '~${days}d';
    if (d.inHours > 0) return '~${d.inHours}h';
    return '~${d.inMinutes}m';
  }
}
