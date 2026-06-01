import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../features/profile/presentation/profile_controller.dart';
import '../features/workout/presentation/session_providers.dart';
import 'providers.dart';
import 'router.dart';
import 'theme.dart';

class GymboApp extends ConsumerStatefulWidget {
  const GymboApp({super.key});

  @override
  ConsumerState<GymboApp> createState() => _GymboAppState();
}

class _GymboAppState extends ConsumerState<GymboApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _autoEnd();
    }
  }

  /// Auto-end stale sessions on resume, using the active profile's timeout.
  Future<void> _autoEnd() async {
    final profile = ref.read(activeProfileProvider).valueOrNull;
    final minutes = profile?.autoEndTimeoutMinutes ??
        AppConstants.autoEndAfterNoActivityMinutes;
    final ended = await ref
        .read(workoutRepositoryProvider)
        .autoEndInactiveSessions(timeoutMinutes: minutes);
    if (ended > 0) {
      ref.invalidate(activeSessionProvider);
      ref.invalidate(lastFinishedSessionProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
