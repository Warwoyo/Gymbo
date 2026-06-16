import 'package:flutter/material.dart';

import '../../../core/enums.dart';
import '../../../core/widgets/stepper_field.dart';
import '../../exercise_catalog/domain/exercise.dart';
import '../domain/workout_set.dart';

class SetLogResult {
  SetLogResult({
    required this.weightKg,
    required this.reps,
    required this.loadType,
    required this.isWarmup,
    required this.isFailure,
    this.rpe,
    this.rir,
    this.notes,
  });

  final double weightKg;
  final int reps;
  final WorkoutSetLoadType loadType;
  final bool isWarmup;
  final bool isFailure;
  final double? rpe;
  final int? rir;
  final String? notes;
}

/// Shows the set-logging form and returns the entered set, or null if cancelled.
Future<SetLogResult?> showSetLogSheet(
  BuildContext context, {
  required double initialWeight,
  required int initialReps,
  required double increment,
  required Exercise exercise,
  bool showRpeRir = true,
}) {
  return showModalBottomSheet<SetLogResult>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _SetLogSheet(
      initialWeight: initialWeight,
      initialReps: initialReps,
      increment: increment,
      exercise: exercise,
      showRpeRir: showRpeRir,
    ),
  );
}

class _SetLogSheet extends StatefulWidget {
  const _SetLogSheet({
    required this.initialWeight,
    required this.initialReps,
    required this.increment,
    required this.exercise,
    required this.showRpeRir,
  });

  final double initialWeight;
  final int initialReps;
  final double increment;
  final Exercise exercise;
  final bool showRpeRir;

  @override
  State<_SetLogSheet> createState() => _SetLogSheetState();
}

class _SetLogSheetState extends State<_SetLogSheet> {
  late final TextEditingController _weight;
  late final TextEditingController _reps;
  late final TextEditingController _rpe;
  late final TextEditingController _rir;
  late final TextEditingController _notes;
  late WorkoutSetLoadType _loadType;
  bool _warmup = false;
  bool _failure = false;
  bool _showExtras = false;

  @override
  void initState() {
    super.initState();
    final w = widget.initialWeight;
    _weight = TextEditingController(
      text: w <= 0
          ? ''
          : (w == w.roundToDouble() ? w.toStringAsFixed(0) : '$w'),
    );
    _reps = TextEditingController(text: widget.initialReps.toString());
    _rpe = TextEditingController();
    _rir = TextEditingController();
    _notes = TextEditingController();
    _loadType = _defaultLoadType();
  }

