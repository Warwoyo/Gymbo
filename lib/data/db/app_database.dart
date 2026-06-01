import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../core/enums.dart';

part 'app_database.g.dart';

// ----------------------------- Tables -----------------------------

@DataClassName('UserProfileRow')
class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get age => integer().nullable()();
  TextColumn get sex => text().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get bodyWeightKg => real().nullable()();
  TextColumn get trainingExperience => textEnum<TrainingExperience>()();
  TextColumn get primaryGoal => textEnum<TrainingGoal>()();
  RealColumn get preferredWeightIncrementKg => real()();
  BoolColumn get restTimerEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseRow')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get dayType => textEnum<DayType>()();
  TextColumn get primaryMuscleGroup => text()();
  TextColumn get secondaryMuscleGroups => text().withDefault(const Constant(''))();
  TextColumn get movementPattern => text().withDefault(const Constant(''))();
  TextColumn get equipmentType => textEnum<EquipmentType>()();
  BoolColumn get isBodyweight => boolean().withDefault(const Constant(false))();
  BoolColumn get isUnilateral => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutSessionRow')
class WorkoutSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userProfileId => text()();
  TextColumn get dayType => textEnum<DayType>()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  DateTimeColumn get lastActivityAt => dateTime()();
  TextColumn get status => textEnum<WorkoutSessionStatus>()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutExerciseRow')
class WorkoutExercises extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get orderIndex => integer()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutSetRow')
class WorkoutSets extends Table {
  TextColumn get id => text()();
  TextColumn get workoutExerciseId => text()();
  IntColumn get setNumber => integer()();
  RealColumn get weightKg => real()();
  IntColumn get reps => integer()();
  RealColumn get rpe => real().nullable()();
  IntColumn get rir => integer().nullable()();
  BoolColumn get isWarmup => boolean().withDefault(const Constant(false))();
  BoolColumn get isFailure => boolean().withDefault(const Constant(false))();
  RealColumn get estimatedOneRepMaxKg => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ----------------------------- Database -----------------------------

@DriftDatabase(tables: [
  UserProfiles,
  Exercises,
  WorkoutSessions,
  WorkoutExercises,
  WorkoutSets,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for tests using an in-memory database.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Future schema migrations are added here, version by version.
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'gymbo.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
