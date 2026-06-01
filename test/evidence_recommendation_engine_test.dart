import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/features/recommendations/domain/evidence_recommendation_engine.dart';

void main() {
  const engine = EvidenceRecommendationEngine();

  EvidenceRecommendation run({
    required ExerciseCategory category,
    TrainingGoal goal = TrainingGoal.hypertrophy,
    required double increment,
    required LoggedSetInput current,
    List<LoggedSetInput> previous = const [],
    RecommendationStyle style = RecommendationStyle.balanced,
  }) {
    return engine.recommend(RecommendationContext(
      category: category,
      goal: goal,
      incrementKg: increment,
      currentSet: current,
      previousWorkingSets: previous,
      style: style,
    ));
  }

  group('Epley', () {
    test('15 kg x 12 -> 21 kg e1RM', () {
      expect(engine.epleyE1rm(15, 12), closeTo(21.0, 0.0001));
    });
  });

  group('Rule A — progressive overload (compound upper)', () {
    test('15 kg x 12 @ RPE8, rest 120 -> 17.5 kg x 8-10, increase_load', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        current: const LoggedSetInput(
            weightKg: 15, reps: 12, rpe: 8, restBeforeSetSeconds: 120),
      );
      expect(r.label, RecommendationLabel.increaseLoad);
      expect(r.recommendedWeightKg, 17.5);
      expect(r.recommendedRepMin, 8);
      expect(r.recommendedRepMax, 10);
    });

    test('continued: 17.5 x 10 (after 15x12) -> 20 x 6-8, increase_load', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        previous: const [LoggedSetInput(weightKg: 15, reps: 12)],
        current: const LoggedSetInput(
            weightKg: 17.5, reps: 10, rpe: 8, restBeforeSetSeconds: 120),
      );
      expect(r.label, RecommendationLabel.increaseLoad);
      expect(r.recommendedWeightKg, 20);
      expect(r.recommendedRepMin, 6);
      expect(r.recommendedRepMax, 8);
    });
  });

  group('Rule B — hold steady within range', () {
    test('17.5 x 8 (target 8-10) -> hold, reps nudge up', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        previous: const [LoggedSetInput(weightKg: 15, reps: 12)],
        current: const LoggedSetInput(
            weightKg: 17.5, reps: 8, rpe: 8, restBeforeSetSeconds: 120),
      );
      expect(r.label, RecommendationLabel.holdSteady);
      expect(r.recommendedWeightKg, 17.5);
      expect(r.recommendedRepMin, 9);
      expect(r.recommendedRepMax, 10);
    });
  });

  group('Rule C — do not increase after failure', () {
    test('15 x 12 failure RPE10 -> hold, same weight', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        current: const LoggedSetInput(
            weightKg: 15, reps: 12, rpe: 10, isFailure: true),
      );
      expect(
        r.label,
        anyOf(RecommendationLabel.holdSteady, RecommendationLabel.reduceLoad),
      );
      expect(r.recommendedWeightKg, lessThanOrEqualTo(15));
    });
  });

  group('Rule D — rest-aware adjustment', () {
    test('15 x 12 RPE8 but only 30s rest -> rest_more, no aggressive increase',
        () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        current: const LoggedSetInput(
            weightKg: 15, reps: 12, rpe: 8, restBeforeSetSeconds: 30),
      );
      expect(r.label, RecommendationLabel.restMore);
      expect(r.recommendedWeightKg, 15);
    });
  });

  group('Rule E — performance drop', () {
    test('two consecutive drops -> finish_exercise', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        previous: const [
          LoggedSetInput(weightKg: 60, reps: 10),
          LoggedSetInput(weightKg: 60, reps: 7),
        ],
        current: const LoggedSetInput(weightKg: 60, reps: 5),
      );
      expect(r.label, RecommendationLabel.finishExercise);
    });
  });

  group('Rule F — isolation guardrail', () {
    test('Lateral Raise 5 x 15 -> ~6 x 10-12, never 7.5 x 6', () {
      final r = run(
        category: ExerciseCategory.isolation,
        increment: 1.0,
        current: const LoggedSetInput(weightKg: 5, reps: 15, rpe: 8),
      );
      expect(r.recommendedWeightKg, 6);
      expect(r.recommendedRepMin, greaterThanOrEqualTo(10));
      // Must not aggressively jump load or drop to very low reps.
      expect(r.recommendedWeightKg, isNot(7.5));
      expect(r.recommendedRepMax, greaterThan(6));
    });
  });

  group('Assisted bodyweight', () {
    test('assistance 30 x 12 -> assistance 25 x 8-10, increase_difficulty', () {
      final r = run(
        category: ExerciseCategory.assistedBodyweight,
        increment: 5.0,
        current: const LoggedSetInput(weightKg: 30, reps: 12, rpe: 8),
      );
      expect(r.label, RecommendationLabel.increaseDifficulty);
      expect(r.recommendedWeightKg, 25); // less assistance
      expect(r.recommendedRepMin, 8);
      expect(r.recommendedRepMax, 10);
    });
  });

  group('Rule G — set guidance', () {
    LoggedSetInput within() =>
        const LoggedSetInput(weightKg: 60, reps: 9, rpe: 8);

    test('1 working set completed -> continue, 2 more', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        current: within(),
      );
      expect(r.completedWorkingSets, 1);
      expect(r.recommendedSetsMin, 3);
      expect(r.recommendedSetsMax, 5);
      expect(r.setsGuidanceMessage, contains('2 more'));
    });

    test('3 working sets -> minimum reached, optional sets', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        previous: [within(), within()],
        current: within(),
      );
      expect(r.completedWorkingSets, 3);
      expect(r.setsGuidanceMessage, contains('optional'));
    });

    test('5 working sets -> recommended max reached, consider finishing', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        previous: [within(), within(), within(), within()],
        current: within(),
      );
      expect(r.completedWorkingSets, 5);
      expect(r.setsGuidanceMessage, contains('finishing'));
    });
  });

  group('Recommendation style', () {
    test('conservative does not progress at RPE 9', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        style: RecommendationStyle.conservative,
        current: const LoggedSetInput(
            weightKg: 60, reps: 12, rpe: 9, restBeforeSetSeconds: 150),
      );
      expect(r.label, isNot(RecommendationLabel.increaseLoad));
    });

    test('aggressive progresses at RPE 9', () {
      final r = run(
        category: ExerciseCategory.compoundUpper,
        increment: 2.5,
        style: RecommendationStyle.aggressive,
        current: const LoggedSetInput(
            weightKg: 60, reps: 12, rpe: 9, restBeforeSetSeconds: 150),
      );
      expect(r.label, RecommendationLabel.increaseLoad);
    });
  });

  group('Performance trend helper', () {
    test('improved', () {
      expect(
        EvidenceRecommendationEngine.trendOf(const [
          LoggedSetInput(weightKg: 50, reps: 8),
          LoggedSetInput(weightKg: 55, reps: 9),
        ]),
        PerformanceTrend.improved,
      );
    });

    test('declined', () {
      expect(
        EvidenceRecommendationEngine.trendOf(const [
          LoggedSetInput(weightKg: 60, reps: 10),
          LoggedSetInput(weightKg: 60, reps: 7),
        ]),
        PerformanceTrend.declined,
      );
    });
  });
}
