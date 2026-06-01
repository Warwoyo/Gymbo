import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/app_database.dart';
import '../features/exercise_catalog/data/exercise_repository_impl.dart';
import '../features/exercise_catalog/domain/exercise_repository.dart';
import '../features/profile/data/profile_repository_impl.dart';
import '../features/profile/domain/profile_repository.dart';
import '../features/recommendations/domain/recommendation_engine.dart';
import '../features/workout/data/workout_repository_impl.dart';
import '../features/workout/domain/workout_repository.dart';

/// Overridden in [main] with the initialized instances.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider must be overridden in main()');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
      'sharedPreferencesProvider must be overridden in main()');
});

final recommendationEngineProvider =
    Provider<RecommendationEngine>((ref) => const RecommendationEngine());

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    ref.watch(databaseProvider),
    ref.watch(sharedPreferencesProvider),
  );
});

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepositoryImpl(ref.watch(databaseProvider));
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(ref.watch(databaseProvider));
});
