import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/constants/app_constants.dart';
import 'core/services/notification_service.dart';
import 'data/db/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final prefs = await SharedPreferences.getInstance();

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermission();

  final container = ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(db),
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );

  // Seed the generic catalog and auto-end any stale sessions on startup.
  await container.read(exerciseRepositoryProvider).seedIfEmpty();
  await container.read(workoutRepositoryProvider).autoEndInactiveSessions(
        timeoutMinutes: AppConstants.autoEndAfterNoActivityMinutes,
      );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const GymboApp(),
    ),
  );
}
