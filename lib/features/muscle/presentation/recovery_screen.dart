import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums.dart';
import '../../workout/presentation/session_providers.dart';

class RecoveryScreen extends ConsumerWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recovery = ref.watch(recoveryByMuscleProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Recovery')),
      body: recovery.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (map) {
          final trained = map.values.where((r) => r.lastTrainedAt != null).toList();
          if (trained.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No recovery data yet. Complete a workout to see muscle recovery estimates.'),
              ),
            );
          }
          final recent = trained.where((r) => r.daysSinceLastTrained <= 7).toList();
          final overall = recent.isEmpty
              ? 100
              : (recent.fold<double>(0, (s, r) => s + r.recoveryPercent) / recent.length).round();
          final byRegion = <MuscleRegion, List<double>>{};
          for (final r in trained) {
            byRegion.putIfAbsent(r.region, () => []).add(r.recoveryPercent);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Overall estimated recovery', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('$overall%', style: Theme.of(context).textTheme.headlineMedium),
                    const Text('Based on recent logged workouts and training strain heuristics.'),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Text('Regions', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final region in MuscleRegion.values)
                if (byRegion[region] != null)
                  _RecoveryRow(
                    label: region.label,
                    percent: byRegion[region]!.reduce((a, b) => a + b) / byRegion[region]!.length,
                  ),
              const SizedBox(height: 16),
              Text('Muscle groups', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final state in trained..sort((a, b) => a.recoveryPercent.compareTo(b.recoveryPercent)))
                _RecoveryRow(label: state.muscle.label, percent: state.recoveryPercent, level: state.level.label),
              const SizedBox(height: 16),
              const Text('Suggested caution notes are advisory only. If a target muscle is estimated to be fatigued, consider lighter loads, longer rest, or another muscle group.'),
            ],
          );
        },
      ),
    );
  }
}

class _RecoveryRow extends StatelessWidget {
  const _RecoveryRow({required this.label, required this.percent, this.level});

  final String label;
  final double percent;
  final String? level;

  @override
  Widget build(BuildContext context) {
    final color = percent >= 80
        ? Colors.green
        : percent >= 60
            ? Colors.lightGreen
            : percent >= 35
                ? Colors.orange
                : Colors.red;
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: LinearProgressIndicator(value: percent / 100, color: color),
        trailing: Text('${percent.round()}%${level == null ? '' : '\n$level'}', textAlign: TextAlign.right),
      ),
    );
  }
}
