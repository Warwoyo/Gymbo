import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums.dart';
import '../../../data/db/app_database.dart';
import '../../workout/domain/workout_repository.dart';
import '../../workout/domain/workout_session.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_exercise.dart';
import '../domain/workout_template_repository.dart';

class WorkoutTemplateRepositoryImpl implements WorkoutTemplateRepository {
  WorkoutTemplateRepositoryImpl(this._db, this._workouts);

  final AppDatabase _db;
  final WorkoutRepository _workouts;
  static const _uuid = Uuid();

  WorkoutTemplate _templateFromData(Map<String, Object?> data) => WorkoutTemplate(
        id: data['id']! as String,
        userProfileId: data['user_profile_id']! as String,
        name: data['name']! as String,
        dayType: _dayTypeFromName(data['day_type'] as String?),
        notes: data['notes'] as String?,
        createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']! as int),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(data['updated_at']! as int),
      );

  WorkoutTemplateExercise _exerciseFromData(Map<String, Object?> data) =>
      WorkoutTemplateExercise(
        id: data['id']! as String,
        templateId: data['template_id']! as String,
        exerciseId: data['exercise_id']! as String,
        orderIndex: data['order_index']! as int,
        targetSets: data['target_sets'] as int?,
        targetReps: data['target_reps'] as int?,
        notes: data['notes'] as String?,
      );

  static DayType? _dayTypeFromName(String? value) {
    if (value == null) return null;
    for (final type in DayType.values) {
      if (type.name == value) return type;
    }
    return null;
  }

  @override
  Future<List<WorkoutTemplate>> listTemplates(String userProfileId) async {
    final rows = await _db.customSelect(
      'SELECT * FROM workout_templates WHERE user_profile_id = ? ORDER BY updated_at DESC',
      variables: [Variable.withString(userProfileId)],
      readsFrom: const {},
    ).get();
    return rows.map((row) => _templateFromData(row.data)).toList();
  }

  @override
  Future<WorkoutTemplate?> getTemplate(String templateId) async {
    final row = await _db.customSelect(
      'SELECT * FROM workout_templates WHERE id = ? LIMIT 1',
      variables: [Variable.withString(templateId)],
      readsFrom: const {},
    ).getSingleOrNull();
    return row == null ? null : _templateFromData(row.data);
  }

  @override
  Future<List<WorkoutTemplateExercise>> getTemplateExercises(String templateId) async {
    final rows = await _db.customSelect(
      'SELECT * FROM workout_template_exercises WHERE template_id = ? ORDER BY order_index ASC',
      variables: [Variable.withString(templateId)],
      readsFrom: const {},
    ).get();
    return rows.map((row) => _exerciseFromData(row.data)).toList();
  }

  @override
  Future<WorkoutTemplate> createTemplate({
    required String userProfileId,
    required String name,
    DayType? dayType,
    String? notes,
    List<String> exerciseIds = const [],
  }) async {
    final now = DateTime.now();
    final template = WorkoutTemplate(
      id: _uuid.v4(),
      userProfileId: userProfileId,
      name: name.trim().isEmpty ? 'Untitled template' : name.trim(),
      dayType: dayType,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
    await _db.customStatement(
      'INSERT INTO workout_templates (id, user_profile_id, name, day_type, notes, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        template.id,
        userProfileId,
        template.name,
        dayType?.name,
        notes,
        now.millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      ],
    );
    for (var i = 0; i < exerciseIds.length; i++) {
      await _db.customStatement(
        'INSERT INTO workout_template_exercises (id, template_id, exercise_id, order_index) VALUES (?, ?, ?, ?)',
        [_uuid.v4(), template.id, exerciseIds[i], i],
      );
    }
    return template;
  }

  @override
  Future<WorkoutTemplate> saveSessionAsTemplate({
    required String sessionId,
    required String name,
  }) async {
    final session = await _workouts.getSession(sessionId);
    if (session == null) throw StateError('Session $sessionId not found');
    final exercises = await _workouts.getSessionExercises(sessionId);
    return createTemplate(
      userProfileId: session.userProfileId,
      name: name,
      dayType: session.dayType,
      notes: session.notes,
      exerciseIds: exercises.map((e) => e.exerciseId).toList(),
    );
  }

  @override
  Future<void> deleteTemplate(String templateId) async {
    await _db.customStatement(
      'DELETE FROM workout_template_exercises WHERE template_id = ?',
      [templateId],
    );
    await _db.customStatement('DELETE FROM workout_templates WHERE id = ?', [templateId]);
  }

  @override
  Future<WorkoutSession> startSessionFromTemplate({
    required String userProfileId,
    required String templateId,
  }) async {
    final template = await getTemplate(templateId);
    if (template == null) throw StateError('Template $templateId not found');
    final session = await _workouts.startSession(
      userProfileId: userProfileId,
      dayType: template.dayType,
      tags: const ['template'],
    );
    final exercises = await getTemplateExercises(templateId);
    for (final exercise in exercises) {
      await _workouts.ensureExercise(session.id, exercise.exerciseId);
    }
    return session;
  }
}
