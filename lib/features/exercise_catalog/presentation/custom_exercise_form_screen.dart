import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../muscle/domain/muscle_target.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/exercise.dart';
import 'exercise_providers.dart';

class CustomExerciseFormScreen extends ConsumerStatefulWidget {
  const CustomExerciseFormScreen({super.key, this.exercise});

  final Exercise? exercise;

  @override
  ConsumerState<CustomExerciseFormScreen> createState() =>
      _CustomExerciseFormScreenState();
}

class _CustomExerciseFormScreenState
    extends ConsumerState<CustomExerciseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _tagsController = TextEditingController();
  final _movementPatternController = TextEditingController();
  final _minRepsController = TextEditingController();
  final _maxRepsController = TextEditingController();
  final _minSetsController = TextEditingController();
  final _maxSetsController = TextEditingController();
  final _uuid = const Uuid();

  DayType _dayType = DayType.push;
  EquipmentType _equipmentType = EquipmentType.dumbbell;
  ExerciseCategory _category = ExerciseCategory.compoundUpper;
  MuscleGroup _primaryMuscle = MuscleGroup.chest;
  final Set<MuscleGroup> _secondaryMuscles = <MuscleGroup>{};
  bool _saving = false;

  bool get _isEditing => widget.exercise != null;

  @override
  void initState() {
    super.initState();
    final exercise = widget.exercise;
    if (exercise == null) return;
    _nameController.text = exercise.name;
    _tagsController.text = exercise.tags.join(', ');
    _movementPatternController.text = exercise.movementPattern;
    _minRepsController.text = exercise.minimumRecommendedReps?.toString() ?? '';
    _maxRepsController.text = exercise.maximumRecommendedReps?.toString() ?? '';
    _minSetsController.text = exercise.recommendedSetRangeMin?.toString() ?? '';
    _maxSetsController.text = exercise.recommendedSetRangeMax?.toString() ?? '';
    _dayType = exercise.dayType ?? DayType.push;
    _equipmentType = exercise.equipmentType;
    _category = exercise.exerciseCategory;
    _primaryMuscle = _muscleFromName(exercise.primaryMuscleGroup) ??
        _firstPrimaryTarget(exercise) ??
        MuscleGroup.chest;
    _secondaryMuscles.addAll(
      exercise.muscleTargets
          .where((target) => target.role == MuscleRole.secondary)
          .map((target) => target.muscle),
    );
    if (_secondaryMuscles.isEmpty) {
      for (final name in exercise.secondaryMuscleGroups) {
        final muscle = _muscleFromName(name);
        if (muscle != null) _secondaryMuscles.add(muscle);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tagsController.dispose();
    _movementPatternController.dispose();
    _minRepsController.dispose();
    _maxRepsController.dispose();
    _minSetsController.dispose();
    _maxSetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit custom exercise' : 'New custom exercise'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Exercise name is required.'
                    : null,
              ),
              const SizedBox(height: 16),
              _DropdownField<DayType>(
                label: 'Day type',
                value: _dayType,
                values: DayType.values,
                labelFor: (value) => value.label,
                onChanged: (value) => setState(() => _dayType = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _DropdownField<EquipmentType>(
                label: 'Equipment type',
                value: _equipmentType,
                values: EquipmentType.values,
                labelFor: (value) => value.label,
                onChanged: (value) => setState(() => _equipmentType = value),
              ),
              const SizedBox(height: 16),
              _DropdownField<ExerciseCategory>(
                label: 'Exercise category',
                value: _category,
                values: ExerciseCategory.values,
                labelFor: (value) => value.label,
                onChanged: (value) => setState(() => _category = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _movementPatternController,
                decoration: const InputDecoration(
                  labelText: 'Movement pattern',
                  hintText: 'e.g. horizontal push, hinge, squat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _DropdownField<MuscleGroup>(
                label: 'Primary muscle',
                value: _primaryMuscle,
                values: MuscleGroup.values,
                labelFor: (value) => value.label,
                onChanged: (value) => setState(() {
                  _primaryMuscle = value;
                  _secondaryMuscles.remove(value);
                }),
              ),
              const SizedBox(height: 16),
              Text('Secondary muscles',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: MuscleGroup.values
                    .where((muscle) => muscle != _primaryMuscle)
                    .map(
                      (muscle) => FilterChip(
                        label: Text(muscle.label),
                        selected: _secondaryMuscles.contains(muscle),
                        onSelected: (selected) => setState(() {
                          if (selected) {
                            _secondaryMuscles.add(muscle);
                          } else {
                            _secondaryMuscles.remove(muscle);
                          }
                        }),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _numberField(_minRepsController, 'Min reps')),
                  const SizedBox(width: 12),
                  Expanded(child: _numberField(_maxRepsController, 'Max reps')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _numberField(_minSetsController, 'Min sets')),
                  const SizedBox(width: 12),
                  Expanded(child: _numberField(_maxSetsController, 'Max sets')),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(_isEditing ? 'Save changes' : 'Create exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _numberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return null;
        final parsed = int.tryParse(value);
        return parsed == null || parsed < 1 ? 'Use a positive number.' : null;
      },
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final profile = ref.read(activeProfileProvider).valueOrNull;
    final profileId = profile?.id;
    final repository = ref.read(exerciseRepositoryProvider);
    final name = _nameController.text.trim();
    final duplicate = await repository.nameExists(
      name,
      userProfileId: profileId,
      excludingId: widget.exercise?.id,
    );
    if (duplicate) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An exercise with this name already exists.')),
      );
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final id = widget.exercise?.id ?? _uuid.v4();
    final secondaries = _secondaryMuscles.toList()
      ..sort((a, b) => a.label.compareTo(b.label));
    final exercise = Exercise(
      id: id,
      name: name,
      userProfileId: profileId,
      dayType: _dayType,
      primaryMuscleGroup: _primaryMuscle.label,
      secondaryMuscleGroups: secondaries.map((muscle) => muscle.label).toList(),
      tags: _tags(),
      muscleTargets: [
        MuscleTarget(muscle: _primaryMuscle, role: MuscleRole.primary),
        for (final muscle in secondaries)
          MuscleTarget(muscle: muscle, role: MuscleRole.secondary),
      ],
      movementPattern: _movementPatternController.text.trim(),
      equipmentType: _equipmentType,
      exerciseCategory: _category,
      isBodyweight: _equipmentType == EquipmentType.bodyweight ||
          _equipmentType == EquipmentType.assistedBodyweight,
      isUnilateral: false,
      minimumRecommendedReps: _parseInt(_minRepsController.text),
      maximumRecommendedReps: _parseInt(_maxRepsController.text),
      recommendedSetRangeMin: _parseInt(_minSetsController.text),
      recommendedSetRangeMax: _parseInt(_maxSetsController.text),
      isCustom: true,
      createdAt: widget.exercise?.createdAt ?? now,
      updatedAt: now,
    );

    if (_isEditing) {
      await repository.updateCustom(exercise);
    } else {
      await repository.createCustom(exercise);
    }
    ref.invalidate(allExercisesProvider);
    if (!mounted) return;
    Navigator.of(context).pop(exercise);
  }

  List<String> _tags() {
    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .toSet();
    tags.add(_dayType.name);
    return tags.toList()..sort();
  }

  int? _parseInt(String value) => int.tryParse(value.trim());

  MuscleGroup? _firstPrimaryTarget(Exercise exercise) {
    for (final target in exercise.muscleTargets) {
      if (target.role == MuscleRole.primary) return target.muscle;
    }
    return null;
  }

  MuscleGroup? _muscleFromName(String value) {
    final normalized = value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    for (final muscle in MuscleGroup.values) {
      if (muscle.label.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '') ==
              normalized ||
          muscle.name.toLowerCase() == normalized) {
        return muscle;
      }
    }
    return null;
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.values,
    required this.labelFor,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> values;
  final String Function(T value) labelFor;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(labelFor(value)),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
