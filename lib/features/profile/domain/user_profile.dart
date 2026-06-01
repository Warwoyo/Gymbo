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
    this.recommendationStyle = RecommendationStyle.balanced,
    this.autoEndTimeoutMinutes = 120,
    this.restNotificationsEnabled = true,
    this.soundEnabled = false,
    this.vibrationEnabled = false,
    this.defaultAddRestSeconds = 30,
    this.showRpeRir = true,
    this.dumbbellIncrementKg,
    this.barbellIncrementKg,
    this.machineIncrementKg,
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

  // Evidence-informed engine + workout preferences.
  final RecommendationStyle recommendationStyle;
  final int autoEndTimeoutMinutes;
  final bool restNotificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final int defaultAddRestSeconds;
  final bool showRpeRir;
  final double? dumbbellIncrementKg;
  final double? barbellIncrementKg;
  final double? machineIncrementKg;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Preferred increment for an equipment type, falling back to the global one.
  double incrementForEquipment(EquipmentType eq) {
    switch (eq) {
      case EquipmentType.dumbbell:
        return dumbbellIncrementKg ?? preferredWeightIncrementKg;
      case EquipmentType.barbell:
      case EquipmentType.smithMachine:
        return barbellIncrementKg ?? preferredWeightIncrementKg;
      case EquipmentType.machine:
      case EquipmentType.plateLoaded:
      case EquipmentType.cable:
        return machineIncrementKg ?? preferredWeightIncrementKg;
      default:
        return preferredWeightIncrementKg;
    }
  }

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
    RecommendationStyle? recommendationStyle,
    int? autoEndTimeoutMinutes,
    bool? restNotificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    int? defaultAddRestSeconds,
    bool? showRpeRir,
    double? dumbbellIncrementKg,
    double? barbellIncrementKg,
    double? machineIncrementKg,
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
      recommendationStyle: recommendationStyle ?? this.recommendationStyle,
      autoEndTimeoutMinutes:
          autoEndTimeoutMinutes ?? this.autoEndTimeoutMinutes,
      restNotificationsEnabled:
          restNotificationsEnabled ?? this.restNotificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      defaultAddRestSeconds:
          defaultAddRestSeconds ?? this.defaultAddRestSeconds,
      showRpeRir: showRpeRir ?? this.showRpeRir,
      dumbbellIncrementKg: dumbbellIncrementKg ?? this.dumbbellIncrementKg,
      barbellIncrementKg: barbellIncrementKg ?? this.barbellIncrementKg,
      machineIncrementKg: machineIncrementKg ?? this.machineIncrementKg,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
