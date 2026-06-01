import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import '../domain/workout_summary.dart';

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
