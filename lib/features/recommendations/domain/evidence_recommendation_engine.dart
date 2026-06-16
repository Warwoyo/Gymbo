import '../../../core/enums.dart';
import '../../workout/domain/workout_set.dart';
import '../../../core/utils/rounding.dart';
import 'category_defaults.dart';

/// Result label describing what to do for the next set.
enum RecommendationLabel {
  increaseLoad,
  increaseDifficulty, // assisted exercises: reduce assistance
  holdSteady,
  reduceLoad,
  restMore,
  deloadSuggested,
  finishExercise;

  String get label {
    switch (this) {
      case RecommendationLabel.increaseLoad:
        return 'Increase load';
      case RecommendationLabel.increaseDifficulty:
        return 'Increase difficulty';
      case RecommendationLabel.holdSteady:
        return 'Hold steady';
      case RecommendationLabel.reduceLoad:
        return 'Reduce load';
      case RecommendationLabel.restMore:
        return 'Rest more';
      case RecommendationLabel.deloadSuggested:
        return 'Deload suggested';
      case RecommendationLabel.finishExercise:
        return 'Finish exercise';
    }
  }
}

enum RecommendationConfidence { low, medium, high }

/// A logged set as seen by the recommendation engine (decoupled from the DB).
class LoggedSetInput {
  const LoggedSetInput({
    required this.weightKg,
    required this.reps,
    this.rpe,
    this.rir,
    this.isFailure = false,
    this.isWarmup = false,
    this.restBeforeSetSeconds,
    this.loadType = WorkoutSetLoadType.externalLoad,
  });

  final double weightKg;
  final int reps;
  final double? rpe;
  final int? rir;
  final bool isFailure;
  final bool isWarmup;
  final int? restBeforeSetSeconds;
  final WorkoutSetLoadType loadType;

  double get performanceScore => weightKg * reps;
}

/// Everything the engine needs to make a recommendation.
class RecommendationContext {
  const RecommendationContext({
    required this.category,
    required this.goal,
    required this.incrementKg,
    required this.currentSet,
    this.previousWorkingSets = const [],
    this.style = RecommendationStyle.balanced,
    this.primaryMuscleRecoveryPercent,
  });

  final ExerciseCategory category;
  final TrainingGoal goal;
  final double incrementKg;
  final LoggedSetInput currentSet;

  /// Earlier *working* sets for this exercise in the current session,
  /// in chronological order (warm-ups excluded).
  final List<LoggedSetInput> previousWorkingSets;
  final RecommendationStyle style;

  /// Lowest estimated recovery percent across primary target muscles, if known.
  final double? primaryMuscleRecoveryPercent;
}

/// The engine's recommendation for the next set + set-count guidance.
class EvidenceRecommendation {
  const EvidenceRecommendation({
    required this.recommendedWeightKg,
    required this.recommendedRepMin,
    required this.recommendedRepMax,
    required this.recommendedSetsMin,
    required this.recommendedSetsMax,
    required this.recommendedRestSeconds,
    required this.restRangeMinSeconds,
    required this.restRangeMaxSeconds,
    required this.label,
    required this.explanation,
    required this.confidence,
    required this.estimatedOneRmKg,
    required this.completedWorkingSets,
    required this.setsGuidanceMessage,
    this.warnings = const [],
    this.evidenceLabel = 'Evidence-informed heuristic',
  });

  final double recommendedWeightKg;
  final int recommendedRepMin;
  final int recommendedRepMax;
  final int recommendedSetsMin;
  final int recommendedSetsMax;
  final int recommendedRestSeconds;
  final int restRangeMinSeconds;
  final int restRangeMaxSeconds;
  final RecommendationLabel label;
  final String explanation;
  final RecommendationConfidence confidence;
  final double estimatedOneRmKg;
  final int completedWorkingSets;
  final String setsGuidanceMessage;
  final List<String> warnings;
  final String evidenceLabel;

  String get repRangeLabel => recommendedRepMin == recommendedRepMax
      ? '$recommendedRepMin reps'
      : '$recommendedRepMin–$recommendedRepMax reps';
}

/// Evidence-informed, autoregulated progressive-overload engine.
///
/// Pure Dart — no Flutter/DB deps — so all decision rules are unit testable.
class EvidenceRecommendationEngine {
  const EvidenceRecommendationEngine();

