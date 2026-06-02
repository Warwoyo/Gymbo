import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums.dart';
import '../../../core/utils/formatting.dart';
import '../../exercise_catalog/presentation/exercise_list_screen.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../recommendations/domain/category_defaults.dart';
import '../../recommendations/presentation/recommendation_card.dart';
import '../domain/workout_set.dart';
import 'rest_timer_widget.dart';
import 'set_log_sheet.dart';
import 'workout_controller.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key, required this.sessionId, this.initialFilter = ExerciseFilter.all});

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
          data: (s) => Text(s.session.sessionName ?? s.session.dayType?.label ?? 'Workout'),
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
                            selected, profile?.primaryGoal ?? TrainingGoal.hypertrophy),
                        completed: selected.workingSets.length,
                        onSwap: () => _pickExercise(context, ref, state),
                        onEndExercise: () => controller.endExercise(),
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

  Future<void> _logSet(BuildContext context, WidgetRef ref,
      WorkoutController controller, ActiveWorkoutState state, bool showRpeRir) async {
    final rec = state.recommendation;
    final selected = state.selected!;
    final increment = selected.exercise.incrementKg(
        ref.read(activeProfileProvider).valueOrNull
            ?.incrementForEquipment(selected.exercise.equipmentType));
    final lastSet = selected.lastWorkingSet;
    final initialWeight =
        rec?.recommendedWeightKg ?? lastSet?.weightKg ?? 0;
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
  }

  Future<void> _endWorkout(
      BuildContext context, WorkoutController controller) async {
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
  final VoidCallback onEndExercise;

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
                  child: Text(view.exercise.name,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  tooltip: 'Switch exercise',
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: onSwap,
                ),
              ],
            ),
            Text(view.exercise.exerciseCategory.label,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.checklist, size: 18, color: theme.colorScheme.outline),
                const SizedBox(width: 6),
                Text('Working sets: $completed / $goalSetsLabel',
                    style: theme.textTheme.bodyMedium),
                const Spacer(),
                TextButton.icon(
                  onPressed: onEndExercise,
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
                    style: const TextStyle(fontSize: 13)),
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
