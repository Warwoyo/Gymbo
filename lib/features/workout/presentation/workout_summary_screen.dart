import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../../core/utils/formatting.dart';
import '../../muscle/presentation/human_muscle_map.dart';
import '../../muscle/presentation/muscle_map_color_scale.dart';
import '../domain/workout_summary.dart';
import 'session_providers.dart';

class WorkoutSummaryScreen extends ConsumerWidget {
  const WorkoutSummaryScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(workoutSummaryProvider(sessionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout summary'),
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: summary.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (s) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(s.session.sessionName ?? s.dayType?.label ?? 'Workout',
                style: Theme.of(context).textTheme.headlineSmall),
            Text(
              '${Format.dateTime(s.startedAt)} • ${Format.duration(s.duration)}',
            ),
            const SizedBox(height: 16),
            _SessionHighlightsCard(summary: s),
            const SizedBox(height: 16),
            _StatGrid(summary: s),
            const SizedBox(height: 16),
            if (s.muscleImpacts.isNotEmpty) ...[
              _MuscleImpactCard(summary: s),
              const SizedBox(height: 16),
            ],
            if (s.personalRecords.isNotEmpty) ...[
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: const [
                        Icon(Icons.emoji_events),
                        SizedBox(width: 8),
                        Text('Personal records',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(height: 8),
                      for (final pr in s.personalRecords)
                        Text(
                            '${pr.exerciseName}: ${Format.kg(pr.bestEstimatedOneRepMaxKg)} e1RM'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text('Exercises', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final ex in s.exercises) _ExerciseCard(ex: ex),
            const SizedBox(height: 16),
            _NextTimePlanCard(summary: s),
            const SizedBox(height: 24),
            _SummaryActions(summary: s),
          ],
        ),
      ),
    );
  }
}

class _SessionHighlightsCard extends StatelessWidget {
  const _SessionHighlightsCard({required this.summary});

