import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../domain/exercise.dart';

final exercisesByDayProvider =
    FutureProvider.autoDispose.family<List<Exercise>, DayType>((ref, dayType) {
  return ref.watch(exerciseRepositoryProvider).listByDayType(dayType);
});

final allExercisesProvider = FutureProvider.autoDispose<List<Exercise>>((ref) {
  return ref.watch(exerciseRepositoryProvider).listAll();
});
