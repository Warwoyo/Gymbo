import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/db/app_database.dart';

class DataExportService {
  DataExportService(this._db);

  final AppDatabase _db;
  static const int exportSchemaVersion = 1;
  static const _uuid = Uuid();

  Future<String> exportJson() async {
    final payload = <String, Object?>{
      'app': 'Gymbo',
      'schemaVersion': exportSchemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'profiles': await _rows('user_profiles'),
        'exercises': await _rows(
          'exercises',
          where: 'is_custom = 1',
        ),
        'workoutSessions': await _rows('workout_sessions'),
        'workoutExercises': await _rows('workout_exercises'),
        'sets': await _rows('workout_sets'),
        'templates': await _rows('workout_templates'),
        'templateExercises': await _rows('workout_template_exercises'),
      },
    };

    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  Future<DataImportResult> importJson(String source) async {
    final decoded = jsonDecode(source);
    if (decoded is! Map) {
      throw const FormatException('Import file must contain a JSON object.');
    }

    final schemaVersion = decoded['schemaVersion'];
    if (schemaVersion is! int) {
      throw const FormatException('Missing export schema version.');
    }
    if (schemaVersion > exportSchemaVersion) {
      throw FormatException(
        'Export schema version $schemaVersion is newer than supported version '
        '$exportSchemaVersion.',
      );
    }

    final data = decoded.cast<String, Object?>()['data'];
    if (data is! Map) {
      throw const FormatException('Missing export data.');
    }

    final idMap = <String, String>{};
    var imported = 0;
    var remapped = 0;

    await _db.transaction(() async {
      Future<void> importTable(
        String key,
        String table, {
        Map<String, String> foreignKeys = const {},
      }) async {
        final rows = _list(data[key]);
        for (final original in rows) {
          final row = Map<String, Object?>.from(original);
          final id = row['id'];
          if (id is String && id.isNotEmpty) {
            final existing = idMap[id];
            if (existing != null) {
              row['id'] = existing;
            } else if (await _idExists(table, id)) {
              final replacement = _uuid.v4();
              idMap[id] = replacement;
              row['id'] = replacement;
              remapped++;
            } else {
              idMap[id] = id;
            }
          }

          for (final entry in foreignKeys.entries) {
            final value = row[entry.key];
            if (value is String && idMap.containsKey(value)) {
              row[entry.key] = idMap[value];
            }
          }

          await _insert(table, row);
          imported++;
        }
      }

      await importTable('profiles', 'user_profiles');
      await importTable('exercises', 'exercises', foreignKeys: {
        'user_profile_id': 'user_profiles',
      });
      await importTable('workoutSessions', 'workout_sessions', foreignKeys: {
        'user_profile_id': 'user_profiles',
      });
      await importTable('workoutExercises', 'workout_exercises', foreignKeys: {
        'session_id': 'workout_sessions',
        'exercise_id': 'exercises',
      });
      await importTable('sets', 'workout_sets', foreignKeys: {
        'workout_exercise_id': 'workout_exercises',
      });
      await importTable('templates', 'workout_templates', foreignKeys: {
        'user_profile_id': 'user_profiles',
      });
      await importTable(
        'templateExercises',
        'workout_template_exercises',
        foreignKeys: {
          'template_id': 'workout_templates',
          'exercise_id': 'exercises',
        },
      );
    });

    return DataImportResult(importedRows: imported, remappedIds: remapped);
  }

  Future<void> deleteAllLocalData() async {
    await _db.transaction(() async {
      for (final table in [
        'workout_template_exercises',
        'workout_templates',
        'workout_region_impacts',
        'workout_muscle_impacts',
        'exercise_muscle_targets',
        'rest_timer_states',
        'workout_sets',
        'workout_exercises',
        'workout_sessions',
        'exercises',
        'user_profiles',
      ]) {
        await _db.customStatement('DELETE FROM $table');
      }
    });
  }

  Future<List<Map<String, Object?>>> _rows(
    String table, {
    String? where,
  }) async {
    final query = 'SELECT * FROM $table${where == null ? '' : ' WHERE $where'}';
    final rows = await _db.customSelect(query).get();
    return rows.map((row) => row.data).toList();
  }

  List<Map<String, Object?>> _list(Object? value) {
    if (value == null) return const [];
    if (value is! List) {
      throw const FormatException('Export data tables must be arrays.');
    }
    return value.map((row) {
      if (row is! Map) {
        throw const FormatException('Export rows must be objects.');
      }
      return row.cast<String, Object?>();
    }).toList();
  }

  Future<bool> _idExists(String table, String id) async {
    final result = await _db.customSelect(
      'SELECT id FROM $table WHERE id = ? LIMIT 1',
      variables: [Variable.withString(id)],
    ).getSingleOrNull();
    return result != null;
  }

  Future<void> _insert(String table, Map<String, Object?> row) async {
    if (row.isEmpty) return;
    final columns = row.keys.toList();
    final placeholders = List.filled(columns.length, '?').join(', ');
    await _db.customStatement(
      'INSERT OR IGNORE INTO $table (${columns.join(', ')}) VALUES ($placeholders)',
      columns.map(_variable).toList(),
    );
  }

  Variable<Object> _variable(Object? value) {
    if (value == null) return const Variable(null);
    if (value is int) return Variable.withInt(value);
    if (value is double) return Variable.withReal(value);
    if (value is bool) return Variable.withBool(value);
    return Variable.withString(value.toString());
  }
}

class DataImportResult {
  const DataImportResult({
    required this.importedRows,
    required this.remappedIds,
  });

  final int importedRows;
  final int remappedIds;
}
