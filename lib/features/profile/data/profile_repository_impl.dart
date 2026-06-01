import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/enums.dart';
import '../../../data/db/app_database.dart';
import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._db, this._prefs);

  final AppDatabase _db;
  final SharedPreferences _prefs;

  UserProfile _map(UserProfileRow row) => UserProfile(
        id: row.id,
        name: row.name,
        age: row.age,
        sex: row.sex,
        heightCm: row.heightCm,
        bodyWeightKg: row.bodyWeightKg,
        trainingExperience: row.trainingExperience,
        primaryGoal: row.primaryGoal,
        preferredWeightIncrementKg: row.preferredWeightIncrementKg,
        restTimerEnabled: row.restTimerEnabled,
        recommendationStyle:
            row.recommendationStyle ?? RecommendationStyle.balanced,
        autoEndTimeoutMinutes: row.autoEndTimeoutMinutes ?? 120,
        restNotificationsEnabled: row.restNotificationsEnabled ?? true,
        soundEnabled: row.soundEnabled ?? false,
        vibrationEnabled: row.vibrationEnabled ?? false,
        defaultAddRestSeconds: row.defaultAddRestSeconds ?? 30,
        showRpeRir: row.showRpeRir ?? true,
        dumbbellIncrementKg: row.dumbbellIncrementKg,
        barbellIncrementKg: row.barbellIncrementKg,
        machineIncrementKg: row.machineIncrementKg,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  @override
  Future<List<UserProfile>> listProfiles() async {
    final rows = await (_db.select(_db.userProfiles)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return rows.map(_map).toList();
  }

  @override
  Future<UserProfile?> getProfile(String id) async {
    final row = await (_db.select(_db.userProfiles)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _map(row);
  }

  @override
  Future<UserProfile> createOrUpdate(UserProfile profile) async {
    await _db.into(_db.userProfiles).insertOnConflictUpdate(
          UserProfilesCompanion.insert(
            id: profile.id,
            name: profile.name,
            age: Value(profile.age),
            sex: Value(profile.sex),
            heightCm: Value(profile.heightCm),
            bodyWeightKg: Value(profile.bodyWeightKg),
            trainingExperience: profile.trainingExperience,
            primaryGoal: profile.primaryGoal,
            preferredWeightIncrementKg: profile.preferredWeightIncrementKg,
            restTimerEnabled: Value(profile.restTimerEnabled),
            recommendationStyle: Value(profile.recommendationStyle),
            autoEndTimeoutMinutes: Value(profile.autoEndTimeoutMinutes),
            restNotificationsEnabled:
                Value(profile.restNotificationsEnabled),
            soundEnabled: Value(profile.soundEnabled),
            vibrationEnabled: Value(profile.vibrationEnabled),
            defaultAddRestSeconds: Value(profile.defaultAddRestSeconds),
            showRpeRir: Value(profile.showRpeRir),
            dumbbellIncrementKg: Value(profile.dumbbellIncrementKg),
            barbellIncrementKg: Value(profile.barbellIncrementKg),
            machineIncrementKg: Value(profile.machineIncrementKg),
            createdAt: profile.createdAt,
            updatedAt: profile.updatedAt,
          ),
        );
    return profile;
  }

  @override
  Future<void> deleteProfile(String id) async {
    await (_db.delete(_db.userProfiles)..where((t) => t.id.equals(id))).go();
    if (_prefs.getString(AppConstants.prefsActiveProfileId) == id) {
      await _prefs.remove(AppConstants.prefsActiveProfileId);
    }
  }

  @override
  Future<String?> getActiveProfileId() async =>
      _prefs.getString(AppConstants.prefsActiveProfileId);

  @override
  Future<void> setActiveProfileId(String? id) async {
    if (id == null) {
      await _prefs.remove(AppConstants.prefsActiveProfileId);
    } else {
      await _prefs.setString(AppConstants.prefsActiveProfileId, id);
    }
  }

  @override
  Future<UserProfile?> getActiveProfile() async {
    final id = await getActiveProfileId();
    if (id != null) {
      final found = await getProfile(id);
      if (found != null) return found;
    }
    // Fall back to the first profile if the stored id is stale.
    final all = await listProfiles();
    return all.isEmpty ? null : all.first;
  }
}
