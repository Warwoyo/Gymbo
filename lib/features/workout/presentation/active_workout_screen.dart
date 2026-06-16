import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums.dart';
import '../../../core/utils/formatting.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../../exercise_catalog/presentation/exercise_list_screen.dart';
import '../../exercise_catalog/presentation/exercise_providers.dart';
import '../../muscle/domain/muscle_recovery.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../recommendations/domain/category_defaults.dart';
import '../../recommendations/presentation/recommendation_card.dart';
import '../domain/workout_set.dart';
import 'rest_timer_widget.dart';
import 'set_log_sheet.dart';
import 'workout_controller.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({
    super.key,
    required this.sessionId,
    this.initialFilter = ExerciseFilter.all,
  });

  final String sessionId;
  final ExerciseFilter initialFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(activeWorkoutProvider(sessionId));
    final controller = ref.read(activeWorkoutProvider(sessionId).notifier);
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final showRpeRir = profile?.showRpeRir ?? true;

    return Scaffold(
      appBar: AppBar(
        title: asyncState.maybeWhen(
          data: (s) => Text(
            s.session.sessionName ?? s.session.dayType?.label ?? 'Workout',
          ),
          orElse: () => const Text('Workout'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _endWorkout(context, controller),
            icon: const Icon(Icons.stop_circle_outlined),
            label: const Text('End'),
          ),
        ],
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (state) {
          final selected = state.selected;
          return Column(
            children: [
              const RestTimerBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (selected == null)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.add_circle_outline),
                          title: const Text('Select an exercise'),
                          subtitle: Text(
                              '${state.exercises.length} exercise(s) this session'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _pickExercise(context, ref, state),
                        ),
                      )
                    else
                      _ActiveExerciseCard(
                        view: selected,
                        goalSetsLabel: _setsLabel(
                          selected,
                          profile?.primaryGoal ?? TrainingGoal.hypertrophy,
                        ),
                        completed: selected.workingSets.length,
                        onSwap: () => _pickExercise(context, ref, state),
                        onEndExercise: () =>
                            _endCurrentExercise(context, ref, controller, state),
                      ),
                    const SizedBox(height: 12),
                    if (selected == null)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child:
                              Text('Add an exercise to start logging sets.'),
                        ),
                      )
                    else ...[
                      if (selected.lastWorkingSet != null) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            onPressed: () => _repeatLastWorkingSet(
                              controller,
                              selected.lastWorkingSet!,
                            ),
                            icon: const Icon(Icons.replay),
                            label: const Text('Repeat last set'),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      _SetsList(
                        sets: selected.sets,
                        onDelete: controller.deleteSet,
                      ),
                      const SizedBox(height: 12),
                      if (state.recommendation != null)
                        RecommendationCard(
                          recommendation: state.recommendation!,
                          exercise: selected.exercise,
                        ),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: asyncState.maybeWhen(
        data: (state) => state.selected == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () =>
                    _logSet(context, ref, controller, state, showRpeRir),
                icon: const Icon(Icons.add),
                label: const Text('Log set'),
              ),
        orElse: () => null,
      ),
    );
  }

  String _setsLabel(WorkoutExerciseView view, TrainingGoal goal) {
    final spec = CategoryDefaults.of(view.exercise.exerciseCategory, goal);
    final min = view.exercise.recommendedSetRangeMin ?? spec.setsMin;
    final max = view.exercise.recommendedSetRangeMax ?? spec.setsMax;
    return '$min–$max';
  }

  Future<void> _pickExercise(
      BuildContext context, WidgetRef ref, ActiveWorkoutState state) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) =>
            ExerciseListScreen(initialFilter: initialFilter, pickMode: true),
      ),
    );
    if (result != null) {
      await ref
          .read(activeWorkoutProvider(sessionId).notifier)
          .selectExercise(result);
    }
  }

  Future<void> _endCurrentExercise(
    BuildContext context,
    WidgetRef ref,
    WorkoutController controller,
    ActiveWorkoutState state,
  ) async {
    final completed = state.selected;
    if (completed == null) return;

    final allExercises = await ref.read(allExercisesProvider.future);
    final recovery = ref.read(recoveryByMuscleProvider).valueOrNull ??
        const <MuscleGroup, MuscleRecoveryState>{};
    final recommendations = _nextExerciseRecommendations(
      allExercises: allExercises,
      state: state,
      completed: completed,
      recovery: recovery,
    );

    await controller.endExercise();
    if (!context.mounted) return;

    final action = await showModalBottomSheet<_ExerciseCompleteAction>(
      context: context,
      showDragHandle: true,
      builder: (_) => _ExerciseCompleteSheet(
        completed: completed,
        recommendations: recommendations,
      ),
    );
    if (action == null || !context.mounted) return;

    switch (action.type) {
      case _ExerciseCompleteActionType.addRecommended:
        final exerciseId = action.exerciseId;
        if (exerciseId != null) {
          await controller.selectExercise(exerciseId);
        }
        break;
      case _ExerciseCompleteActionType.chooseAnother:
        await _pickExercise(context, ref, state);
        break;
      case _ExerciseCompleteActionType.finishWorkout:
        await _endWorkout(context, controller);
        break;
    }
  }

  List<Exercise> _nextExerciseRecommendations({
    required List<Exercise> allExercises,
    required ActiveWorkoutState state,
    required WorkoutExerciseView completed,
    required Map<MuscleGroup, MuscleRecoveryState> recovery,
  }) {
    final performedIds = state.exercises
        .where((view) => view.sets.isNotEmpty ||
            view.workoutExercise.endedAt != null ||
            view.exercise.id == completed.exercise.id)
        .map((view) => view.exercise.id)
        .toSet();

    final candidates = allExercises.where((exercise) {
      if (performedIds.contains(exercise.id)) return false;
      if (!_matchesInitialFilter(exercise)) return false;
      return !_hasFatiguedPrimaryMuscle(exercise, recovery);
    }).toList();

    candidates.sort((a, b) {
      final aRecovery = _lowestPrimaryRecovery(a, recovery) ?? 100;
      final bRecovery = _lowestPrimaryRecovery(b, recovery) ?? 100;
      final recoveryCompare = bRecovery.compareTo(aRecovery);
      if (recoveryCompare != 0) return recoveryCompare;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return candidates.take(3).toList(growable: false);
  }

  bool _matchesInitialFilter(Exercise exercise) => switch (initialFilter) {
        ExerciseFilter.all => true,
        ExerciseFilter.custom => exercise.isCustom,
        ExerciseFilter.legs =>
          exercise.tags.contains('leg') || exercise.dayType?.name == 'leg',
        _ => exercise.tags.contains(initialFilter.name) ||
            exercise.dayType?.name == initialFilter.name,
      };

  bool _hasFatiguedPrimaryMuscle(
    Exercise exercise,
    Map<MuscleGroup, MuscleRecoveryState> recovery,
  ) {
    return exercise.muscleTargets
        .where((target) => target.role == MuscleRole.primary)
        .map((target) => recovery[target.muscle]?.level)
        .whereType<RecoveryLevel>()
        .any((level) => level == RecoveryLevel.fatigued);
  }

  double? _lowestPrimaryRecovery(
    Exercise exercise,
    Map<MuscleGroup, MuscleRecoveryState> recovery,
  ) {
    final values = exercise.muscleTargets
        .where((target) => target.role == MuscleRole.primary)
        .map((target) => recovery[target.muscle]?.recoveryPercent)
        .whereType<double>()
        .toList();
    if (values.isEmpty) return null;
    return values.reduce((a, b) => a < b ? a : b);
  }

  Future<void> _logSet(
    BuildContext context,
    WidgetRef ref,
    WorkoutController controller,
    ActiveWorkoutState state,
    bool showRpeRir,
  ) async {
    final rec = state.recommendation;
    final selected = state.selected!;
    final increment = selected.exercise.incrementKg(
        ref.read(activeProfileProvider).valueOrNull
            ?.incrementForEquipment(selected.exercise.equipmentType));
    final lastSet = selected.lastWorkingSet;
    final initialWeight = rec?.recommendedWeightKg ?? lastSet?.weightKg ?? 0;
    final initialReps = rec?.recommendedRepMin ?? lastSet?.reps ?? 8;

    final result = await showSetLogSheet(
      context,
      initialWeight: initialWeight,
      initialReps: initialReps,
      increment: increment,
      showRpeRir: showRpeRir,
    );
    if (result == null) return;
    await controller.logSet(
      weightKg: result.weightKg,
      reps: result.reps,
      isWarmup: result.isWarmup,
      isFailure: result.isFailure,
      rpe: result.rpe,
      rir: result.rir,
      notes: result.notes,
    );

    if (!context.mounted || result.isWarmup) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Logged ${Format.kg(result.weightKg)} × ${result.reps} reps',
        ),
        action: SnackBarAction(
          label: 'Log same again',
          onPressed: () => controller.logSet(
            weightKg: result.weightKg,
            reps: result.reps,
            isFailure: result.isFailure,
            rpe: result.rpe,
            rir: result.rir,
            notes: result.notes,
          ),
        ),
      ),
    );
  }

  Future<void> _repeatLastWorkingSet(
    WorkoutController controller,
    WorkoutSet set,
  ) {
    return controller.logSet(
      weightKg: set.weightKg,
      reps: set.reps,
      isFailure: set.isFailure,
      rpe: set.rpe,
      rir: set.rir,
      notes: set.notes,
    );
  }

  Future<void> _endWorkout(
    BuildContext context,
    WorkoutController controller,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('End workout?'),
        content: const Text('This will finish and save your session.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('End workout')),
        ],
      ),
    );
    if (confirm != true) return;
    final ended = await controller.endWorkout();
    if (context.mounted) context.go('/summary/${ended.id}');
  }
}

