import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/utils/formatting.dart';
import '../domain/persisted_rest_timer.dart';
import '../domain/rest_timer_state.dart';

final restTimerProvider =
    NotifierProvider<RestTimerController, RestTimerState>(
        RestTimerController.new);

/// Options that control the rest timer's notification behaviour.
class RestTimerOptions {
  const RestTimerOptions({
    this.notificationsEnabled = true,
    this.soundEnabled = false,
    this.vibrationEnabled = false,
  });

  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
}

/// Drives the rest timer from a wall-clock end time so it stays accurate
/// across app backgrounding, and persists it so it survives process death.
class RestTimerController extends Notifier<RestTimerState> {
  Timer? _ticker;
  String? _sessionId;
  String? _exerciseId;
  String? _afterSetId;
  RestTimerOptions _options = const RestTimerOptions();

  NotificationService get _notifier => NotificationService.instance;

  @override
  RestTimerState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const RestTimerState();
  }

  void configure({
    required String sessionId,
    RestTimerOptions options = const RestTimerOptions(),
  }) {
    _sessionId = sessionId;
    _options = options;
  }

  Future<void> start(
    int seconds, {
    String? exerciseId,
    String? afterSetId,
  }) async {
    if (seconds <= 0) return;
    _exerciseId = exerciseId;
    _afterSetId = afterSetId;
    final now = DateTime.now();
    final endsAt = now.add(Duration(seconds: seconds));
    state = RestTimerState(
      phase: RestTimerPhase.running,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      endsAt: endsAt,
    );
    await _persist(startedAt: now);
    _scheduleFinishNotification(endsAt);
    _updateNotification();
    _startTicker();
  }

  /// Restores a previously persisted timer (e.g. after app restart).
  void restore(PersistedRestTimer p) {
    _exerciseId = p.exerciseId;
    _afterSetId = p.afterSetId;
    final remaining = p.remainingSeconds();
    if (remaining <= 0) {
      state = RestTimerState(
        phase: RestTimerPhase.finished,
        totalSeconds: p.totalSeconds,
        remainingSeconds: 0,
      );
      return;
    }
    if (p.isPaused) {
      state = RestTimerState(
        phase: RestTimerPhase.paused,
        totalSeconds: p.totalSeconds,
        remainingSeconds: remaining,
      );
    } else {
      state = RestTimerState(
        phase: RestTimerPhase.running,
        totalSeconds: p.totalSeconds,
        remainingSeconds: remaining,
        endsAt: p.endsAt,
      );
      _startTicker();
    }
  }

  void pause() {
    if (state.phase != RestTimerPhase.running) return;
    _ticker?.cancel();
    state = state.copyWith(phase: RestTimerPhase.paused, clearEndsAt: true);
    _notifier.cancelScheduledFinish();
    _persist(paused: true);
  }

  void resume() {
    if (state.phase != RestTimerPhase.paused) return;
    final endsAt =
        DateTime.now().add(Duration(seconds: state.remainingSeconds));
    state = state.copyWith(phase: RestTimerPhase.running, endsAt: endsAt);
    _scheduleFinishNotification(endsAt);
    _persist();
    _updateNotification();
    _startTicker();
  }

  void addSeconds(int seconds) {
    if (!state.isActive) return;
    final newRemaining = state.remainingSeconds + seconds;
    final newTotal = state.totalSeconds + seconds;
    if (state.phase == RestTimerPhase.running) {
      final endsAt = DateTime.now().add(Duration(seconds: newRemaining));
      state = state.copyWith(
        totalSeconds: newTotal,
        remainingSeconds: newRemaining,
        endsAt: endsAt,
      );
      _scheduleFinishNotification(endsAt);
      _persist();
      _updateNotification();
    } else {
      state = state.copyWith(
        totalSeconds: newTotal,
        remainingSeconds: newRemaining,
      );
      _persist(paused: true);
    }
  }

  void skip() {
    _ticker?.cancel();
    state = const RestTimerState();
    _notifier.cancelScheduledFinish();
    if (_sessionId != null) {
      _notifier.showWorkoutActive();
    }
    _clearPersisted();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final endsAt = state.endsAt;
    if (endsAt == null) return;
    final remaining = endsAt.difference(DateTime.now()).inSeconds;
    if (remaining <= 0) {
      _ticker?.cancel();
      state = state.copyWith(
        phase: RestTimerPhase.finished,
        remainingSeconds: 0,
        clearEndsAt: true,
      );
      _onFinished();
    } else {
      state = state.copyWith(remainingSeconds: remaining);
      _updateNotification();
    }
  }

  void _onFinished() {
    if (_options.vibrationEnabled) {
      HapticFeedback.heavyImpact();
    }
    if (_options.notificationsEnabled) {
      _notifier.showRestFinished(
        sound: _options.soundEnabled,
        vibrate: _options.vibrationEnabled,
      );
    }
    _clearPersisted();
  }

  void _updateNotification() {
    if (!_options.notificationsEnabled) return;
    if (state.phase == RestTimerPhase.running) {
      _notifier.showRestCountdown(Format.mmss(state.remainingSeconds));
    }
  }

  void _scheduleFinishNotification(DateTime endsAt) {
    if (!_options.notificationsEnabled) return;
    _notifier.scheduleRestFinished(
      endsAt,
      sound: _options.soundEnabled,
      vibrate: _options.vibrationEnabled,
    );
  }

  Future<void> _persist({DateTime? startedAt, bool paused = false}) async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    final endsAt = state.endsAt ??
        DateTime.now().add(Duration(seconds: state.remainingSeconds));
    await ref.read(workoutRepositoryProvider).saveRestTimer(
          PersistedRestTimer(
            sessionId: sessionId,
            exerciseId: _exerciseId,
            afterSetId: _afterSetId,
            startedAt: startedAt ?? DateTime.now(),
            endsAt: endsAt,
            totalSeconds: state.totalSeconds,
            isRunning: state.phase == RestTimerPhase.running,
            isPaused: paused || state.phase == RestTimerPhase.paused,
            pausedAt: paused ? DateTime.now() : null,
            allowSilentNotification: _options.notificationsEnabled,
          ),
        );
  }

  Future<void> _clearPersisted() async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    await ref.read(workoutRepositoryProvider).clearRestTimer(sessionId);
  }
}