  @override
  void dispose() {
    _weight.dispose();
    _reps.dispose();
    _rpe.dispose();
    _rir.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  WorkoutSetLoadType _defaultLoadType() {
    final equipmentType = widget.exercise.equipmentType;
    final exerciseCategory = widget.exercise.exerciseCategory;
    if (equipmentType == EquipmentType.assistedBodyweight ||
        exerciseCategory == ExerciseCategory.assistedBodyweight) {
      return WorkoutSetLoadType.assistance;
    }
    if (equipmentType == EquipmentType.bodyweight ||
        exerciseCategory == ExerciseCategory.bodyweight ||
        exerciseCategory == ExerciseCategory.core) {
      return WorkoutSetLoadType.bodyweight;
    }
    if (equipmentType == EquipmentType.machine ||
        equipmentType == EquipmentType.cable ||
        equipmentType == EquipmentType.smithMachine ||
        equipmentType == EquipmentType.plateLoaded) {
      return WorkoutSetLoadType.machineStack;
    }
    return WorkoutSetLoadType.externalLoad;
  }

  bool get _canChooseLoadType {
    final equipmentType = widget.exercise.equipmentType;
    final exerciseCategory = widget.exercise.exerciseCategory;
    return equipmentType == EquipmentType.assistedBodyweight ||
        equipmentType == EquipmentType.bodyweight ||
        exerciseCategory == ExerciseCategory.assistedBodyweight ||
        exerciseCategory == ExerciseCategory.bodyweight ||
        exerciseCategory == ExerciseCategory.core;
  }

  List<WorkoutSetLoadType> get _loadTypeOptions {
    if (!_canChooseLoadType) return [_loadType];
    return const [
      WorkoutSetLoadType.bodyweight,
      WorkoutSetLoadType.externalLoad,
      WorkoutSetLoadType.assistance,
    ];
  }

  String? _weightHelperText() {
    final equipmentType = widget.exercise.equipmentType;
    final exerciseCategory = widget.exercise.exerciseCategory;

    if (_loadType == WorkoutSetLoadType.bodyweight) {
      return 'Use 0 kg for bodyweight only.';
    }
    if (_loadType == WorkoutSetLoadType.assistance) {
      return 'Enter assistance weight. Lower is harder.';
    }
    if (_loadType == WorkoutSetLoadType.externalLoad && _canChooseLoadType) {
      return 'Enter added external load; 0 kg means bodyweight only.';
    }
    if (equipmentType == EquipmentType.dumbbell) {
      return 'Enter weight per hand.';
    }
    if (equipmentType == EquipmentType.assistedBodyweight ||
        exerciseCategory == ExerciseCategory.assistedBodyweight) {
      return 'Enter assistance weight. Lower is harder.';
    }
    if (equipmentType == EquipmentType.bodyweight ||
        exerciseCategory == ExerciseCategory.bodyweight ||
        exerciseCategory == ExerciseCategory.core) {
      return 'Use 0 kg for bodyweight only, or added load if weighted.';
    }
    if (equipmentType == EquipmentType.machine ||
        equipmentType == EquipmentType.cable ||
        equipmentType == EquipmentType.smithMachine ||
        equipmentType == EquipmentType.plateLoaded) {
      return 'Enter stack weight shown on the machine.';
    }

    return null;
  }

  void _save() {
    final weight = double.tryParse(_weight.text) ?? -1;
    final reps = int.tryParse(_reps.text) ?? 0;

    if (weight < 0) {
      _error('Enter a valid weight (0 or more).');
      return;
    }
    if (reps < 1 || reps > 50) {
      _error('Reps must be between 1 and 50.');
      return;
    }

    double? rpe;
    if (_rpe.text.trim().isNotEmpty) {
      rpe = double.tryParse(_rpe.text);
      if (rpe == null || rpe < 1 || rpe > 10) {
        _error('RPE must be between 1 and 10.');
        return;
      }
    }
    int? rir;
    if (_rir.text.trim().isNotEmpty) {
      rir = int.tryParse(_rir.text);
      if (rir == null || rir < 0 || rir > 10) {
        _error('RIR must be between 0 and 10.');
        return;
      }
    }

    Navigator.of(context).pop(SetLogResult(
      weightKg: weight,
      reps: reps,
      loadType: _loadType,
      isWarmup: _warmup,
      isFailure: _failure,
      rpe: rpe,
      rir: rir,
      notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20 + bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Log set', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            if (_canChooseLoadType) ...[
              SegmentedButton<WorkoutSetLoadType>(
                segments: [
                  for (final type in _loadTypeOptions)
                    ButtonSegment(
                      value: type,
                      label: Text(type.label),
                    ),
                ],
                selected: {_loadType},
                onSelectionChanged: (value) =>
                    setState(() => _loadType = value.single),
              ),
              const SizedBox(height: 12),
            ],
            StepperField(
              label: 'Weight',
              controller: _weight,
              step: widget.increment,
              suffix: 'kg',
              helperText: _weightHelperText(),
            ),
            const SizedBox(height: 16),
            StepperField(
              label: 'Reps',
              controller: _reps,
              step: 1,
              allowDecimal: false,
              min: 0,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              value: _warmup,
              onChanged: (v) => setState(() => _warmup = v),
              title: const Text('Warm-up set'),
              subtitle: const Text('Excluded from recommendations & volume'),
              contentPadding: EdgeInsets.zero,
            ),
            TextButton(
              onPressed: () => setState(() => _showExtras = !_showExtras),
              child: Text(_showExtras
                  ? 'Hide details'
                  : 'More details (effort, notes)'),
            ),
            if (_showExtras) ...[
              if (widget.showRpeRir)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _rpe,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                            labelText: 'RPE', hintText: '1-10'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _rir,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'RIR', hintText: '0-10'),
                      ),
                    ),
                  ],
                ),
              if (widget.showRpeRir) const SizedBox(height: 4),
              SwitchListTile(
                value: _failure,
                onChanged: (v) => setState(() => _failure = v),
                title: const Text('Taken to failure'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _notes,
                decoration:
                    const InputDecoration(labelText: 'Notes (optional)'),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: const Text('Save set'),
            ),
          ],
        ),
      ),
    );
  }
}