class _ActiveExerciseCard extends StatelessWidget {
  const _ActiveExerciseCard({
    required this.view,
    required this.goalSetsLabel,
    required this.completed,
    required this.onSwap,
    required this.onEndExercise,
  });

  final WorkoutExerciseView view;
  final String goalSetsLabel;
  final int completed;
  final VoidCallback onSwap;
  final Future<void> Function() onEndExercise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    view.exercise.name,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: 'Switch exercise',
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: onSwap,
                ),
              ],
            ),
            Text(
              view.exercise.exerciseCategory.label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  size: 18,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text('Working sets: $completed / $goalSetsLabel',
                    style: theme.textTheme.bodyMedium),
                const Spacer(),
                TextButton.icon(
                  onPressed: () async {
                    await onEndExercise();
                  },
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  label: const Text('End exercise'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCompleteSheet extends StatelessWidget {
  const _ExerciseCompleteSheet({
    required this.completed,
    required this.recommendations,
  });

  final WorkoutExerciseView completed;
  final List<Exercise> recommendations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final workingSets = completed.workingSets;
    final totalReps = workingSets.fold<int>(0, (sum, set) => sum + set.reps);
    final volume = workingSets.fold<double>(
      0,
      (sum, set) => sum + (set.weightKg * set.reps),
    );
    final topSet = _topSet(workingSets);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise complete',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(completed.exercise.name, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SummaryChip(
                  label: 'Working sets',
                  value: '${workingSets.length}',
                ),
                _SummaryChip(label: 'Total reps', value: '$totalReps'),
                _SummaryChip(
                  label: 'Top set',
                  value: topSet == null
                      ? '—'
                      : '${Format.kg(topSet.weightKg)} × ${topSet.reps}',
                ),
                _SummaryChip(label: 'Volume', value: Format.kg(volume)),
              ],
            ),
            const SizedBox(height: 20),
            Text('Recommended next', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (recommendations.isEmpty)
              Text(
                'No fresh matches found for this session filter and recovery state.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              )
            else
              for (final exercise in recommendations)
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: exercise.id,
                  groupValue: recommendations.first.id,
                  onChanged: (_) => Navigator.pop(
                    context,
                    _ExerciseCompleteAction.addRecommended(exercise.id),
                  ),
                  title: Text(exercise.name),
                  subtitle: Text(exercise.exerciseCategory.label),
                ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: recommendations.isEmpty
                        ? null
                        : () => Navigator.pop(
                              context,
                              _ExerciseCompleteAction.addRecommended(
                                recommendations.first.id,
                              ),
                            ),
                    icon: const Icon(Icons.add),
                    label: const Text('Add recommended'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(
                      context,
                      const _ExerciseCompleteAction.chooseAnother(),
                    ),
                    child: const Text('Choose another'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(
                      context,
                      const _ExerciseCompleteAction.finishWorkout(),
                    ),
                    child: const Text('Finish workout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  WorkoutSet? _topSet(List<WorkoutSet> sets) {
    if (sets.isEmpty) return null;
    return sets.reduce((a, b) {
      final aScore = a.estimatedOneRepMaxKg ?? a.weightKg * a.reps;
      final bScore = b.estimatedOneRepMaxKg ?? b.weightKg * b.reps;
      return aScore >= bScore ? a : b;
    });
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}

enum _ExerciseCompleteActionType {
  addRecommended,
  chooseAnother,
  finishWorkout,
}

class _ExerciseCompleteAction {
  const _ExerciseCompleteAction._(this.type, [this.exerciseId]);

  const _ExerciseCompleteAction.addRecommended(String exerciseId)
      : this._(_ExerciseCompleteActionType.addRecommended, exerciseId);
  const _ExerciseCompleteAction.chooseAnother()
      : this._(_ExerciseCompleteActionType.chooseAnother);
  const _ExerciseCompleteAction.finishWorkout()
      : this._(_ExerciseCompleteActionType.finishWorkout);

  final _ExerciseCompleteActionType type;
  final String? exerciseId;
}

class _SetsList extends StatelessWidget {
  const _SetsList({required this.sets, required this.onDelete});

  final List<WorkoutSet> sets;
  final void Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    if (sets.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No sets yet. Log your first working set below.'),
        ),
      );
    }
    return Card(
      child: Column(
        children: [
          for (final s in sets)
            ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 16,
                child: Text('${s.setNumber}',
                    style: const TextStyle(fontSize: 13),
                  ),
              ),
              title: Text('${Format.kg(s.weightKg)} × ${s.reps} reps'),
              subtitle: Text(_subtitle(s)),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => onDelete(s.id),
              ),
            ),
        ],
      ),
    );
  }

  String _subtitle(WorkoutSet s) {
    if (s.isWarmup) return 'Warm-up';
    final parts = <String>[];
    if (s.estimatedOneRepMaxKg != null) {
      parts.add('e1RM ${Format.kg(s.estimatedOneRepMaxKg!)}');
    }
    if (s.restBeforeSetSeconds != null) {
      parts.add('rest ${Format.mmss(s.restBeforeSetSeconds!)}');
    }
    if (s.rpe != null) parts.add('RPE ${s.rpe}');
    if (s.rir != null) parts.add('RIR ${s.rir}');
    if (s.isFailure) parts.add('failure');
    return parts.join(' • ');
  }
}
