import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/enums.dart';
import '../../domain/user_profile.dart';

/// Result emitted by the profile form.
class ProfileFormData {
  ProfileFormData({
    required this.name,
    this.age,
    this.sex,
    this.heightCm,
    this.bodyWeightKg,
    required this.experience,
    required this.goal,
    required this.incrementKg,
    required this.restTimerEnabled,
  });

  final String name;
  final int? age;
  final String? sex;
  final double? heightCm;
  final double? bodyWeightKg;
  final TrainingExperience experience;
  final TrainingGoal goal;
  final double incrementKg;
  final bool restTimerEnabled;
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    super.key,
    this.initial,
    required this.submitLabel,
    required this.onSubmit,
  });

  final UserProfile? initial;
  final String submitLabel;
  final void Function(ProfileFormData data) onSubmit;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _age;
  late final TextEditingController _height;
  late final TextEditingController _weight;

  String? _sex;
  late TrainingExperience _experience;
  late TrainingGoal _goal;
  late double _increment;
  late bool _restEnabled;

  static const _incrementOptions = [0.5, 1.0, 2.0, 2.5, 5.0];

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _name = TextEditingController(text: p?.name ?? '');
    _age = TextEditingController(text: p?.age?.toString() ?? '');
    _height = TextEditingController(text: p?.heightCm?.toString() ?? '');
    _weight = TextEditingController(text: p?.bodyWeightKg?.toString() ?? '');
    _sex = p?.sex;
    _experience = p?.trainingExperience ?? TrainingExperience.beginner;
    _goal = p?.primaryGoal ?? TrainingGoal.hypertrophy;
    _increment = p?.preferredWeightIncrementKg ?? AppConstants.defaultIncrementKg;
    _restEnabled = p?.restTimerEnabled ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(ProfileFormData(
      name: _name.text.trim(),
      age: int.tryParse(_age.text),
      sex: _sex,
      heightCm: double.tryParse(_height.text),
      bodyWeightKg: double.tryParse(_weight.text),
      experience: _experience,
      goal: _goal,
      incrementKg: _increment,
      restTimerEnabled: _restEnabled,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _TrainingTermsCard(),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Name *',
              hintText: 'Your name',
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name is required' : null,
          ),
          const SizedBox(height: 16),
          Text('Training goal', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          RadioGroup<TrainingGoal>(
            groupValue: _goal,
            onChanged: (v) => setState(() => _goal = v!),
            child: Column(
              children: TrainingGoal.values
                  .map((g) => RadioListTile<TrainingGoal>(
                        value: g,
                        title: Text(g.label),
                        contentPadding: EdgeInsets.zero,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<TrainingExperience>(
            initialValue: _experience,
            decoration: const InputDecoration(labelText: 'Experience'),
            items: TrainingExperience.values
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.label)))
                .toList(),
            onChanged: (v) => setState(() => _experience = v!),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _sex,
                  decoration: const InputDecoration(labelText: 'Sex'),
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (v) => setState(() => _sex = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _height,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _weight,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Body weight (kg)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<double>(
            initialValue: _increment,
            decoration:
                const InputDecoration(labelText: 'Preferred weight increment'),
            items: _incrementOptions
                .map((v) => DropdownMenuItem(
                    value: v, child: Text('${v.toString()} kg')))
                .toList(),
            onChanged: (v) => setState(() => _increment = v!),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: _restEnabled,
            onChanged: (v) => setState(() => _restEnabled = v),
            title: const Text('Auto-start rest timer'),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _submit, child: Text(widget.submitLabel)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TrainingTermsCard extends StatelessWidget {
  const _TrainingTermsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick terms',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _TermChip(
                  label: 'RPE',
                  message:
                      'Rate of Perceived Exertion: how hard a set felt, usually from 1–10.',
                ),
                _TermChip(
                  label: 'RIR',
                  message:
                      'Reps in Reserve: how many more good reps you could have done.',
                ),
                _TermChip(
                  label: 'e1RM',
                  message:
                      'Estimated one-rep max calculated from your logged weight and reps.',
                ),
                _TermChip(
                  label: 'recovery %',
                  message:
                      'An estimate of how ready a muscle is based on recent training fatigue.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TermChip extends StatelessWidget {
  const _TermChip({
    required this.label,
    required this.message,
  });

  final String label;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      child: Chip(
        label: Text(label),
        avatar: const Icon(Icons.info_outline, size: 18),
      ),
    );
  }
}
