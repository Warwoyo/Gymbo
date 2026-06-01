import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/features/workout/domain/persisted_rest_timer.dart';

void main() {
  group('PersistedRestTimer', () {
    test('remaining time is derived from endsAt after a restart', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final timer = PersistedRestTimer(
        sessionId: 's1',
        startedAt: now,
        endsAt: now.add(const Duration(seconds: 90)),
        totalSeconds: 90,
      );
      // Simulate the app reopening 30s later.
      expect(timer.remainingSeconds(now.add(const Duration(seconds: 30))), 60);
      expect(timer.isFinished(now.add(const Duration(seconds: 30))), isFalse);
    });

    test('endsAt in the past => finished', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final timer = PersistedRestTimer(
        sessionId: 's1',
        startedAt: now,
        endsAt: now.add(const Duration(seconds: 60)),
        totalSeconds: 60,
      );
      expect(timer.isFinished(now.add(const Duration(seconds: 61))), isTrue);
      expect(timer.remainingSeconds(now.add(const Duration(seconds: 61))), 0);
    });

    test('adding 30s pushes endsAt and increases remaining', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final base = PersistedRestTimer(
        sessionId: 's1',
        startedAt: now,
        endsAt: now.add(const Duration(seconds: 60)),
        totalSeconds: 60,
      );
      final extended = PersistedRestTimer(
        sessionId: base.sessionId,
        startedAt: base.startedAt,
        endsAt: base.endsAt.add(const Duration(seconds: 30)),
        totalSeconds: base.totalSeconds + 30,
      );
      expect(extended.remainingSeconds(now), 90);
    });

    test('paused timer freezes remaining at pausedAt', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final timer = PersistedRestTimer(
        sessionId: 's1',
        startedAt: now,
        endsAt: now.add(const Duration(seconds: 90)),
        totalSeconds: 90,
        isPaused: true,
        pausedAt: now.add(const Duration(seconds: 20)),
      );
      // Regardless of "now", paused remaining is endsAt - pausedAt = 70.
      expect(timer.remainingSeconds(now.add(const Duration(minutes: 5))), 70);
    });
  });
}
