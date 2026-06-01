import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import 'router.dart';
import 'theme.dart';

class GymboApp extends StatelessWidget {
  const GymboApp({super.key});

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
