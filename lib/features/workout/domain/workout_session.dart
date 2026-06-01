import '../../../core/enums.dart';

/// A single workout session for a profile on a given day type.
class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.userProfileId,
    required this.dayType,
    required this.startedAt,
    this.endedAt,
    required this.lastActivityAt,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userProfileId;
  final DayType dayType;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime lastActivityAt;
  final WorkoutSessionStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Duration get duration =>
      (endedAt ?? DateTime.now()).difference(startedAt);

  WorkoutSession copyWith({
    DateTime? endedAt,
    DateTime? lastActivityAt,
    WorkoutSessionStatus? status,
    String? notes,
    DateTime? updatedAt,
  }) {
    return WorkoutSession(
      id: id,
      userProfileId: userProfileId,
      dayType: dayType,
      startedAt: startedAt,
      endedAt: endedAt ?? this.endedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
