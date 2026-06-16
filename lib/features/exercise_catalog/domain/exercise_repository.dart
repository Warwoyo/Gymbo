import '../../../core/enums.dart';
import 'exercise.dart';

abstract class ExerciseRepository {
  /// Seeds the generic catalog on first run (idempotent).
  Future<void> seedIfEmpty();
  Future<List<Exercise>> listByDayType(DayType dayType, {String? userProfileId});
  Future<List<Exercise>> listAll({String? userProfileId});
  Future<Exercise?> getById(String id);
  Future<bool> nameExists(String name, {String? userProfileId, String? excludingId});
  Future<Exercise> createCustom(Exercise exercise);
  Future<Exercise> updateCustom(Exercise exercise);
  Future<void> deleteCustom(String id);
  Future<int> count();
}
