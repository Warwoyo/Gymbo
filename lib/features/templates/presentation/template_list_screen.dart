import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatting.dart';
import 'template_providers.dart';

class TemplateListScreen extends ConsumerWidget {
  const TemplateListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(workoutTemplatesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Workout templates')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/templates/new'),
        icon: const Icon(Icons.add),
        label: const Text('Create template'),
      ),
      body: templates.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No templates yet. Create one to reuse your favorite workout.'))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final template = items[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.list_alt_outlined),
                      title: Text(template.name),
                      subtitle: Text(
                        '${template.dayType?.label ?? 'Any split'} • Updated ${Format.date(template.updatedAt)}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/templates/${template.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
