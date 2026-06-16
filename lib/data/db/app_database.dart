import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../core/enums.dart';
import '../../features/workout/domain/workout_set.dart';

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
  TextColumn get recommendationStyle =>
      textEnum<RecommendationStyle>().nullable()();
  IntColumn get autoEndTimeoutMinutes => integer().nullable()();
  BoolColumn get restNotificationsEnabled => boolean().nullable()();
  BoolColumn get soundEnabled => boolean().nullable()();
  BoolColumn get vibrationEnabled => boolean().nullable()();
  IntColumn get defaultAddRestSeconds => integer().nullable()();
  BoolColumn get showRpeRir => boolean().nullable()();
  RealColumn get dumbbellIncrementKg => real().nullable()();
  RealColumn get barbellIncrementKg => real().nullable()();
  RealColumn get machineIncrementKg => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseRow')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get dayType => textEnum<DayType>().nullable()();
  TextColumn get tags => text().withDefault(const Constant(''))();
  TextColumn get primaryMuscleGroup => text()();
  TextColumn get secondaryMuscleGroups => text().withDefault(const Constant(''))();
  TextColumn get movementPattern => text().withDefault(const Constant(''))();
  TextColumn get equipmentType => textEnum<EquipmentType>()();
  TextColumn get exerciseCategory => textEnum<ExerciseCategory>().nullable()();
  BoolColumn get isBodyweight => boolean().withDefault(const Constant(false))();
  BoolColumn get isUnilateral => boolean().withDefault(const Constant(false))();
  RealColumn get defaultIncrementKg => real().nullable()();
  IntColumn get minimumRecommendedReps => integer().nullable()();
  IntColumn get maximumRecommendedReps => integer().nullable()();
  IntColumn get defaultRestSeconds => integer().nullable()();
  IntColumn get recommendedSetRangeMin => integer().nullable()();
  IntColumn get recommendedSetRangeMax => integer().nullable()();
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
  TextColumn get dayType => textEnum<DayType>().nullable()();
  TextColumn get sessionName => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant(''))();
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
  TextColumn get loadType => textEnum<WorkoutSetLoadType>()
      .withDefault(Constant(WorkoutSetLoadType.externalLoad.name))();
  RealColumn get rpe => real().nullable()();
  IntColumn get rir => integer().nullable()();
  BoolColumn get isWarmup => boolean().withDefault(const Constant(false))();
  BoolColumn get isFailure => boolean().withDefault(const Constant(false))();
  RealColumn get estimatedOneRepMaxKg => real().nullable()();
  IntColumn get restBeforeSetSeconds => integer().nullable()();
  IntColumn get restAfterSetSeconds => integer().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RestTimerStateRow')
class RestTimerStates extends Table {
  TextColumn get sessionId => text()();
  TextColumn get exerciseId => text().nullable()();
  TextColumn get afterSetId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  IntColumn get totalSeconds => integer()();
  BoolColumn get isRunning => boolean().withDefault(const Constant(true))();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();
  DateTimeColumn get pausedAt => dateTime().nullable()();
  IntColumn get accumulatedPausedSeconds =>
      integer().withDefault(const Constant(0))();
  BoolColumn get allowSilentNotification =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {sessionId};
}



@DataClassName('ExerciseMuscleTargetRow')
class ExerciseMuscleTargets extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text()();
  TextColumn get muscleGroup => textEnum<MuscleGroup>()();
  TextColumn get role => textEnum<MuscleRole>()();
  RealColumn get contribution => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutMuscleImpactRow')
class WorkoutMuscleImpacts extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get muscleGroup => textEnum<MuscleGroup>()();
  RealColumn get rawScore => real()();
  RealColumn get normalizedScore => real()();
  IntColumn get workingSets => integer()();
  RealColumn get volume => real()();
  TextColumn get strongestRole => textEnum<MuscleRole>()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutRegionImpactRow')
class WorkoutRegionImpacts extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get region => textEnum<MuscleRegion>()();
  RealColumn get rawScore => real()();
  RealColumn get normalizedScore => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutTemplateRow')
class WorkoutTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get userProfileId => text()();
  TextColumn get name => text()();
  TextColumn get dayType => textEnum<DayType>().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutTemplateExerciseRow')
