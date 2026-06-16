import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums.dart';
import '../../muscle/domain/muscle_recovery.dart';
import '../../workout/presentation/session_providers.dart';
import '../domain/exercise.dart';
import 'exercise_providers.dart';

enum ExerciseFilter {
  all('All'),
  push('Push'),
  pull('Pull'),
  legs('Legs'),
  upper('Upper'),
  lower('Lower'),
  core('Core'),
  custom('Custom');

  const ExerciseFilter(this.label);
  final String label;
}

class ExerciseListScreen extends ConsumerStatefulWidget {
  const ExerciseListScreen({
    super.key,
    this.initialFilter = ExerciseFilter.all,
    this.pickMode = false,
  });

  final ExerciseFilter initialFilter;
  final bool pickMode;

  @override
  ConsumerState<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends ConsumerState<ExerciseListScreen> {
  late ExerciseFilter _filter = widget.initialFilter;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ref.watch(allExercisesProvider);
    final recovery = ref.watch(recoveryByMuscleProvider).valueOrNull ?? const <MuscleGroup, MuscleRecoveryState>{};

    return Scaffold(
      appBar: AppBar(title: Text(widget.pickMode ? 'Add exercise' : 'Exercises')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search exercises',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                final f = ExerciseFilter.values[i];
                return ChoiceChip(
                  label: Text(f.label),
                  selected: f == _filter,
                  onSelected: (_) => setState(() => _filter = f),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: ExerciseFilter.values.length,
            ),
          ),
          Expanded(
            child: exercises.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (list) {
                final filtered = list.where(_matches).toList();
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (_, i) => _ExerciseTile(
                    exercise: filtered[i],
                    recoveryByMuscle: recovery,
                    onTap: () {
                      if (widget.pickMode) {
                        Navigator.of(context).pop(filtered[i].id);
                      } else {
                        _showInfo(context, filtered[i]);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _matches(Exercise e) {
    final matchesFilter = switch (_filter) {
      ExerciseFilter.all => true,
      ExerciseFilter.custom => e.isCustom,
      ExerciseFilter.legs => e.tags.contains('leg') || e.dayType?.name == 'leg',
      _ => e.tags.contains(_filter.name) || e.dayType?.name == _filter.name,
    };
    if (!matchesFilter) return false;

    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;

    return e.name.toLowerCase().contains(query) ||
        e.equipmentType.label.toLowerCase().contains(query) ||
        e.equipmentType.name.toLowerCase().contains(query) ||
        e.primaryMuscleGroup.toLowerCase().contains(query) ||
        e.movementPattern.toLowerCase().contains(query) ||
        e.tags.any((tag) => tag.toLowerCase().contains(query));
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
            if (e.muscleTargets.isNotEmpty)
              _info('Impact targets', e.muscleTargets.map((t) => '${t.muscle.label} (${t.role.label})').join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _info(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 130, child: Text(k, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(v)),
        ]),
      );
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise, required this.onTap, required this.recoveryByMuscle});

  final Exercise exercise;
  final VoidCallback onTap;
  final Map<MuscleGroup, MuscleRecoveryState> recoveryByMuscle;

  @override
  Widget build(BuildContext context) {
    final primary = exercise.muscleTargets.where((t) => t.role == MuscleRole.primary).map((t) => t.muscle).toList();
    final fatigue = primary.map((m) => recoveryByMuscle[m]).whereType<MuscleRecoveryState>().where((r) => r.recoveryPercent < 35).toList();
    final statuses = primary.map((m) {
      final r = recoveryByMuscle[m];
      return r == null ? m.label : '${m.label}: ${r.level.label}';
    }).join(' • ');
    return Card(
      child: ListTile(
        leading: fatigue.isEmpty ? null : const Icon(Icons.warning_amber_rounded, color: Colors.orange),
        title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(statuses.isEmpty ? '${exercise.primaryMuscleGroup} • ${exercise.equipmentType.label}' : statuses),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
