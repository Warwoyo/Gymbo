import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_controller.dart';

class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileListProvider);
    final active = ref.watch(activeProfileProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Select profile')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/onboarding'),
        icon: const Icon(Icons.add),
        label: const Text('New profile'),
      ),
      body: profiles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final p = list[i];
            final selected = p.id == active?.id;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(p.name.isEmpty ? '?' : p.name[0].toUpperCase())),
                title: Text(p.name),
                subtitle: Text(
                    '${p.primaryGoal.label} • ${p.trainingExperience.label}'),
                trailing: selected ? const Icon(Icons.check_circle) : null,
                onTap: () async {
                  await ref
                      .read(activeProfileProvider.notifier)
                      .selectProfile(p.id);
                  if (context.mounted) context.go('/home');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
