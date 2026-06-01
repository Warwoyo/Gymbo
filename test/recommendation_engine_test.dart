import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/core/utils/rounding.dart';
import 'package:gymbo/features/recommendations/domain/goal_profile.dart';
import 'package:gymbo/features/recommendations/domain/recommendation_engine.dart';

void main() {
  const engine = RecommendationEngine();

  group('Epley e1RM', () {
    test('60kg x 8 reps = 76kg', () {
      expect(engine.estimateOneRepMax(60, 8), closeTo(76.0, 0.0001));
    });

    test('100kg x 1 rep = 100kg', () {
      expect(engine.estimateOneRepMax(100, 1), closeTo(103.333, 0.01));
    });

    test('rejects weight <= 0', () {
      expect(() => engine.estimateOneRepMax(0, 5), throwsArgumentError);
    });

    test('rejects reps out of 1..30', () {
      expect(() => engine.estimateOneRepMax(50, 0), throwsArgumentError);
      expect(() => engine.estimateOneRepMax(50, 31), throwsArgumentError);
    });

    test('flags low reliability above 12 reps', () {
      expect(engine.isLowReliability(13), isTrue);
      expect(engine.isLowReliability(10), isFalse);
    });
  });

  group('Inverse Epley recommended load', () {
    test('e1RM 76, target 10 reps -> 57 raw', () {
      expect(engine.loadForReps(76, 10), closeTo(57.0, 0.0001));
    });

    test('rounded to nearest 2.5kg = 57.5', () {
      final raw = engine.loadForReps(76, 10);
      expect(roundToNearestIncrement(raw, 2.5), 57.5);
    });
  });

  group('roundToNearestIncrement', () {
    test('snaps to 2.5kg', () {
      expect(roundToNearestIncrement(57.0, 2.5), 57.5);
      expect(roundToNearestIncrement(61.2, 2.5), 60.0);
      expect(roundToNearestIncrement(63.8, 2.5), 65.0);
    });

    test('snaps to 1kg', () {
      expect(roundToNearestIncrement(57.4, 1.0), 57.0);
      expect(roundToNearestIncrement(57.6, 1.0), 58.0);
    });

    test('non-positive increment returns value unchanged', () {
      expect(roundToNearestIncrement(57.3, 0), 57.3);
    });
  });

  group('Goal profile mapping', () {
    test('target reps per goal', () {
      expect(GoalProfile.forGoal(TrainingGoal.strength).targetReps, 5);
      expect(GoalProfile.forGoal(TrainingGoal.hypertrophy).targetReps, 10);
      expect(GoalProfile.forGoal(TrainingGoal.muscularEndurance).targetReps, 15);
      expect(GoalProfile.forGoal(TrainingGoal.generalFitness).targetReps, 10);
    });

    test('rep ranges per goal', () {
      final s = GoalProfile.forGoal(TrainingGoal.strength);
      expect([s.minReps, s.maxReps], [3, 6]);
      final h = GoalProfile.forGoal(TrainingGoal.hypertrophy);
      expect([h.minReps, h.maxReps], [6, 12]);
    });
  });

  group('Default rest seconds', () {
    test('per goal', () {
      expect(engine.defaultRestSeconds(TrainingGoal.strength), 180);
      expect(engine.defaultRestSeconds(TrainingGoal.hypertrophy), 90);
      expect(engine.defaultRestSeconds(TrainingGoal.muscularEndurance), 60);
      expect(engine.defaultRestSeconds(TrainingGoal.generalFitness), 90);
    });
  });

  group('Performance adjustment', () {
    test('increase when reps well above upper bound', () {
      final r = engine.adjustForPerformance(
        currentLoadKg: 100,
        completedReps: 14, // upper 12 -> +2 triggers increase
        targetRepLowerBound: 6,
        targetRepUpperBound: 12,
        incrementKg: 2.5,
      );
      expect(r.direction, AdjustmentDirection.increase);
      expect(r.adjustedLoadKg, greaterThan(100));
    });

    test('decrease when reps below lower bound', () {
      final r = engine.adjustForPerformance(
        currentLoadKg: 100,
        completedReps: 4,
        targetRepLowerBound: 6,
        targetRepUpperBound: 12,
        incrementKg: 2.5,
      );
      expect(r.direction, AdjustmentDirection.decrease);
      expect(r.adjustedLoadKg, lessThan(100));
    });

    test('hold when in range', () {
      final r = engine.adjustForPerformance(
        currentLoadKg: 100,
        completedReps: 9,
        targetRepLowerBound: 6,
        targetRepUpperBound: 12,
        incrementKg: 2.5,
      );
      expect(r.direction, AdjustmentDirection.hold);
      expect(r.adjustedLoadKg, 100);
    });
  });

  group('generateRecommendation example (Hypertrophy, 60x8)', () {
    test('matches spec example', () {
      final rec = engine.generateRecommendation(
        exerciseId: 'ex1',
        basedOnSetId: 'set1',
        loggedWeightKg: 60,
        loggedReps: 8,
        goal: TrainingGoal.hypertrophy,
        incrementKg: 2.5,
      );
      expect(rec.estimatedOneRepMaxKg, closeTo(76.0, 0.05));
      expect(rec.targetReps, 10);
      expect(rec.recommendedLoadKg, 57.5);
      expect(rec.restSeconds, 90);
      expect(rec.targetRepRangeMin, 6);
      expect(rec.targetRepRangeMax, 12);
    });
  });
}
