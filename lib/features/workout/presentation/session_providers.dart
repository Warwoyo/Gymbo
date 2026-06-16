import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../muscle/domain/muscle_recovery.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import '../domain/workout_summary.dart';

class ExerciseUsage {
  const ExerciseUsage({
    required this.lastUsedAt,
    required this.useCount,
  });

  final DateTime lastUsedAt;
  final int useCount;
}

class MonthlyWorkoutHistorySummary {
  const MonthlyWorkoutHistorySummary({
    required this.month,
    required this.sessions,
    required this.totalDuration,
    required this.totalVolumeLoad,
    required this.personalRecordCount,
    required this.personalRecordSessionIds,
  });

  final DateTime month;
  final List<WorkoutSession> sessions;
  final Duration totalDuration;
  final double totalVolumeLoad;
  final int personalRecordCount;
  final Set<String> personalRecordSessionIds;

  int get totalWorkouts => sessions.length;
}

/// The currently open session for the active profile, if any.
final activeSessionProvider =
    FutureProvider.autoDispose<WorkoutSession?>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return null;
  return ref.watch(workoutRepositoryProvider).getActiveSession(profile.id);
});

final lastFinishedSessionProvider =
    FutureProvider.autoDispose<WorkoutSession?>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return null;
  return ref.watch(workoutRepositoryProvider).lastFinishedSession(profile.id);
});

final workoutHistoryProvider =
    FutureProvider.autoDispose<List<WorkoutSession>>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return const [];
  return ref.watch(workoutRepositoryProvider).listHistory(profile.id);
});

final monthlyWorkoutHistorySummaryProvider = FutureProvider.autoDispose
    .family<MonthlyWorkoutHistorySummary, DateTime>((ref, month) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) {
    return MonthlyWorkoutHistorySummary(
      month: DateTime(month.year, month.month),
      sessions: const [],
      totalDuration: Duration.zero,
      totalVolumeLoad: 0,
      personalRecordCount: 0,
      personalRecordSessionIds: const <String>{},
    );
  }

  final repository = ref.watch(workoutRepositoryProvider);
  final start = DateTime(month.year, month.month);
  final end = DateTime(month.year, month.month + 1);
  final history = await repository.listHistory(profile.id);
  final sessions = history
      .where((s) => !s.startedAt.isBefore(start) && s.startedAt.isBefore(end))
      .toList(growable: false);

  var totalDuration = Duration.zero;
  var totalVolumeLoad = 0.0;
  var personalRecordCount = 0;
  final personalRecordSessionIds = <String>{};

  for (final session in sessions) {
    totalDuration += session.duration;
    final summary = await repository.getSummary(session.id);
    totalVolumeLoad += summary.totalVolumeLoad;
    final prs = summary.personalRecords.length;
    personalRecordCount += prs;
    if (prs > 0) personalRecordSessionIds.add(session.id);
  }

  return MonthlyWorkoutHistorySummary(
    month: start,
    sessions: sessions,
    totalDuration: totalDuration,
    totalVolumeLoad: totalVolumeLoad,
    personalRecordCount: personalRecordCount,
    personalRecordSessionIds: personalRecordSessionIds,
  );
});

final exerciseUsageHistoryProvider =
    FutureProvider.autoDispose<Map<String, ExerciseUsage>>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return const {};

  final repository = ref.watch(workoutRepositoryProvider);
  final history = await repository.listHistory(profile.id);
  final usageByExercise = <String, ExerciseUsage>{};

  for (final session in history) {
    final sessionExercises = await repository.getSessionExercises(session.id);
    final usedAt = session.endedAt ?? session.startedAt;
    for (final workoutExercise in sessionExercises) {
      final current = usageByExercise[workoutExercise.exerciseId];
      usageByExercise[workoutExercise.exerciseId] = ExerciseUsage(
        lastUsedAt: current == null || usedAt.isAfter(current.lastUsedAt)
            ? usedAt
            : current.lastUsedAt,
        useCount: (current?.useCount ?? 0) + 1,
      );
    }
  }

  return usageByExercise;
});

final workoutSummaryProvider =
    FutureProvider.autoDispose.family<WorkoutSummary, String>((ref, sessionId) {
  return ref.watch(workoutRepositoryProvider).getSummary(sessionId);
});

final exerciseProgressProvider = FutureProvider.autoDispose
    .family<List<ExerciseProgressPoint>, ({String exerciseId})>(
        (ref, args) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return const [];
  return ref.watch(workoutRepositoryProvider).getExerciseProgress(
        userProfileId: profile.id,
        exerciseId: args.exerciseId,
      );
});

final recoveryByMuscleProvider =
    FutureProvider.autoDispose<Map<MuscleGroup, MuscleRecoveryState>>(
        (ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return const {};
  return ref.watch(workoutRepositoryProvider).getRecoveryByMuscle(profile.id);
});
