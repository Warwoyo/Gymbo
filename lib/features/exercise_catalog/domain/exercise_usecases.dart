import '../../../core/enums.dart';
import 'exercise.dart';
import 'exercise_repository.dart';

class SeedExerciseCatalog {
  const SeedExerciseCatalog(this._repo);
  final ExerciseRepository _repo;
  Future<void> call() => _repo.seedIfEmpty();
}

class ListExercisesByDayType {
  const ListExercisesByDayType(this._repo);
  final ExerciseRepository _repo;
  Future<List<Exercise>> call(DayType dayType) => _repo.listByDayType(dayType);
}

class CreateCustomExercise {
  const CreateCustomExercise(this._repo);
  final ExerciseRepository _repo;
  Future<Exercise> call(Exercise exercise) => _repo.createCustom(exercise);
}
