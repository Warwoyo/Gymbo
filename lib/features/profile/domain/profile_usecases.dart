import 'profile_repository.dart';
import 'user_profile.dart';

class CreateOrUpdateUserProfile {
  const CreateOrUpdateUserProfile(this._repo);
  final ProfileRepository _repo;
  Future<UserProfile> call(UserProfile profile) => _repo.createOrUpdate(profile);
}

class GetActiveUserProfile {
  const GetActiveUserProfile(this._repo);
  final ProfileRepository _repo;
  Future<UserProfile?> call() => _repo.getActiveProfile();
}

class ListUserProfiles {
  const ListUserProfiles(this._repo);
  final ProfileRepository _repo;
  Future<List<UserProfile>> call() => _repo.listProfiles();
}

class SelectUserProfile {
  const SelectUserProfile(this._repo);
  final ProfileRepository _repo;
  Future<void> call(String id) => _repo.setActiveProfileId(id);
}
