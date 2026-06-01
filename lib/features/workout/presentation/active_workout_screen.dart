import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatting.dart';
import '../../exercise_catalog/presentation/exercise_list_screen.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../recommendations/presentation/recommendation_card.dart';
import '../domain/workout_set.dart';
import 'rest_timer_widget.dart';
import 'set_log_sheet.dart';
import 'workout_controller.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(activeWorkoutProvider(sessionId));
    final controller = ref.read(activeWorkoutProvider(sessionId).notifier);
    final increment = ref.watch(activeProfileProvider).valueOrNull
            ?.preferredWeightIncrementKg ??
        AppConstants.defaultIncrementKg;

    return Scaffold(
      appBar: AppBar(
        title: asyncState.maybeWhen(
          data: (s) => Text(s.session.dayType.label),
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
                    // Exercise selector.
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text(
                          selected?.exercise.name ?? 'Select an exercise',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${state.exercises.length} exercise(s) this session',
                        ),
                        trailing: const Icon(Icons.swap_horiz),
                        onTap: () => _pickExercise(context, ref, state),
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (selected == null)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text('Add an exercise to start logging sets.'),
                        ),
                      )
                    else ...[
                      _SetsList(sets: selected.sets, onDelete: (id) {
                        controller.deleteSet(id);
                      }),
                      const SizedBox(height: 12),
                      if (state.recommendation != null)
                        RecommendationCard(view: state.recommendation!),
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
                onPressed: () => _logSet(context, ref, controller, increment),
                icon: const Icon(Icons.add),
                label: const Text('Log set'),
              ),
        orElse: () => null,
      ),
    );
  }

  Future<void> _pickExercise(
      BuildContext context, WidgetRef ref, ActiveWorkoutState state) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) =>
            ExerciseListScreen(dayType: state.session.dayType, pickMode: true),
      ),
    );
    if (result != null) {
      await ref
          .read(activeWorkoutProvider(sessionId).notifier)
          .selectExercise(result);
    }
  }

  Future<void> _logSet(BuildContext context, WidgetRef ref,
      WorkoutController controller, double increment) async {
    final state = ref.read(activeWorkoutProvider(sessionId)).valueOrNull;
    final rec = state?.recommendation;
    final lastSet = state?.selected?.lastWorkingSet;
    final initialWeight = rec?.finalLoadKg ?? lastSet?.weightKg ?? 0;
    final initialReps = rec?.recommendation.targetReps ?? lastSet?.reps ?? 8;

    final result = await showSetLogSheet(
      context,
      initialWeight: initialWeight,
      initialReps: initialReps,
      increment: increment,
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
              subtitle: s.isWarmup
                  ? const Text('Warm-up')
                  : (s.estimatedOneRepMaxKg != null
                      ? Text('e1RM ${Format.kg(s.estimatedOneRepMaxKg!)}')
                      : null),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => onDelete(s.id),
              ),
            ),
        ],
      ),
    );
  }
}
