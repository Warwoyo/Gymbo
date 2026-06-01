import 'package:flutter/material.dart';

import '../../../core/widgets/stepper_field.dart';

class SetLogResult {
  SetLogResult({
    required this.weightKg,
    required this.reps,
    required this.isWarmup,
    required this.isFailure,
    this.rpe,
    this.rir,
    this.notes,
  });

  final double weightKg;
  final int reps;
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
}) {
  return showModalBottomSheet<SetLogResult>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _SetLogSheet(
      initialWeight: initialWeight,
      initialReps: initialReps,
      increment: increment,
    ),
  );
}

class _SetLogSheet extends StatefulWidget {
  const _SetLogSheet({
    required this.initialWeight,
    required this.initialReps,
    required this.increment,
  });

  final double initialWeight;
  final int initialReps;
  final double increment;

  @override
  State<_SetLogSheet> createState() => _SetLogSheetState();
}

class _SetLogSheetState extends State<_SetLogSheet> {
  late final TextEditingController _weight;
  late final TextEditingController _reps;
  late final TextEditingController _rpe;
  late final TextEditingController _notes;
  bool _warmup = false;
  bool _failure = false;
  bool _showExtras = false;

  @override
  void initState() {
    super.initState();
    final w = widget.initialWeight;
    _weight = TextEditingController(
        text: w <= 0 ? '' : (w == w.roundToDouble() ? w.toStringAsFixed(0) : '$w'));
    _reps = TextEditingController(text: widget.initialReps.toString());
    _rpe = TextEditingController();
    _notes = TextEditingController();
  }

  @override
  void dispose() {
    _weight.dispose();
    _reps.dispose();
    _rpe.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    final weight = double.tryParse(_weight.text) ?? 0;
    final reps = int.tryParse(_reps.text) ?? 0;
    if (reps < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least 1 rep')),
      );
      return;
    }
    Navigator.of(context).pop(SetLogResult(
      weightKg: weight,
      reps: reps,
      isWarmup: _warmup,
      isFailure: _failure,
      rpe: double.tryParse(_rpe.text),
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
            StepperField(
              label: 'Weight',
              controller: _weight,
              step: widget.increment,
              suffix: 'kg',
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
              child: Text(_showExtras ? 'Hide details' : 'More details (RPE, notes)'),
            ),
            if (_showExtras) ...[
              TextField(
                controller: _rpe,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: 'RPE (optional)', hintText: '1-10'),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _failure,
                onChanged: (v) => setState(() => _failure = v),
                title: const Text('Taken to failure'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _notes,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
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
