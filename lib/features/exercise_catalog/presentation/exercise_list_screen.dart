import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/exercise.dart';
import 'exercise_providers.dart';

class ExerciseListScreen extends ConsumerWidget {
  const ExerciseListScreen({
    super.key,
    required this.dayType,
    this.pickMode = false,
  });

  final DayType dayType;

  /// When true, tapping an exercise returns it via [Navigator.pop].
  final bool pickMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesByDayProvider(dayType));

    return Scaffold(
      appBar: AppBar(
        title: Text(pickMode ? 'Add exercise' : dayType.label),
      ),
      floatingActionButton: pickMode
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _startWorkout(context, ref),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
            ),
      body: exercises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (_, i) => _ExerciseTile(
            exercise: list[i],
            onTap: () {
              if (pickMode) {
                Navigator.of(context).pop(list[i].id);
              } else {
                _showInfo(context, list[i]);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _startWorkout(BuildContext context, WidgetRef ref) async {
    final profile = ref.read(activeProfileProvider).valueOrNull;
    if (profile == null) return;
    final session = await ref
        .read(workoutRepositoryProvider)
        .startSession(userProfileId: profile.id, dayType: dayType);
    if (context.mounted) context.go('/workout/${session.id}');
  }

  void _showInfo(BuildContext context, Exercise e) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            _info('Primary muscle', e.primaryMuscleGroup),
            if (e.secondaryMuscleGroups.isNotEmpty)
              _info('Secondary', e.secondaryMuscleGroups.join(', ')),
            _info('Pattern', e.movementPattern),
            _info('Equipment', e.equipmentType.label),
            if (e.isBodyweight) _info('Type', 'Bodyweight'),
            if (e.isUnilateral) _info('Unilateral', 'Yes'),
          ],
        ),
      ),
    );
  }

  Widget _info(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 130,
                child: Text(k,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: Text(v)),
          ],
        ),
      );
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise, required this.onTap});

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(exercise.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
            '${exercise.primaryMuscleGroup} • ${exercise.equipmentType.label}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
