import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/providers.dart';
import '../../../core/enums.dart';
import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';

const _uuid = Uuid();

/// All locally stored profiles.
final profileListProvider = FutureProvider<List<UserProfile>>((ref) {
  // Re-fetch whenever the active profile changes.
  ref.watch(activeProfileProvider);
  return ref.watch(profileRepositoryProvider).listProfiles();
});

final activeProfileProvider =
    AsyncNotifierProvider<ActiveProfileController, UserProfile?>(
        ActiveProfileController.new);

class ActiveProfileController extends AsyncNotifier<UserProfile?> {
  ProfileRepository get _repo => ref.read(profileRepositoryProvider);

  @override
  Future<UserProfile?> build() => _repo.getActiveProfile();

  Future<UserProfile> createProfile({
    required String name,
    int? age,
    String? sex,
    double? heightCm,
    double? bodyWeightKg,
    required TrainingExperience experience,
    required TrainingGoal goal,
    required double incrementKg,
    bool restTimerEnabled = true,
  }) async {
    final now = DateTime.now();
    final profile = UserProfile(
      id: _uuid.v4(),
      name: name.trim(),
      age: age,
      sex: sex,
      heightCm: heightCm,
      bodyWeightKg: bodyWeightKg,
      trainingExperience: experience,
      primaryGoal: goal,
      preferredWeightIncrementKg: incrementKg,
      restTimerEnabled: restTimerEnabled,
      createdAt: now,
      updatedAt: now,
    );
    await _repo.createOrUpdate(profile);
    await _repo.setActiveProfileId(profile.id);
    state = AsyncData(profile);
    return profile;
  }

  Future<void> updateProfile(UserProfile profile) async {
    final updated = profile.copyWith(updatedAt: DateTime.now());
    await _repo.createOrUpdate(updated);
    state = AsyncData(updated);
  }

  Future<void> selectProfile(String id) async {
    await _repo.setActiveProfileId(id);
    state = AsyncData(await _repo.getProfile(id));
  }
}