  double epleyE1rm(double weightKg, int reps) {
    if (weightKg <= 0 || reps < 1 || reps > 30) return 0;
    return weightKg * (1 + reps / 30);
  }

  int _clampInt(int v, int lo, int hi) => v < lo ? lo : (v > hi ? hi : v);

  EvidenceRecommendation recommend(RecommendationContext ctx) {
    final spec = CategoryDefaults.of(ctx.category, ctx.goal);
    final cur = ctx.currentSet;
    final increment = ctx.incrementKg <= 0 ? 1.0 : ctx.incrementKg;
    final isAssisted = cur.loadType == WorkoutSetLoadType.assistance ||
        ctx.category.isAssisted;
    final isIsolation = ctx.category.isIsolation;
    final e1rm = epleyE1rm(cur.weightKg, cur.reps);

    final prev =
        ctx.previousWorkingSets.isNotEmpty ? ctx.previousWorkingSets.last : null;

    // 1) Effective target range for the *current* load.
    int effMin = spec.repMin;
    int effMax = spec.repMax;
    final progressedFromPrev = prev != null &&
        (isAssisted
            ? cur.weightKg < prev.weightKg
            : cur.weightKg > prev.weightKg);
    if (progressedFromPrev) {
      effMax = _clampInt(prev.reps - 2, spec.repMin, spec.repMax);
      effMin = _clampInt(prev.reps - 4, spec.repMin, effMax);
    }

    // 2) Effort gates (style dependent) + high-effort detection.
    final highEffort = cur.isFailure ||
        (cur.rpe != null && cur.rpe! >= 9.5) ||
        (cur.rir != null && cur.rir == 0);
    final effortAllowsProgress = _effortAllowsProgress(ctx.style, cur);

    // 3) Rest adequacy.
    final restKnown = cur.restBeforeSetSeconds != null;
    final restAdequate =
        !restKnown || cur.restBeforeSetSeconds! >= spec.minimumEffectiveRest;

    // 4) Performance drop detection across working sets.
    final drops = _consecutiveDrops(ctx.previousWorkingSets, cur, isAssisted);

    // ---- Decision tree ----
    var label = RecommendationLabel.holdSteady;
    var recWeight = cur.weightKg;
    var repMin = effMin;
    var repMax = effMax;
    final warnings = <String>[];
    String explanation;
    final lowRecovery = ctx.primaryMuscleRecoveryPercent != null && ctx.primaryMuscleRecoveryPercent! < 35;
    final moderateRecovery = ctx.primaryMuscleRecoveryPercent != null && ctx.primaryMuscleRecoveryPercent! >= 35 && ctx.primaryMuscleRecoveryPercent! < 60;

    if (drops >= 2) {
      label = RecommendationLabel.finishExercise;
      explanation =
          'Performance has dropped for two consecutive sets. Consider ending '
          'this exercise to preserve quality.';
      warnings.add('Repeated performance drop detected.');
    } else if (drops == 1) {
      if (restAdequate) {
        label = RecommendationLabel.reduceLoad;
        recWeight = _reduce(cur.weightKg, increment, isAssisted);
        explanation =
            'Your performance dropped noticeably from the previous set, so the '
            'app suggests reducing load slightly.';
      } else {
        label = RecommendationLabel.restMore;
        explanation =
            'Your performance dropped, but your rest was shorter than '
            'recommended. Consider resting longer before the next set.';
        warnings.add('Rest was shorter than recommended.');
      }
    } else if (highEffort) {
      // Rule C: do not increase after failure / very high effort.
      if (cur.reps < effMin) {
        label = RecommendationLabel.reduceLoad;
        recWeight = _reduce(cur.weightKg, increment, isAssisted);
      } else {
        label = RecommendationLabel.holdSteady;
      }
      explanation =
          'You reached high effort/failure, so the app avoids increasing load '
          'immediately. Keep the load and aim to keep form crisp.';
      warnings.add('High effort/failure on the last set.');
    } else if (cur.reps >= effMax) {
      // Top of range reached.
      if (!restAdequate) {
        // Rule D: rest-aware — do not aggressively progress.
        label = RecommendationLabel.restMore;
        explanation =
            'You reached the top of the rep range, but your rest was shorter '
            'than recommended. Try resting longer before increasing load.';
        warnings.add('Rest was shorter than recommended.');
      } else if (effortAllowsProgress) {
        final progressed =
            _afterProgressRange(cur.reps, spec, isIsolation, effMin, effMax);
        repMin = progressed.$1;
        repMax = progressed.$2;
        if (isAssisted) {
          label = RecommendationLabel.increaseDifficulty;
          // Less assistance = harder. Reduce the assistance weight.
          final harder = cur.weightKg - increment;
          recWeight =
              roundToNearestIncrement(harder < 0 ? 0 : harder, increment);
          explanation =
              'You reached the top of the rep range with manageable effort. '
              'The app suggests reducing assistance by one increment and '
              'aiming for $repMin–$repMax reps.';
        } else {
          label = RecommendationLabel.increaseLoad;
          recWeight = roundToNearestIncrement(cur.weightKg + increment, increment);
          explanation =
              'Based on your previous set, you reached the top of the rep range '
              'with manageable effort. The app suggests increasing load by one '
              'increment and aiming for $repMin–$repMax reps.';
        }
      } else {
        label = RecommendationLabel.holdSteady;
        explanation =
            'You reached the top of the range, but effort was high. Hold this '
            'load and aim to repeat it with slightly easier effort first.';
      }
    } else if (cur.reps < effMin) {
      // Too heavy for the range.
      label = RecommendationLabel.reduceLoad;
      recWeight = _reduce(cur.weightKg, increment, isAssisted);
      explanation =
          'Reps were below the target range, so the app suggests reducing load '
          'to stay within $effMin–$effMax reps.';
    } else {
      // Rule B: within range -> hold, nudge reps up.
      label = RecommendationLabel.holdSteady;
      repMin = _clampInt(cur.reps + 1, effMin, effMax);
      repMax = effMax;
      explanation =
          'Your reps are within the target range. Keep the same load and aim '
          'for ${repMin == repMax ? '$repMin' : '$repMin–$repMax'} reps.';
    }

    if (restKnown && !restAdequate && label != RecommendationLabel.restMore) {
      warnings.add('Rest was shorter than recommended for this category.');
    }
    if (lowRecovery) {
      if (label == RecommendationLabel.increaseLoad ||
          label == RecommendationLabel.increaseDifficulty) {
        label = RecommendationLabel.holdSteady;
        recWeight = cur.weightKg;
      }
      warnings.add('Primary target muscles are estimated to be fatigued from recent workouts. Consider longer rest or lighter loading.');
      explanation = 'Estimated recovery for a primary target muscle is low, so the app suggests avoiding an aggressive load jump today.';
    } else if (moderateRecovery) {
      warnings.add('Primary target muscles show moderate likely fatigue, so confidence is lower.');
    }

    // Set-count guidance (Rule G).
    final completed =
        ctx.previousWorkingSets.length + (cur.isWarmup ? 0 : 1);
    final guidance = _setsGuidance(
      completed: completed,
      setsMin: spec.setsMin,
      setsMax: spec.setsMax,
      forceFinish: label == RecommendationLabel.finishExercise,
    );

    // Confidence.
    final hasEffort = cur.rpe != null || cur.rir != null;
    final baseConfidence = (hasEffort && restKnown)
        ? RecommendationConfidence.high
        : (hasEffort || restKnown)
            ? RecommendationConfidence.medium
            : RecommendationConfidence.low;
    final confidence = lowRecovery
        ? RecommendationConfidence.low
        : moderateRecovery && baseConfidence == RecommendationConfidence.high
            ? RecommendationConfidence.medium
            : baseConfidence;

    final restSeconds = label == RecommendationLabel.restMore
        ? spec.restMax
        : spec.defaultRestSeconds;

    return EvidenceRecommendation(
      recommendedWeightKg: recWeight,
      recommendedRepMin: repMin,
      recommendedRepMax: repMax,
      recommendedSetsMin: spec.setsMin,
      recommendedSetsMax: spec.setsMax,
      recommendedRestSeconds: restSeconds,
      restRangeMinSeconds: spec.restMin,
      restRangeMaxSeconds: spec.restMax,
      label: label,
      explanation: explanation,
      confidence: confidence,
      estimatedOneRmKg: roundTo(e1rm, 1),
      completedWorkingSets: completed,
      setsGuidanceMessage: guidance,
      warnings: warnings,
    );
  }

