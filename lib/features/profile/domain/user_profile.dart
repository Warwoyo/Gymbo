import '../../../core/enums.dart';

/// A locally stored user profile. No authentication — identified by name.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    this.age,
    this.sex,
    this.heightCm,
    this.bodyWeightKg,
    required this.trainingExperience,
    required this.primaryGoal,
    required this.preferredWeightIncrementKg,
    required this.restTimerEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final int? age;
  final String? sex;
  final double? heightCm;
  final double? bodyWeightKg;
  final TrainingExperience trainingExperience;
  final TrainingGoal primaryGoal;
  final double preferredWeightIncrementKg;
  final bool restTimerEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile copyWith({
    String? name,
    int? age,
    String? sex,
    double? heightCm,
    double? bodyWeightKg,
    TrainingExperience? trainingExperience,
    TrainingGoal? primaryGoal,
    double? preferredWeightIncrementKg,
    bool? restTimerEnabled,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      bodyWeightKg: bodyWeightKg ?? this.bodyWeightKg,
      trainingExperience: trainingExperience ?? this.trainingExperience,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      preferredWeightIncrementKg:
          preferredWeightIncrementKg ?? this.preferredWeightIncrementKg,
      restTimerEnabled: restTimerEnabled ?? this.restTimerEnabled,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
