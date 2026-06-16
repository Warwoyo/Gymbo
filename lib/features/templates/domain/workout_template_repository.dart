import '../../../core/enums.dart';
import '../../workout/domain/workout_session.dart';
import 'workout_template.dart';
import 'workout_template_exercise.dart';

abstract class WorkoutTemplateRepository {
  Future<List<WorkoutTemplate>> listTemplates(String userProfileId);
  Future<WorkoutTemplate?> getTemplate(String templateId);
  Future<List<WorkoutTemplateExercise>> getTemplateExercises(String templateId);

  Future<WorkoutTemplate> createTemplate({
    required String userProfileId,
    required String name,
    DayType? dayType,
    String? notes,
    List<String> exerciseIds = const [],
  });

  Future<WorkoutTemplate> saveSessionAsTemplate({
    required String sessionId,
    required String name,
  });

  Future<void> deleteTemplate(String templateId);

  Future<WorkoutSession> startSessionFromTemplate({
    required String userProfileId,
    required String templateId,
  });
}
