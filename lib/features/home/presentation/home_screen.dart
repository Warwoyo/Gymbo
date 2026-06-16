import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../exercise_catalog/presentation/exercise_list_screen.dart';
import '../../../core/utils/formatting.dart';
import '../../muscle/domain/recovery_estimate.dart';
import '../../muscle/presentation/human_muscle_map.dart';
import '../../muscle/presentation/muscle_map_color_scale.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../workout/presentation/session_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final activeSession = ref.watch(activeSessionProvider);
    final lastSession = ref.watch(lastFinishedSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gymbo'),
        actions: [
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/history'),
          ),
          IconButton(
            tooltip: 'Recovery / Muscle Map',
            icon: const Icon(Icons.accessibility_new),
            onPressed: () => context.push('/recovery'),
          ),
          IconButton(
            tooltip: 'Switch profile',
            icon: const Icon(Icons.people_alt_outlined),
            onPressed: () => context.push('/profiles'),
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(activeSessionProvider);
          ref.invalidate(lastFinishedSessionProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Hi, ${profile?.name ?? 'Athlete'} 👋',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            if (profile != null)
              Text('Goal: ${profile.primaryGoal.label}',
                  style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),

            // Notice when the previous workout was auto-ended.
            lastSession.maybeWhen(
              data: (s) => (s != null &&
                      s.status == WorkoutSessionStatus.autoCompleted)
                  ? Card(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text(
                            'Your previous workout was automatically ended after inactivity.'),
                      ),
                    )
                  : const SizedBox.shrink(),
              orElse: () => const SizedBox.shrink(),
            ),

            // Active session resume card.
            activeSession.maybeWhen(
              data: (s) => s == null
                  ? const SizedBox.shrink()
                  : Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        leading: const Icon(Icons.play_circle_fill, size: 36),
                        title: Text('Resume workout'),
                        subtitle:
                            Text('Started ${Format.time(s.startedAt)}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/workout/${s.id}'),
                      ),
                    ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),

            Text('Start a workout',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            FilledButton.icon(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(64)),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout', style: TextStyle(fontSize: 18)),
              onPressed: () => startWorkoutFromHome(context, ref),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QuickFilter(
                  label: 'Start Push',
                  filter: ExerciseFilter.push,
                ),
                _QuickFilter(
                  label: 'Start Pull',
                  filter: ExerciseFilter.pull,
                ),
                _QuickFilter(
                  label: 'Start Legs',
                  filter: ExerciseFilter.legs,
                ),
                _QuickFilter(
                  label: 'Start Full Body',
                  filter: ExerciseFilter.all,
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text('Last workout',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            lastSession.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('$e'),
              data: (s) => s == null
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No workouts yet. Start one above!'),
                      ),
                    )
                  : Card(
                      child: ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(s.sessionName ?? s.dayType?.label ?? 'Workout'),
                        subtitle: Text(
                            '${Format.date(s.startedAt)} • ${Format.duration(s.duration)}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/summary/${s.id}'),
                      ),
                    ),
            ),
            const SizedBox(height: 24),

            Text('Estimated Recovery',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Based on your recent logged workouts.',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            const _RecoveryCard(),
          ],
        ),
      ),
    );
  }
}

class _RecoveryCard extends ConsumerWidget {
  const _RecoveryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recovery = ref.watch(recoveryByMuscleProvider);
    return recovery.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => Card(
        child: Padding(padding: const EdgeInsets.all(16), child: Text('$e')),
      ),
      data: (map) {
        final trained =
            map.values.where((r) => r.lastTrainedAt != null).toList();
        if (trained.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Complete a workout to see recovery estimates.'),
            ),
          );
        }
        final recent =
            trained.where((r) => r.daysSinceLastTrained <= 7).toList();
        final pool = recent.isEmpty ? trained : recent;
        final overall =
            (pool.fold<double>(0, (s, r) => s + r.recoveryPercent) / pool.length)
                .round();
        final mostFatigued = pool
            .reduce((a, b) => a.recoveryPercent <= b.recoveryPercent ? a : b);
        const estimate = RecoveryEstimate();
        final ready = RecoveryEstimate.label(
            estimate.timeToRecovered(mostFatigued));

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Overall: $overall%',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.push('/recovery'),
                      child: const Text('View details'),
                    ),
                  ],
                ),
                Text(
                    'Most fatigued: ${mostFatigued.muscle.label} • Estimated ready in: $ready'),
                const SizedBox(height: 12),
                HumanMuscleMap(
                  mode: MuscleMapMode.recovery,
                  height: 220,
                  scores: {
                    for (final r in map.values) r.muscle: r.recoveryPercent,
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


Future<void> startWorkoutFromHome(BuildContext context, WidgetRef ref,
    {ExerciseFilter filter = ExerciseFilter.all}) async {
  final profile = ref.read(activeProfileProvider).valueOrNull;
  if (profile == null) return;

  final activeSession = await ref.read(activeSessionProvider.future);
  final repository = ref.read(workoutRepositoryProvider);

  if (activeSession != null) {
    if (!context.mounted) return;

    final action = await showDialog<_ActiveWorkoutAction>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout already in progress'),
        content: const Text(
          'You have an active workout. What would you like to do?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(_ActiveWorkoutAction.cancel),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(_ActiveWorkoutAction.startNew),
            child: const Text('End current and start new'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pop(_ActiveWorkoutAction.resume),
            child: const Text('Resume current workout'),
          ),
        ],
      ),
    );

    switch (action) {
      case _ActiveWorkoutAction.resume:
        if (context.mounted) {
          context.push('/workout/${activeSession.id}');
        }
        return;
      case _ActiveWorkoutAction.startNew:
        await repository.endSession(activeSession.id);
        break;
      case _ActiveWorkoutAction.cancel:
      case null:
        return;
    }
  }

  final session = await repository.startSession(userProfileId: profile.id);
  ref.invalidate(activeSessionProvider);
  ref.invalidate(lastFinishedSessionProvider);
  if (context.mounted) {
    context.push('/workout/${session.id}?filter=${filter.name}');
  }
}

enum _ActiveWorkoutAction { resume, startNew, cancel }

class _QuickFilter extends ConsumerWidget {
  const _QuickFilter({required this.label, required this.filter});

  final String label;
  final ExerciseFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonalIcon(
      icon: const Icon(Icons.play_arrow),
      label: Text(label),
      onPressed: () async {
        await startWorkoutFromHome(context, ref, filter: filter);
      },
    );
  }
}
