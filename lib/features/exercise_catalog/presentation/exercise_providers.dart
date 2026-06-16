import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/exercise.dart';

final exercisesByDayProvider =
    FutureProvider.autoDispose.family<List<Exercise>, DayType>((ref, dayType) async {
  final profile = await ref.watch(activeProfileProvider.future);
  return ref
      .watch(exerciseRepositoryProvider)
      .listByDayType(dayType, userProfileId: profile?.id);
});

final allExercisesProvider = FutureProvider.autoDispose<List<Exercise>>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  return ref.watch(exerciseRepositoryProvider).listAll(userProfileId: profile?.id);
});
