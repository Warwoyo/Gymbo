import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/rest_timer_state.dart';

final restTimerProvider =
    NotifierProvider<RestTimerController, RestTimerState>(
        RestTimerController.new);

/// Drives the rest timer from a wall-clock end time so it stays accurate
/// across app backgrounding and quick rebuilds.
class RestTimerController extends Notifier<RestTimerState> {
  Timer? _ticker;

  @override
  RestTimerState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const RestTimerState();
  }

  void start(int seconds) {
    if (seconds <= 0) return;
    final endsAt = DateTime.now().add(Duration(seconds: seconds));
    state = RestTimerState(
      phase: RestTimerPhase.running,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      endsAt: endsAt,
    );
    _startTicker();
  }

  void pause() {
    if (state.phase != RestTimerPhase.running) return;
    _ticker?.cancel();
    state = state.copyWith(phase: RestTimerPhase.paused, clearEndsAt: true);
  }

  void resume() {
    if (state.phase != RestTimerPhase.paused) return;
    final endsAt =
        DateTime.now().add(Duration(seconds: state.remainingSeconds));
    state = state.copyWith(phase: RestTimerPhase.running, endsAt: endsAt);
    _startTicker();
  }

  void addSeconds(int seconds) {
    if (!state.isActive) return;
    final newRemaining = state.remainingSeconds + seconds;
    final newTotal = state.totalSeconds + seconds;
    if (state.phase == RestTimerPhase.running) {
      state = state.copyWith(
        totalSeconds: newTotal,
        remainingSeconds: newRemaining,
        endsAt: DateTime.now().add(Duration(seconds: newRemaining)),
      );
    } else {
      state = state.copyWith(
        totalSeconds: newTotal,
        remainingSeconds: newRemaining,
      );
    }
  }

  void skip() {
    _ticker?.cancel();
    state = const RestTimerState();
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
      _notifyFinished();
    } else {
      state = state.copyWith(remainingSeconds: remaining);
    }
  }

  void _notifyFinished() {
    // Built-in feedback only — no notification plugin required.
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
  }
}
