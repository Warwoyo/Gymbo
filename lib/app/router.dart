import 'package:go_router/go_router.dart';

import '../core/enums.dart';
import '../features/exercise_catalog/presentation/exercise_list_screen.dart';
import '../features/history/presentation/exercise_progress_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/home/presentation/gate_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/profile/presentation/edit_profile_screen.dart';
import '../features/profile/presentation/onboarding_screen.dart';
import '../features/profile/presentation/profile_selection_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/workout/presentation/active_workout_screen.dart';
import '../features/workout/presentation/workout_summary_screen.dart';

DayType _parseDay(String? raw) =>
    DayType.values.firstWhere((d) => d.name == raw, orElse: () => DayType.push);

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const GateScreen()),
    GoRoute(
        path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(
        path: '/profiles',
        builder: (_, __) => const ProfileSelectionScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/day/:day',
      builder: (_, state) =>
          ExerciseListScreen(dayType: _parseDay(state.pathParameters['day'])),
    ),
    GoRoute(
      path: '/workout/:sessionId',
      builder: (_, state) =>
          ActiveWorkoutScreen(sessionId: state.pathParameters['sessionId']!),
    ),
    GoRoute(
      path: '/summary/:sessionId',
      builder: (_, state) =>
          WorkoutSummaryScreen(sessionId: state.pathParameters['sessionId']!),
    ),
    GoRoute(path: '/history', builder: (_, __) => const HistoryScreen()),
    GoRoute(
      path: '/progress/:exerciseId',
      builder: (_, state) => ExerciseProgressScreen(
        exerciseId: state.pathParameters['exerciseId']!,
        exerciseName: state.uri.queryParameters['name'] ?? 'Exercise',
      ),
    ),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(
        path: '/edit-profile', builder: (_, __) => const EditProfileScreen()),
  ],
);
