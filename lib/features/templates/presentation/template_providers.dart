import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_exercise.dart';

final workoutTemplatesProvider =
    FutureProvider.autoDispose<List<WorkoutTemplate>>((ref) async {
  final profile = await ref.watch(activeProfileProvider.future);
  if (profile == null) return const [];
  return ref.watch(workoutTemplateRepositoryProvider).listTemplates(profile.id);
});

final workoutTemplateProvider = FutureProvider.autoDispose
    .family<WorkoutTemplate?, String>((ref, templateId) {
  return ref.watch(workoutTemplateRepositoryProvider).getTemplate(templateId);
});

final workoutTemplateExercisesProvider = FutureProvider.autoDispose
    .family<List<WorkoutTemplateExercise>, String>((ref, templateId) {
  return ref.watch(workoutTemplateRepositoryProvider).getTemplateExercises(templateId);
});