  final WorkoutSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topMuscles = summary.primaryMuscleImpacts.isNotEmpty
        ? summary.primaryMuscleImpacts
            .map((m) => m.muscle.label)
            .take(3)
            .join(', ')
        : summary.muscleImpacts.map((m) => m.muscle.label).take(3).join(', ');
    final bestExercise = summary.bestExercise;

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insights,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Text(
                  'Session highlights',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _HighlightRow(
              label: 'PRs',
              value: '${summary.personalRecords.length}',
            ),
            _HighlightRow(
              label: 'Main muscles',
              value: topMuscles.isEmpty ? 'No muscle impact yet' : topMuscles,
            ),
            _HighlightRow(
              label: 'Best exercise',
              value: bestExercise == null
                  ? 'No exercise logged'
                  : '${bestExercise.exerciseName} • ${Format.kg(bestExercise.totalVolume)} volume',
            ),
            _HighlightRow(
              label: 'Next session',
              value: summary.mainNextSessionAdvice,
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _NextTimePlanCard extends StatelessWidget {
  const _NextTimePlanCard({required this.summary});

  final WorkoutSummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.next_plan_outlined),
              SizedBox(width: 8),
              Text(
                'Next time plan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]),
            const SizedBox(height: 8),
            if (summary.exercises.isEmpty)
              const Text('Complete exercises to generate a plan for next time.')
            else
              for (final ex in summary.exercises) ...[
                Text(ex.exerciseName,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(ex.nextTimeAdvice,
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }
}

class _SummaryActions extends ConsumerWidget {
  const _SummaryActions({required this.summary});

  final WorkoutSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressExercise = summary.bestExercise ??
        (summary.exercises.isEmpty ? null : summary.exercises.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: progressExercise == null
              ? null
              : () => context.go(
                    '/progress/${progressExercise.exerciseId}?name=${Uri.encodeComponent(progressExercise.exerciseName)}',
                  ),
          child: const Text('View progress'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: summary.exercises.isEmpty
              ? null
              : () => _saveAsTemplate(context, ref),
          child: const Text('Save as template'),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => context.go('/home'),
          child: const Text('Done'),
        ),
      ],
    );
  }

  Future<void> _saveAsTemplate(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(
      text: summary.session.sessionName ?? summary.dayType?.label ?? 'Workout template',
    );
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save as template'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Template name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.trim().isEmpty) return;
    final template = await ref.read(workoutTemplateRepositoryProvider).saveSessionAsTemplate(
          sessionId: summary.session.id,
          name: name,
        );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved ${template.name} as a template.')),
    );
  }

}

class _MuscleImpactCard extends StatelessWidget {
  const _MuscleImpactCard({required this.summary});
  final WorkoutSummary summary;

  @override
  Widget build(BuildContext context) {
    final primary = summary.muscleImpacts
        .where((m) => m.strongestRole == MuscleRole.primary)
        .map((m) => m.muscle.label)
        .take(6)
        .join(', ');
    final secondary = summary.muscleImpacts
        .where((m) => m.strongestRole != MuscleRole.primary)
        .map((m) => m.muscle.label)
        .take(6)
        .join(', ');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: const [
            Icon(Icons.accessibility_new),
            SizedBox(width: 8),
            Text('Muscle Impact', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 6),
          const Text(
              'Estimated from logged sets, exercise muscle targets, volume and effort.'),
          const SizedBox(height: 12),
          HumanMuscleMap(
            mode: MuscleMapMode.workoutImpact,
            scores: {
              for (final m in summary.muscleImpacts)
                m.muscle: m.normalizedScore,
            },
          ),
          const SizedBox(height: 12),
          for (final impact in summary.muscleImpacts.take(8)) ...[
            Row(children: [
              SizedBox(width: 100, child: Text(impact.muscle.label)),
              Expanded(child: LinearProgressIndicator(value: impact.normalizedScore / 100)),
              const SizedBox(width: 8),
              Text('${impact.normalizedScore.round()}%'),
            ]),
            const SizedBox(height: 8),
          ],
          if (primary.isNotEmpty) Text('Primary muscles trained: $primary'),
          if (secondary.isNotEmpty) Text('Secondary/supporting muscles: $secondary'),
        ]),
      ),
    );
  }

}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.summary});
  final WorkoutSummary summary;

  @override
  Widget build(BuildContext context) {
    final stats = <(String, String)>[
      ('Exercises', '${summary.numberOfExercises}'),
      ('Working sets', '${summary.totalWorkingSets}'),
      ('Warm-up sets', '${summary.totalWarmupSets}'),
      ('Total reps', '${summary.totalReps}'),
      ('Volume load', Format.kg(summary.totalVolumeLoad)),
      ('Best e1RM', Format.kg(summary.bestEstimatedOneRepMaxKg)),
      ('Avg rest', Format.mmss(summary.averageRestSeconds)),
      ('Longest rest', Format.mmss(summary.longestRestSeconds)),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        for (final (label, value) in stats)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold)),
                  Text(label,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.ex});
  final ExerciseSummary ex;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ex.exerciseName,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                if (ex.isPersonalRecord)
                  const Icon(Icons.emoji_events, size: 18),
              ],
            ),
            Row(
              children: [
                if (ex.bestEstimatedOneRepMaxKg > 0)
                  Text('Best e1RM: ${Format.kg(ex.bestEstimatedOneRepMaxKg)}',
                      style: Theme.of(context).textTheme.bodySmall),
                const Spacer(),
                _TrendChip(trend: ex.trend),
              ],
            ),
            Text('Volume: ${Format.kg(ex.totalVolume)}',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 6),
            for (final s in ex.sets)
              Text(
                '  Set ${s.setNumber}: ${Format.kg(s.weightKg)} × ${s.reps}'
                '${s.isWarmup ? '  (warm-up)' : ''}',
              ),
            const SizedBox(height: 6),
            Text(ex.nextTimeAdvice,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.trend});
  final PerformanceTrend trend;

  @override
  Widget build(BuildContext context) {
    final (icon, color, text) = switch (trend) {
      PerformanceTrend.improved =>
        (Icons.trending_up, Colors.green, 'Improved'),
      PerformanceTrend.declined =>
        (Icons.trending_down, Theme.of(context).colorScheme.error, 'Declined'),
      PerformanceTrend.stable => (Icons.trending_flat, Colors.grey, 'Stable'),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(text, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
