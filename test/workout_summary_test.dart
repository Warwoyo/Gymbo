import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/features/workout/domain/auto_end.dart';
import 'package:gymbo/features/workout/domain/workout_session.dart';
import 'package:gymbo/features/workout/domain/workout_set.dart';
import 'package:gymbo/features/workout/domain/workout_summary.dart';

WorkoutSet _set({
  required int n,
  required double weight,
  required int reps,
  bool warmup = false,
  double? e1rm,
}) {
  final now = DateTime(2026, 1, 1);
  return WorkoutSet(
    id: 'set$n',
    workoutExerciseId: 'we1',
    setNumber: n,
    weightKg: weight,
    reps: reps,
    isWarmup: warmup,
    estimatedOneRepMaxKg: e1rm,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('Workout summary calculations', () {
    final session = WorkoutSession(
      id: 's1',
      userProfileId: 'p1',
      dayType: DayType.push,
      startedAt: DateTime(2026, 1, 1, 10, 0),
      endedAt: DateTime(2026, 1, 1, 11, 0),
      lastActivityAt: DateTime(2026, 1, 1, 11, 0),
      status: WorkoutSessionStatus.completed,
      createdAt: DateTime(2026, 1, 1, 10, 0),
      updatedAt: DateTime(2026, 1, 1, 11, 0),
    );

    final summary = WorkoutSummary(
      session: session,
      exercises: [
        ExerciseSummary(
          workoutExerciseId: 'we1',
          exerciseId: 'ex1',
          exerciseName: 'Bench Press',
          sets: [
            _set(n: 1, weight: 60, reps: 8, e1rm: 76),
            _set(n: 2, weight: 57.5, reps: 10, e1rm: 76.66),
          ],
          bestEstimatedOneRepMaxKg: 76.66,
          isPersonalRecord: true,
        ),
      ],
    );

    test('total volume = 60*8 + 57.5*10 = 1055', () {
      expect(summary.totalVolumeLoad, closeTo(1055.0, 0.0001));
    });

    test('total reps = 18', () {
      expect(summary.totalReps, 18);
    });

    test('working set count = 2', () {
      expect(summary.totalWorkingSets, 2);
    });

    test('warm-up sets excluded from volume', () {
      final s = WorkoutSummary(session: session, exercises: [
        ExerciseSummary(
          workoutExerciseId: 'we1',
          exerciseId: 'ex1',
          exerciseName: 'Bench Press',
          sets: [
            _set(n: 1, weight: 20, reps: 10, warmup: true),
            _set(n: 2, weight: 60, reps: 8, e1rm: 76),
          ],
          bestEstimatedOneRepMaxKg: 76,
          isPersonalRecord: false,
        ),
      ]);
      expect(s.totalVolumeLoad, closeTo(480.0, 0.0001));
      expect(s.totalWorkingSets, 1);
    });

    test('duration = 1 hour', () {
      expect(summary.duration, const Duration(hours: 1));
    });
  });

  group('Auto-end rule', () {
    final lastActivity = DateTime(2026, 1, 1, 10, 0);

    test('does not end before timeout', () {
      expect(
        AutoEnd.shouldAutoEnd(
          lastActivityAt: lastActivity,
          now: lastActivity.add(const Duration(minutes: 119)),
          timeoutMinutes: 120,
        ),
        isFalse,
      );
    });

    test('ends at/after timeout', () {
      expect(
        AutoEnd.shouldAutoEnd(
          lastActivityAt: lastActivity,
          now: lastActivity.add(const Duration(minutes: 120)),
          timeoutMinutes: 120,
        ),
        isTrue,
      );
    });

    test('end timestamp = lastActivity + timeout', () {
      expect(
        AutoEnd.endTimestamp(lastActivityAt: lastActivity, timeoutMinutes: 120),
        DateTime(2026, 1, 1, 12, 0),
      );
    });
  });
}
