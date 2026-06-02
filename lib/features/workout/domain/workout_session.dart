import '../../../core/enums.dart';

/// A workout session. Day type is optional metadata for flexible sessions.
class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.userProfileId,
    this.dayType,
    required this.startedAt,
    this.endedAt,
    required this.lastActivityAt,
    required this.status,
    this.sessionName,
    this.tags = const [],
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userProfileId;
  final DayType? dayType;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime lastActivityAt;
  final WorkoutSessionStatus status;
  final String? sessionName;
  final List<String> tags;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Duration get duration =>
      (endedAt ?? DateTime.now()).difference(startedAt);

  WorkoutSession copyWith({
    DayType? dayType,
    DateTime? endedAt,
    DateTime? lastActivityAt,
    WorkoutSessionStatus? status,
    String? sessionName,
    List<String>? tags,
    String? notes,
    DateTime? updatedAt,
  }) {
    return WorkoutSession(
      id: id,
      userProfileId: userProfileId,
      dayType: dayType ?? this.dayType,
      startedAt: startedAt,
      endedAt: endedAt ?? this.endedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      status: status ?? this.status,
      sessionName: sessionName ?? this.sessionName,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
