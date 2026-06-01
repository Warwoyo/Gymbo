import 'package:flutter/material.dart';

import '../../../core/utils/formatting.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../domain/evidence_recommendation_engine.dart';

/// Displays the evidence-informed next-set recommendation (spec §6).
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.exercise,
  });

  final EvidenceRecommendation recommendation;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final r = recommendation;
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final isAssisted = exercise.exerciseCategory.isAssisted;

    final (icon, color) = _labelStyle(r.label, scheme);
    final weightLabel = isAssisted
        ? 'Assistance ${Format.kg(r.recommendedWeightKg)}'
        : Format.kg(r.recommendedWeightKg);

    return Card(
      color: scheme.tertiaryContainer.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(r.label.label,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                _ConfidenceChip(confidence: r.confidence),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Next set', style: theme.textTheme.bodyLarge),
                Flexible(
                  child: Text(
                    '$weightLabel × ${r.repRangeLabel}',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _row(context, 'Estimated 1RM',
                r.estimatedOneRmKg > 0 ? Format.kg(r.estimatedOneRmKg) : '—'),
            _row(context, 'Suggested sets',
                '${r.recommendedSetsMin}–${r.recommendedSetsMax}'),
            _row(context, 'Rest',
                '${r.restRangeMinSeconds}–${r.restRangeMaxSeconds} sec'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(r.setsGuidanceMessage,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Text(r.explanation, style: theme.textTheme.bodySmall),
            if (r.warnings.isNotEmpty) ...[
              const SizedBox(height: 6),
              ...r.warnings.map((w) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          size: 14, color: scheme.error),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(w,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: scheme.error)),
                      ),
                    ],
                  )),
            ],
            const SizedBox(height: 8),
            Text(r.evidenceLabel,
                style: theme.textTheme.labelSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(k), Text(v)],
        ),
      );

  (IconData, Color) _labelStyle(RecommendationLabel label, ColorScheme s) {
    switch (label) {
      case RecommendationLabel.increaseLoad:
      case RecommendationLabel.increaseDifficulty:
        return (Icons.trending_up, s.primary);
      case RecommendationLabel.holdSteady:
        return (Icons.trending_flat, s.secondary);
      case RecommendationLabel.reduceLoad:
      case RecommendationLabel.deloadSuggested:
        return (Icons.trending_down, s.error);
      case RecommendationLabel.restMore:
        return (Icons.timer, s.tertiary);
      case RecommendationLabel.finishExercise:
        return (Icons.flag, s.error);
    }
  }
}

class _ConfidenceChip extends StatelessWidget {
  const _ConfidenceChip({required this.confidence});
  final RecommendationConfidence confidence;

  @override
  Widget build(BuildContext context) {
    final text = switch (confidence) {
      RecommendationConfidence.high => 'High confidence',
      RecommendationConfidence.medium => 'Medium confidence',
      RecommendationConfidence.low => 'Low confidence',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
