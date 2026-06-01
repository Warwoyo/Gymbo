import 'user_profile.dart';

/// Abstraction the presentation layer depends on (dependency inversion).
abstract class ProfileRepository {
  Future<List<UserProfile>> listProfiles();
  Future<UserProfile?> getProfile(String id);
  Future<UserProfile> createOrUpdate(UserProfile profile);
  Future<void> deleteProfile(String id);

  /// Active profile selection (persisted locally).
  Future<String?> getActiveProfileId();
  Future<void> setActiveProfileId(String? id);
  Future<UserProfile?> getActiveProfile();
}
