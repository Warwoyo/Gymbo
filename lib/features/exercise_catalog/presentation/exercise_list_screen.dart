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
  EquipmentType? _equipmentFilter;
  MuscleGroup? _muscleFilter;
  RecoveryLevel? _recoveryFilter;
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
    final recovery = ref.watch(recoveryByMuscleProvider).valueOrNull ??
        const <MuscleGroup, MuscleRecoveryState>{};

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pickMode ? 'Add exercise' : 'Exercises'),
      ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: _ActiveFilterChips(
                    filters: _activeFilterLabels,
                    onClearAll: _clearFilters,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _showFilterSheet,
                  icon: const Icon(Icons.tune),
                  label: const Text('Filter'),
                ),
              ],
            ),
          ),
          Expanded(
            child: exercises.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (list) {
                final filtered =
                    list.where((e) => _matches(e, recovery)).toList();
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

  bool _matches(
    Exercise e,
    Map<MuscleGroup, MuscleRecoveryState> recoveryByMuscle,
  ) {
    final matchesSplit = switch (_filter) {
      ExerciseFilter.all => true,
      ExerciseFilter.custom => e.isCustom,
      ExerciseFilter.legs => e.tags.contains('leg') || e.dayType?.name == 'leg',
      _ => e.tags.contains(_filter.name) || e.dayType?.name == _filter.name,
    };
    if (!matchesSplit) return false;

    if (_equipmentFilter != null && e.equipmentType != _equipmentFilter) {
      return false;
    }

    if (_muscleFilter != null && !_targetsMuscle(e, _muscleFilter!)) return false;

    if (_recoveryFilter != null) {
      final levels = _targetMuscles(e)
          .map((m) => recoveryByMuscle[m]?.level)
          .whereType<RecoveryLevel>();
      if (!levels.contains(_recoveryFilter)) return false;
    }

    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;

    return e.name.toLowerCase().contains(query) ||
        e.equipmentType.label.toLowerCase().contains(query) ||
        e.equipmentType.name.toLowerCase().contains(query) ||
        e.primaryMuscleGroup.toLowerCase().contains(query) ||
        e.movementPattern.toLowerCase().contains(query) ||
        e.tags.any((tag) => tag.toLowerCase().contains(query));
  }

  List<String> get _activeFilterLabels => [
        if (_filter != ExerciseFilter.all) 'Split: ${_filter.label}',
        if (_equipmentFilter != null) 'Equipment: ${_equipmentFilter!.label}',
        if (_muscleFilter != null) 'Muscle: ${_muscleFilter!.label}',
        if (_recoveryFilter != null) 'Recovery: ${_recoveryFilter!.label}',
      ];

  void _clearFilters() => setState(() {
        _filter = ExerciseFilter.all;
        _equipmentFilter = null;
        _muscleFilter = null;
        _recoveryFilter = null;
      });

  bool _targetsMuscle(Exercise e, MuscleGroup muscle) {
    final normalizedFilter = _normalize(muscle.label);
    return e.muscleTargets.any((target) => target.muscle == muscle) ||
        _normalize(e.primaryMuscleGroup) == normalizedFilter ||
        e.secondaryMuscleGroups
            .any((group) => _normalize(group) == normalizedFilter);
  }

  Iterable<MuscleGroup> _targetMuscles(Exercise e) sync* {
    if (e.muscleTargets.isNotEmpty) {
      yield* e.muscleTargets.map((target) => target.muscle);
      return;
    }

    for (final muscle in MuscleGroup.values) {
      if (_targetsMuscle(e, muscle)) yield muscle;
    }
  }

  String _normalize(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

  Future<void> _showFilterSheet() async {
    var selectedSplit = _filter;
    var selectedEquipment = _equipmentFilter;
    var selectedMuscle = _muscleFilter;
    var selectedRecovery = _recoveryFilter;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filter exercises',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _FilterSection<ExerciseFilter>(
                  title: 'Split',
                  values: ExerciseFilter.values,
                  selected: selectedSplit,
                  labelFor: (value) => value.label,
                  onSelected: (value) =>
                      setSheetState(() => selectedSplit = value),
                ),
                _FilterSection<EquipmentType>(
                  title: 'Equipment',
                  values: EquipmentType.values,
                  selected: selectedEquipment,
                  labelFor: (value) => value.label,
                  onSelected: (value) => setSheetState(
                    () => selectedEquipment =
                        selectedEquipment == value ? null : value,
                  ),
                ),
                _FilterSection<MuscleGroup>(
                  title: 'Muscle group',
                  values: MuscleGroup.values,
                  selected: selectedMuscle,
                  labelFor: (value) => value.label,
                  onSelected: (value) => setSheetState(
                    () => selectedMuscle = selectedMuscle == value ? null : value,
                  ),
                ),
                _FilterSection<RecoveryLevel>(
                  title: 'Recovery status',
                  values: RecoveryLevel.values,
                  selected: selectedRecovery,
                  labelFor: (value) => value.label,
                  onSelected: (value) => setSheetState(
                    () => selectedRecovery =
                        selectedRecovery == value ? null : value,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setSheetState(() {
                        selectedSplit = ExerciseFilter.all;
                        selectedEquipment = null;
                        selectedMuscle = null;
                        selectedRecovery = null;
                      }),
                      child: const Text('Clear all'),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _filter = selectedSplit;
                          _equipmentFilter = selectedEquipment;
                          _muscleFilter = selectedMuscle;
                          _recoveryFilter = selectedRecovery;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              _info(
                'Impact targets',
                e.muscleTargets
                    .map((t) => '${t.muscle.label} (${t.role.label})')
                    .join(', '),
              ),
          ],
        ),
      ),
    );
  }

  Widget _info(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 130,
            child: Text(
              k,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(v)),
        ]),
      );
}

