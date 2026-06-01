import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums.dart';
import '../../../core/utils/formatting.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../workout/presentation/session_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final activeSession = ref.watch(activeSessionProvider);
    final lastSession = ref.watch(lastFinishedSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gymbo'),
        actions: [
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/history'),
          ),
          IconButton(
            tooltip: 'Switch profile',
            icon: const Icon(Icons.people_alt_outlined),
            onPressed: () => context.push('/profiles'),
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(activeSessionProvider);
          ref.invalidate(lastFinishedSessionProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Hi, ${profile?.name ?? 'Athlete'} 👋',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            if (profile != null)
              Text('Goal: ${profile.primaryGoal.label}',
                  style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),

            // Active session resume card.
            activeSession.maybeWhen(
              data: (s) => s == null
                  ? const SizedBox.shrink()
                  : Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        leading: const Icon(Icons.play_circle_fill, size: 36),
                        title: Text('Resume ${s.dayType.label}'),
                        subtitle:
                            Text('Started ${Format.time(s.startedAt)}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/workout/${s.id}'),
                      ),
                    ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),

            Text('Start a workout',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _DayButton(
                dayType: DayType.push, icon: Icons.fitness_center),
            const SizedBox(height: 10),
            _DayButton(dayType: DayType.pull, icon: Icons.rowing),
            const SizedBox(height: 10),
            _DayButton(
                dayType: DayType.leg, icon: Icons.directions_run),
            const SizedBox(height: 24),

            Text('Last workout',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            lastSession.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('$e'),
              data: (s) => s == null
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No workouts yet. Start one above!'),
                      ),
                    )
                  : Card(
                      child: ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(s.dayType.label),
                        subtitle: Text(
                            '${Format.date(s.startedAt)} • ${Format.duration(s.duration)}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/summary/${s.id}'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayButton extends StatelessWidget {
  const _DayButton({required this.dayType, required this.icon});

  final DayType dayType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(64)),
      icon: Icon(icon, size: 26),
      label: Text(dayType.label, style: const TextStyle(fontSize: 18)),
      onPressed: () => context.push('/day/${dayType.name}'),
    );
  }
}