class WorkoutTemplateExercises extends Table {
  TextColumn get id => text()();
  TextColumn get templateId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get orderIndex => integer()();
  IntColumn get targetSets => integer().nullable()();
  IntColumn get targetReps => integer().nullable()();
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
  RestTimerStates,
  ExerciseMuscleTargets,
  WorkoutMuscleImpacts,
  WorkoutRegionImpacts,
  WorkoutTemplates,
  WorkoutTemplateExercises,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for tests using an in-memory database.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement('''
            CREATE TABLE IF NOT EXISTS workout_templates (
              id TEXT NOT NULL PRIMARY KEY,
              user_profile_id TEXT NOT NULL,
              name TEXT NOT NULL,
              day_type TEXT NULL,
              notes TEXT NULL,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          await customStatement('''
            CREATE TABLE IF NOT EXISTS workout_template_exercises (
              id TEXT NOT NULL PRIMARY KEY,
              template_id TEXT NOT NULL,
              exercise_id TEXT NOT NULL,
              order_index INTEGER NOT NULL,
              target_sets INTEGER NULL,
              target_reps INTEGER NULL,
              notes TEXT NULL
            )
          ''');
        },
        onUpgrade: (m, from, to) async {
          // v2: evidence-informed fields + persisted rest timer.
          if (from < 2) {
            await m.addColumn(
                userProfiles, userProfiles.recommendationStyle);
            await m.addColumn(
                userProfiles, userProfiles.autoEndTimeoutMinutes);
            await m.addColumn(
                userProfiles, userProfiles.restNotificationsEnabled);
            await m.addColumn(userProfiles, userProfiles.soundEnabled);
            await m.addColumn(userProfiles, userProfiles.vibrationEnabled);
            await m.addColumn(
                userProfiles, userProfiles.defaultAddRestSeconds);
            await m.addColumn(userProfiles, userProfiles.showRpeRir);
            await m.addColumn(userProfiles, userProfiles.dumbbellIncrementKg);
            await m.addColumn(userProfiles, userProfiles.barbellIncrementKg);
            await m.addColumn(userProfiles, userProfiles.machineIncrementKg);
            await m.addColumn(exercises, exercises.exerciseCategory);
            await m.addColumn(exercises, exercises.defaultIncrementKg);
            await m.addColumn(exercises, exercises.minimumRecommendedReps);
            await m.addColumn(exercises, exercises.maximumRecommendedReps);
            await m.addColumn(exercises, exercises.defaultRestSeconds);
            await m.addColumn(exercises, exercises.recommendedSetRangeMin);
            await m.addColumn(exercises, exercises.recommendedSetRangeMax);
            await m.addColumn(workoutSets, workoutSets.restBeforeSetSeconds);
            await m.addColumn(workoutSets, workoutSets.restAfterSetSeconds);
            await m.addColumn(workoutSets, workoutSets.startedAt);
            await m.addColumn(workoutSets, workoutSets.completedAt);
            await m.createTable(restTimerStates);
          }
          if (from < 3) {
            await customStatement(
              "ALTER TABLE exercises ADD COLUMN tags TEXT NOT NULL DEFAULT ''",
            );
            await customStatement(
              'ALTER TABLE workout_sessions ADD COLUMN session_name TEXT NULL',
            );
            await customStatement(
              "ALTER TABLE workout_sessions ADD COLUMN tags TEXT NOT NULL DEFAULT ''",
            );
            await m.createTable(exerciseMuscleTargets);
            await m.createTable(workoutMuscleImpacts);
            await m.createTable(workoutRegionImpacts);
          }
          if (from < 4) {
            await m.addColumn(workoutSets, workoutSets.loadType);
          }
          if (from < 5) {
            await customStatement('''
              CREATE TABLE IF NOT EXISTS workout_templates (
                id TEXT NOT NULL PRIMARY KEY,
                user_profile_id TEXT NOT NULL,
                name TEXT NOT NULL,
                day_type TEXT NULL,
                notes TEXT NULL,
                created_at INTEGER NOT NULL,
                updated_at INTEGER NOT NULL
              )
            ''');
            await customStatement('''
              CREATE TABLE IF NOT EXISTS workout_template_exercises (
                id TEXT NOT NULL PRIMARY KEY,
                template_id TEXT NOT NULL,
                exercise_id TEXT NOT NULL,
                order_index INTEGER NOT NULL,
                target_sets INTEGER NULL,
                target_reps INTEGER NULL,
                notes TEXT NULL
              )
            ''');
          }
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
