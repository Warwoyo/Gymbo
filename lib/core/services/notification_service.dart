import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Notification action identifiers (also used as button ids).
class NotifAction {
  static const add30 = 'ADD_30_SECONDS';
  static const skip = 'SKIP_REST';
  static const end = 'END_WORKOUT';
}

/// Wraps flutter_local_notifications to provide a silent, ongoing
/// "active workout" notification plus a rest countdown / finished update.
///
/// All methods are best-effort and guarded so the app keeps working even
/// when notifications are unavailable or permission is denied.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'active_workout';
  static const _channelName = 'Active Workout';
  static const _ongoingId = 1001;
  static const _finishedId = 1002;

  bool _ready = false;

  /// Optional callback for notification action buttons (set by the app).
  void Function(String actionId)? onAction;

  Future<void> init() async {
    if (_ready || !_isSupported) return;
    try {
      tzdata.initializeTimeZones();
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      await _plugin.initialize(
        const InitializationSettings(android: android),
        onDidReceiveNotificationResponse: (resp) {
          final id = resp.actionId;
          if (id != null && id.isNotEmpty) onAction?.call(id);
        },
      );
      final android13 = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android13?.createNotificationChannel(const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: 'Ongoing workout status and rest timer',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      ));
      _ready = true;
    } catch (e) {
      debugPrint('NotificationService init failed: $e');
    }
  }

  Future<void> requestPermission() async {
    if (!_isSupported) return;
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (_) {}
  }

  AndroidNotificationDetails _details({
    required bool ongoing,
    bool withActions = false,
    bool playSound = false,
    bool vibrate = false,
  }) {
    return AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: playSound ? Importance.defaultImportance : Importance.low,
      priority: playSound ? Priority.defaultPriority : Priority.low,
      ongoing: ongoing,
      autoCancel: !ongoing,
      playSound: playSound,
      enableVibration: vibrate,
      onlyAlertOnce: true,
      category: AndroidNotificationCategory.workout,
      actions: withActions
          ? const [
              AndroidNotificationAction(NotifAction.add30, '+30s'),
              AndroidNotificationAction(NotifAction.skip, 'Skip rest'),
              AndroidNotificationAction(NotifAction.end, 'End workout'),
            ]
          : const [],
    );
  }

  /// Persistent silent notification while a workout is active (not resting).
  Future<void> showWorkoutActive() async {
    if (!_ready) return;
    try {
      await _plugin.show(
        _ongoingId,
        'Workout in progress',
        'Tap to return to your workout.',
        NotificationDetails(android: _details(ongoing: true)),
      );
    } catch (_) {}
  }

  /// Updates the ongoing notification with a rest countdown.
  Future<void> showRestCountdown(String remaining) async {
    if (!_ready) return;
    try {
      await _plugin.show(
        _ongoingId,
        'Rest timer',
        'Next set in $remaining',
        NotificationDetails(android: _details(ongoing: true, withActions: true)),
      );
    } catch (_) {}
  }

  /// Silent (or optionally sound/vibration) "rest finished" update.
  Future<void> showRestFinished({bool sound = false, bool vibrate = false}) async {
    if (!_ready) return;
    try {
      await _plugin.show(
        _ongoingId,
        'Rest finished',
        'Ready for your next set.',
        NotificationDetails(
          android: _details(
              ongoing: true, withActions: true, playSound: sound, vibrate: vibrate),
        ),
      );
    } catch (_) {}
  }

  /// Schedules a "rest finished" notification at [endsAt] so it fires even if
  /// the app is backgrounded (inexact, no special alarm permission needed).
  Future<void> scheduleRestFinished(DateTime endsAt,
      {bool sound = false, bool vibrate = false}) async {
    if (!_ready) return;
    try {
      // Schedule at the correct absolute instant (UTC label is fine).
      final when = tz.TZDateTime.from(endsAt.toUtc(), tz.UTC);
      await _plugin.zonedSchedule(
        _finishedId,
        'Rest finished',
        'Ready for your next set.',
        when,
        NotificationDetails(
          android: _details(ongoing: false, playSound: sound, vibrate: vibrate),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (_) {}
  }

  Future<void> cancelScheduledFinish() async {
    if (!_ready) return;
    try {
      await _plugin.cancel(_finishedId);
    } catch (_) {}
  }

  Future<void> cancelAll() async {
    if (!_ready) return;
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }

  bool get _isSupported => !kIsWeb && Platform.isAndroid;
}
