import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../workout/presentation/session_providers.dart';
import 'template_providers.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(workoutTemplateProvider(templateId));
    final exercises = ref.watch(workoutTemplateExercisesProvider(templateId));
    return Scaffold(
      appBar: AppBar(title: const Text('Template detail')),
      body: template.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (template) {
          if (template == null) return const Center(child: Text('Template not found'));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(template.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(template.dayType?.label ?? 'Any split'),
              if (template.notes != null) ...[
                const SizedBox(height: 12),
                Text(template.notes!),
              ],
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start from template'),
                onPressed: () => _start(context, ref),
              ),
              const SizedBox(height: 16),
              Text('Exercises', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              exercises.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('$e'),
                data: (items) => items.isEmpty
                    ? const Text('No exercises saved in this template yet.')
                    : Column(
                        children: [
                          for (final item in items)
                            FutureBuilder(
                              future: ref.read(exerciseRepositoryProvider).getById(item.exerciseId),
                              builder: (context, snapshot) => Card(
                                child: ListTile(
                                  leading: CircleAvatar(child: Text('${item.orderIndex + 1}')),
                                  title: Text(snapshot.data?.name ?? 'Exercise'),
                                  subtitle: item.notes == null ? null : Text(item.notes!),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    final profile = ref.read(activeProfileProvider).valueOrNull;
    if (profile == null) return;
    final session = await ref.read(workoutTemplateRepositoryProvider).startSessionFromTemplate(
          userProfileId: profile.id,
          templateId: templateId,
        );
    ref.invalidate(activeSessionProvider);
    ref.invalidate(lastFinishedSessionProvider);
    if (context.mounted) context.go('/workout/${session.id}');
  }
}
