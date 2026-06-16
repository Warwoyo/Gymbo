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
import '../../workout/domain/workout_session.dart';
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
            const SizedBox(height: 16),
            const _RecommendedTodayCard(),
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

class _RecommendedTodayCard extends ConsumerWidget {
  const _RecommendedTodayCard();

  static const _readyThreshold = 60.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final recovery = ref.watch(recoveryByMuscleProvider);
    final lastSession = ref.watch(lastFinishedSessionProvider);

    if (profile == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Create or select a profile to get today\'s workout recommendation.',
          ),
        ),
      );
    }

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
      data: (recoveryMap) {
        final session = lastSession.valueOrNull;
        final recommendation = _WorkoutSplitRecommendation.from(
          recovery: recoveryMap,
          lastSession: session,
          goal: profile.primaryGoal,
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_awesome),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommended today: ${recommendation.label}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(recommendation.reason),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: Text('Start ${recommendation.label} Workout'),
                  onPressed: () => startWorkoutFromHome(
                    context,
                    ref,
                    filter: recommendation.filter,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkoutSplitRecommendation {
  const _WorkoutSplitRecommendation({
    required this.filter,
    required this.label,
    required this.reason,
  });

  final ExerciseFilter filter;
  final String label;
  final String reason;

  static _WorkoutSplitRecommendation from({
    required Map<MuscleGroup, MuscleRecoveryState> recovery,
    required WorkoutSession? lastSession,
    required TrainingGoal goal,
  }) {
    if (recovery.values.every((state) => state.lastTrainedAt == null)) {
      return const _WorkoutSplitRecommendation(
        filter: ExerciseFilter.all,
        label: 'Full Body',
        reason:
            'Log a few workouts and Gymbo will tailor this around your recovery. For now, start balanced and keep the effort moderate.',
      );
    }

    const splitMuscles = <ExerciseFilter, List<MuscleGroup>>{
      ExerciseFilter.push: [
        MuscleGroup.chest,
        MuscleGroup.shoulders,
        MuscleGroup.triceps,
      ],
      ExerciseFilter.pull: [
        MuscleGroup.back,
        MuscleGroup.biceps,
        MuscleGroup.traps,
        MuscleGroup.forearms,
      ],
      ExerciseFilter.legs: [
        MuscleGroup.quads,
        MuscleGroup.hamstrings,
        MuscleGroup.glutes,
        MuscleGroup.calves,
      ],
      ExerciseFilter.all: [
        MuscleGroup.chest,
        MuscleGroup.back,
        MuscleGroup.shoulders,
        MuscleGroup.biceps,
        MuscleGroup.triceps,
        MuscleGroup.quads,
        MuscleGroup.hamstrings,
        MuscleGroup.glutes,
      ],
    };

    final lastFilter = switch (lastSession?.dayType) {
      DayType.push => ExerciseFilter.push,
      DayType.pull => ExerciseFilter.pull,
      DayType.leg => ExerciseFilter.legs,
      null => null,
    };
    final goalBias = switch (goal) {
      TrainingGoal.strength => ExerciseFilter.all,
      TrainingGoal.hypertrophy => null,
      TrainingGoal.muscularEndurance => ExerciseFilter.all,
      TrainingGoal.generalFitness => ExerciseFilter.all,
    };

    double score(ExerciseFilter split) {
      final muscles = splitMuscles[split]!;
      final states = muscles
          .map((m) => recovery[m])
          .whereType<MuscleRecoveryState>()
          .toList();
      if (states.isEmpty) return split == ExerciseFilter.all ? 58 : 50;
      final avgRecovery = states.fold<double>(
            0,
            (sum, state) => sum + state.recoveryPercent,
          ) /
          states.length;
      final lowRecoveryPenalty = states
              .where((state) =>
                  state.recoveryPercent < _RecommendedTodayCard._readyThreshold)
              .length *
          18;
      final recency = states
              .map((state) => state.daysSinceLastTrained)
              .fold<int>(0, (max, days) => days > max ? days : max)
              .clamp(0, 7)
              .toDouble() *
          2;
      final lastPenalty = split == lastFilter ? 18 : 0;
      final goalBonus = split == goalBias ? 8 : 0;
      final fullBodyFatiguePenalty = split == ExerciseFilter.all &&
              states.any((state) => state.recoveryPercent < 50)
          ? 16
          : 0;
      return avgRecovery +
          recency +
          goalBonus -
          lowRecoveryPenalty -
          lastPenalty -
          fullBodyFatiguePenalty;
    }

    final candidates = splitMuscles.keys.toList()
      ..sort((a, b) => score(b).compareTo(score(a)));
    final best = candidates.first;
    final muscles = splitMuscles[best]!;
    final ready = muscles
        .map((m) => recovery[m])
        .whereType<MuscleRecoveryState>()
        .where((state) =>
            state.recoveryPercent >= _RecommendedTodayCard._readyThreshold)
        .toList()
      ..sort((a, b) => b.recoveryPercent.compareTo(a.recoveryPercent));
    final stillRecovering = recovery.values
        .where((state) =>
            state.recoveryPercent < _RecommendedTodayCard._readyThreshold)
        .toList()
      ..sort((a, b) => a.recoveryPercent.compareTo(b.recoveryPercent));

    final readyText = ready
        .take(2)
        .map((state) => state.muscle.label.toLowerCase())
        .join(' and ');
    final recoveringText = stillRecovering
        .take(2)
        .map((state) => state.muscle.label.toLowerCase())
        .join(' and ');
    final reason = [
      if (readyText.isNotEmpty) '${_capitalize(readyText)} look ready.',
      if (lastFilter == best) 'This still scores best despite being recent.',
      if (lastFilter != null && lastFilter != best)
        'You trained ${lastFilter.label.toLowerCase()} most recently.',
      if (recoveringText.isNotEmpty)
        '${_capitalize(recoveringText)} '
        '${stillRecovering.length == 1 ? 'is' : 'are'} still recovering.',
      if (goalBias == best) 'This fits your ${goal.label.toLowerCase()} goal.',
    ].join(' ');

    return _WorkoutSplitRecommendation(
      filter: best,
      label: best == ExerciseFilter.all ? 'Full Body' : best.label,
      reason: reason.isEmpty
          ? 'This split balances readiness, recent training, and your '
              '${goal.label.toLowerCase()} goal.'
          : reason,
    );
  }

  static String _capitalize(String value) =>
      value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';
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
