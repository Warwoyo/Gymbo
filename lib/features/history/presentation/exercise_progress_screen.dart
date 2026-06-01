import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting.dart';
import '../../workout/presentation/session_providers.dart';

class ExerciseProgressScreen extends ConsumerWidget {
  const ExerciseProgressScreen({
    super.key,
    required this.exerciseId,
    required this.exerciseName,
  });

  final String exerciseId;
  final String exerciseName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress =
        ref.watch(exerciseProgressProvider((exerciseId: exerciseId)));

    return Scaffold(
      appBar: AppBar(title: Text(exerciseName)),
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (points) {
          if (points.isEmpty) {
            return const Center(child: Text('No history for this exercise yet.'));
          }
          final best = points
              .map((p) => p.bestEstimatedOneRepMaxKg)
              .fold<double>(0, (a, b) => b > a ? b : a);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('All-time best e1RM'),
                      Text(Format.kg(best),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Session by session',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final p in points.reversed)
                Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    title: Text(Format.date(p.date)),
                    subtitle: Text(
                      'Top: ${Format.kg(p.topWeightKg)} × ${p.topWeightReps} • '
                      'Volume ${Format.kg(p.totalVolume)}',
                    ),
                    trailing: Text(
                      Format.kg(p.bestEstimatedOneRepMaxKg),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