  bool _effortAllowsProgress(RecommendationStyle style, LoggedSetInput s) {
    switch (style) {
      case RecommendationStyle.conservative:
        return !s.isFailure &&
            (s.rpe == null || s.rpe! <= 8.5) &&
            (s.rir == null || s.rir! >= 2);
      case RecommendationStyle.balanced:
        return !s.isFailure &&
            (s.rpe == null || s.rpe! <= 9) &&
            (s.rir == null || s.rir! >= 1);
      case RecommendationStyle.aggressive:
        return !s.isFailure && (s.rpe == null || s.rpe! < 9.5);
    }
  }

  /// Rep target after a successful progression.
  (int, int) _afterProgressRange(
      int loggedReps, CategorySpec spec, bool isIsolation, int effMin, int effMax) {
    if (isIsolation) {
      // Keep isolation reps moderate-to-high; don't drop to very low reps.
      final lo = spec.repMin;
      final hi = _clampInt(spec.repMin + 2, spec.repMin, spec.repMax);
      return (lo, hi);
    }
    final lo = _clampInt(loggedReps - 4, spec.repMin, spec.repMax);
    final hi = _clampInt(loggedReps - 2, lo, spec.repMax);
    return (lo, hi);
  }

  double _reduce(double weight, double increment, bool isAssisted) {
    if (isAssisted) {
      // More assistance = easier. Reducing "load" means adding assistance.
      return roundToNearestIncrement(weight + increment, increment);
    }
    final reduced = weight - increment;
    return roundToNearestIncrement(reduced < 0 ? 0 : reduced, increment);
  }

