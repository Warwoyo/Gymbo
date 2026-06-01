import 'package:flutter/material.dart';

import '../../../core/utils/formatting.dart';
import '../../workout/presentation/workout_controller.dart';
import '../domain/recommendation_engine.dart';

/// Displays the next-set recommendation (spec §Recommendation Display).
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key, required this.view});

  final RecommendationView view;

  @override
  Widget build(BuildContext context) {
    final r = view.recommendation;
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final (icon, trend) = switch (view.direction) {
      AdjustmentDirection.increase => (Icons.trending_up, 'Progressing up'),
      AdjustmentDirection.decrease => (Icons.trending_down, 'Backing off'),
      AdjustmentDirection.hold => (Icons.trending_flat, 'Holding steady'),
    };

    return Card(
      color: scheme.tertiaryContainer.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: scheme.tertiary),
                const SizedBox(width: 8),
                Text('Recommendation', style: theme.textTheme.titleMedium),
                const Spacer(),
                Icon(icon, size: 18),
                const SizedBox(width: 4),
                Text(trend, style: theme.textTheme.labelMedium),
              ],
            ),
            const Divider(height: 20),
            _big(context, 'Estimated 1RM',
                Format.kg(r.estimatedOneRepMaxKg)),
            const SizedBox(height: 8),
            _big(
              context,
              'Next set',
              '${Format.kg(view.finalLoadKg)} × ${r.targetReps} reps',
              highlight: true,
            ),
            const SizedBox(height: 8),
            _row('Target range',
                '${r.targetRepRangeMin}-${r.targetRepRangeMax} reps, '
                '${r.targetSetsMin}-${r.targetSetsMax} sets'),
            _row('Load range',
                '${Format.kg(r.recommendedLoadRangeMinKg)} – ${Format.kg(r.recommendedLoadRangeMaxKg)}'),
            _row('Rest', '${r.restSeconds} seconds'),
            const SizedBox(height: 8),
            Text(r.explanation,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _big(BuildContext context, String label, String value,
      {bool highlight = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        Text(
          value,
          style: (highlight
                  ? theme.textTheme.headlineSmall
                  : theme.textTheme.titleMedium)
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(k), Text(v)],
        ),
      );
}
