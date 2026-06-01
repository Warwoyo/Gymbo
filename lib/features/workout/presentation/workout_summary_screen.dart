import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatting.dart';
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
            Text(s.dayType.label,
                style: Theme.of(context).textTheme.headlineSmall),
            Text('${Format.dateTime(s.startedAt)} • ${Format.duration(s.duration)}'),
            const SizedBox(height: 16),
            _StatGrid(summary: s),
            const SizedBox(height: 16),
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
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Done'),
            ),
          ],
        ),
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
      ('Total reps', '${summary.totalReps}'),
      ('Volume load', Format.kg(summary.totalVolumeLoad)),
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
            if (ex.bestEstimatedOneRepMaxKg > 0)
              Text('Best e1RM: ${Format.kg(ex.bestEstimatedOneRepMaxKg)}',
                  style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 6),
            for (final s in ex.sets)
              Text(
                '  Set ${s.setNumber}: ${Format.kg(s.weightKg)} × ${s.reps}'
                '${s.isWarmup ? '  (warm-up)' : ''}',
              ),
          ],
        ),
      ),
    );
  }
}
