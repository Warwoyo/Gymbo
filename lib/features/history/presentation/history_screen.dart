import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatting.dart';
import '../../workout/presentation/session_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(workoutHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No completed workouts yet.'))
            : ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (_, i) {
                  final s = list[i];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.event_available),
                      title: Text(s.sessionName ?? s.dayType?.label ?? 'Workout'),
                      subtitle: Text(
                        '${Format.dateTime(s.startedAt)} • ${Format.duration(s.duration)}'
                        '${s.status.isFinished && s.status.name == "autoCompleted" ? ' • auto-ended' : ''}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/summary/${s.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
