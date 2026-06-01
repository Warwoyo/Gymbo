/// Phase of the rest timer.
enum RestTimerPhase { idle, running, paused, finished }

/// Immutable snapshot of the rest timer.
///
/// Driven by wall-clock timestamps so it stays accurate across app
/// backgrounding and process death.
class RestTimerState {
  const RestTimerState({
    this.phase = RestTimerPhase.idle,
    this.totalSeconds = 0,
    this.remainingSeconds = 0,
    this.endsAt,
  });

  final RestTimerPhase phase;
  final int totalSeconds;
  final int remainingSeconds;

  /// Wall-clock time the timer is scheduled to finish (when running).
  final DateTime? endsAt;

  bool get isActive =>
      phase == RestTimerPhase.running || phase == RestTimerPhase.paused;

  double get progress =>
      totalSeconds == 0 ? 0 : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

  RestTimerState copyWith({
    RestTimerPhase? phase,
    int? totalSeconds,
    int? remainingSeconds,
    DateTime? endsAt,
    bool clearEndsAt = false,
  }) {
    return RestTimerState(
      phase: phase ?? this.phase,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      endsAt: clearEndsAt ? null : (endsAt ?? this.endsAt),
    );
  }
}
