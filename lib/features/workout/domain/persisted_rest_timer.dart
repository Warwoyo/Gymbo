/// Locally persisted rest-timer state, so the timer survives backgrounding
/// and process death (spec §8). Remaining time is derived from [endsAt].
class PersistedRestTimer {
  const PersistedRestTimer({
    required this.sessionId,
    this.exerciseId,
    this.afterSetId,
    required this.startedAt,
    required this.endsAt,
    required this.totalSeconds,
    this.isRunning = true,
    this.isPaused = false,
    this.pausedAt,
    this.accumulatedPausedSeconds = 0,
    this.allowSilentNotification = true,
  });

  final String sessionId;
  final String? exerciseId;
  final String? afterSetId;
  final DateTime startedAt;
  final DateTime endsAt;
  final int totalSeconds;
  final bool isRunning;
  final bool isPaused;
  final DateTime? pausedAt;
  final int accumulatedPausedSeconds;
  final bool allowSilentNotification;

  /// Remaining whole seconds, computed against [now].
  int remainingSeconds([DateTime? now]) {
    if (isPaused && pausedAt != null) {
      return endsAt.difference(pausedAt!).inSeconds.clamp(0, totalSeconds);
    }
    final n = now ?? DateTime.now();
    final r = endsAt.difference(n).inSeconds;
    return r < 0 ? 0 : r;
  }

  bool isFinished([DateTime? now]) => remainingSeconds(now) <= 0;
}
