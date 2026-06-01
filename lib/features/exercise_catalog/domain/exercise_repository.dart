import '../../../core/enums.dart';
import 'exercise.dart';

abstract class ExerciseRepository {
  /// Seeds the generic catalog on first run (idempotent).
  Future<void> seedIfEmpty();
  Future<List<Exercise>> listByDayType(DayType dayType);
  Future<Exercise?> getById(String id);
  Future<Exercise> createCustom(Exercise exercise);
  Future<int> count();
}
