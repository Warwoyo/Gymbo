import '../../../core/enums.dart';

/// A catalog exercise. Seeded generically and extensible by the user.
class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.dayType,
    required this.primaryMuscleGroup,
    this.secondaryMuscleGroups = const [],
    required this.movementPattern,
    required this.equipmentType,
    required this.isBodyweight,
    required this.isUnilateral,
    this.notes,
    this.isCustom = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final DayType dayType;
  final String primaryMuscleGroup;
  final List<String> secondaryMuscleGroups;
  final String movementPattern;
  final EquipmentType equipmentType;
  final bool isBodyweight;
  final bool isUnilateral;
  final String? notes;
  final bool isCustom;
  final DateTime createdAt;
  final DateTime updatedAt;
}