  /// Counts how many of the most recent transitions were >=15% drops in
  /// performance score, including the current set vs the previous one.
  int _consecutiveDrops(
      List<LoggedSetInput> previous, LoggedSetInput current, bool isAssisted) {
    // Drop detection on load*reps is meaningful for loaded exercises only.
    if (isAssisted || previous.isEmpty) return 0;
    final series = [...previous, current];
    var consecutive = 0;
    for (var i = series.length - 1; i > 0; i--) {
      final prevSet = series[i - 1];
      final curSet = series[i];
      // A reduced tonnage only counts as a "drop" when the load was not
      // intentionally increased (ascending-load sets reduce reps by design).
      if (curSet.weightKg > prevSet.weightKg) break;
      final prevScore = prevSet.performanceScore;
      if (prevScore <= 0) break;
      final drop = (prevScore - curSet.performanceScore) / prevScore;
      if (drop >= 0.15) {
        consecutive++;
      } else {
        break;
      }
    }
    return consecutive;
  }

  String _setsGuidance({
    required int completed,
    required int setsMin,
    required int setsMax,
    required bool forceFinish,
  }) {
    if (forceFinish) {
      return 'Performance is dropping. Consider ending this exercise.';
    }
    if (completed < setsMin) {
      final remaining = setsMin - completed;
      return 'Do $remaining more working set${remaining == 1 ? '' : 's'} '
          '(target $setsMin–$setsMax).';
    }
    if (completed < setsMax) {
      final optional = setsMax - completed;
      return 'You\'ve completed the minimum $setsMin sets. '
          'Up to $optional optional set${optional == 1 ? '' : 's'} remain.';
    }
    return 'You\'ve reached the recommended $setsMax sets. '
        'Consider finishing this exercise.';
  }

  /// Trend across an exercise's working sets, for the summary screen.
  static PerformanceTrend trendOf(List<LoggedSetInput> workingSets) {
    final sets = workingSets.where((s) => !s.isWarmup).toList();
    if (sets.length < 2) return PerformanceTrend.stable;
    final first = sets.first.performanceScore;
    final last = sets.last.performanceScore;
    if (first <= 0) return PerformanceTrend.stable;
    final change = (last - first) / first;
    if (change >= 0.05) return PerformanceTrend.improved;
    if (change <= -0.10) return PerformanceTrend.declined;
    return PerformanceTrend.stable;
  }
}
