import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../profile/presentation/profile_controller.dart';
import 'template_providers.dart';

class TemplateEditorScreen extends ConsumerStatefulWidget {
  const TemplateEditorScreen({super.key});

  @override
  ConsumerState<TemplateEditorScreen> createState() => _TemplateEditorScreenState();
}

class _TemplateEditorScreenState extends ConsumerState<TemplateEditorScreen> {
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  DayType? _dayType;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create template')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Template name'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<DayType?>(
            value: _dayType,
            decoration: const InputDecoration(labelText: 'Split'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Any split')),
              ...DayType.values.map((d) => DropdownMenuItem(value: d, child: Text(d.label))),
            ],
            onChanged: (value) => setState(() => _dayType = value),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes'),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: _saving
                ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.save_outlined),
            label: const Text('Save template'),
          ),
          const SizedBox(height: 8),
          Text(
            'Add exercises by saving a completed workout as a template from the workout summary.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final profile = ref.read(activeProfileProvider).valueOrNull;
    if (profile == null) return;
    setState(() => _saving = true);
    final template = await ref.read(workoutTemplateRepositoryProvider).createTemplate(
          userProfileId: profile.id,
          name: _nameController.text,
          dayType: _dayType,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );
    ref.invalidate(workoutTemplatesProvider);
    if (mounted) context.go('/templates/${template.id}');
  }
}
