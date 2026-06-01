import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting.dart';
import '../domain/rest_timer_state.dart';
import 'rest_timer_controller.dart';

class RestTimerBar extends ConsumerWidget {
  const RestTimerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restTimerProvider);
    final controller = ref.read(restTimerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    if (state.phase == RestTimerPhase.idle) {
      return const SizedBox.shrink();
    }

    final finished = state.phase == RestTimerPhase.finished;
    final color = finished ? scheme.primaryContainer : scheme.surfaceContainerHighest;

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(finished ? Icons.notifications_active : Icons.timer,
                    color: scheme.primary),
                const SizedBox(width: 10),
                Text(
                  finished ? 'Rest done!' : 'Rest',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  Format.mmss(state.remainingSeconds),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontFeatures: const []),
                ),
              ],
            ),
            if (!finished) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(value: state.progress, minHeight: 6),
            ],
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state.phase == RestTimerPhase.running)
                  TextButton.icon(
                    onPressed: controller.pause,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                  )
                else if (state.phase == RestTimerPhase.paused)
                  TextButton.icon(
                    onPressed: controller.resume,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Resume'),
                  ),
                if (!finished)
                  TextButton.icon(
                    onPressed: () => controller.addSeconds(30),
                    icon: const Icon(Icons.add),
                    label: const Text('30s'),
                  ),
                TextButton.icon(
                  onPressed: controller.skip,
                  icon: const Icon(Icons.stop),
                  label: Text(finished ? 'Dismiss' : 'Skip'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