class _ActiveFilterChips extends StatelessWidget {
  const _ActiveFilterChips({required this.filters, required this.onClearAll});

  final List<String> filters;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) {
      return const Text('All exercises', style: TextStyle(color: Colors.grey));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            Chip(label: Text(filter), visualDensity: VisualDensity.compact),
            const SizedBox(width: 6),
          ],
          ActionChip(
            label: const Text('Clear'),
            visualDensity: VisualDensity.compact,
            onPressed: onClearAll,
          ),
        ],
      ),
    );
  }
}

class _FilterSection<T> extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.values,
    required this.selected,
    required this.labelFor,
    required this.onSelected,
  });

  final String title;
  final List<T> values;
  final T? selected;
  final String Function(T value) labelFor;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: values
                .map(
                  (value) => ChoiceChip(
                    label: Text(labelFor(value)),
                    selected: value == selected,
                    onSelected: (_) => onSelected(value),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({
    required this.exercise,
    required this.onTap,
    required this.recoveryByMuscle,
  });

  final Exercise exercise;
  final VoidCallback onTap;
  final Map<MuscleGroup, MuscleRecoveryState> recoveryByMuscle;

  @override
  Widget build(BuildContext context) {
    final primary = exercise.muscleTargets
        .where((t) => t.role == MuscleRole.primary)
        .map((t) => t.muscle)
        .toList();
    final fatigue = primary
        .map((m) => recoveryByMuscle[m])
        .whereType<MuscleRecoveryState>()
        .where((r) => r.recoveryPercent < 35)
        .toList();
    final statuses = primary.map((m) {
      final r = recoveryByMuscle[m];
      return r == null ? m.label : '${m.label}: ${r.level.label}';
    }).join(' • ');
    return Card(
      child: ListTile(
        leading: fatigue.isEmpty
            ? null
            : const Icon(Icons.warning_amber_rounded, color: Colors.orange),
        title: Text(
          exercise.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          statuses.isEmpty
              ? '${exercise.primaryMuscleGroup} • ${exercise.equipmentType.label}'
              : statuses,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
