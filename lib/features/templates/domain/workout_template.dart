import '../../../core/enums.dart';

class WorkoutTemplate {
  const WorkoutTemplate({
    required this.id,
    required this.userProfileId,
    required this.name,
    this.dayType,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userProfileId;
  final String name;
  final DayType? dayType;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
