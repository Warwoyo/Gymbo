/// Pure helper for the workout auto-end rule (spec §6).
class AutoEnd {
  AutoEnd._();

  /// Whether an open session should auto-complete given its last activity.
  static bool shouldAutoEnd({
    required DateTime lastActivityAt,
    required DateTime now,
    required int timeoutMinutes,
  }) {
    final deadline = lastActivityAt.add(Duration(minutes: timeoutMinutes));
    return !now.isBefore(deadline);
  }

  /// The effective end timestamp when auto-completing:
  /// `lastActivityAt + timeout`.
  static DateTime endTimestamp({
    required DateTime lastActivityAt,
    required int timeoutMinutes,
  }) =>
      lastActivityAt.add(Duration(minutes: timeoutMinutes));
}
