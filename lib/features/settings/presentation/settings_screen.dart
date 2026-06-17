import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/enums.dart';
import '../../profile/domain/user_profile.dart';
import '../../profile/presentation/profile_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _incrementOptions = [0.5, 1.0, 2.0, 2.5, 5.0];
  static const _timeoutOptions = [60, 90, 120, 180];
  static const _addRestOptions = [15, 30, 45, 60];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final controller = ref.read(activeProfileProvider.notifier);

    void update(UserProfile p) => controller.updateProfile(p);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: profile == null
          ? const Center(child: Text('No profile'))
          : ListView(
              children: [
                ExpansionTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Profile'),
                  subtitle:
                      Text('${profile.name} • ${profile.primaryGoal.label}'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Edit profile'),
                      subtitle: Text(
                          '${profile.name} • ${profile.primaryGoal.label}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/edit-profile'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.people_alt_outlined),
                      title: const Text('Switch / add profile'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/profiles'),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.tune),
                  title: const Text('Recommendations'),
                  subtitle: Text(_styleHint(profile.recommendationStyle)),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.tune),
                      title: const Text('Recommendation style'),
                      subtitle: Text(_styleHint(profile.recommendationStyle)),
                      trailing: DropdownButton<RecommendationStyle>(
                        value: profile.recommendationStyle,
                        items: RecommendationStyle.values
                            .map((s) => DropdownMenuItem(
                                value: s, child: Text(s.label)))
                            .toList(),
                        onChanged: (v) => v == null
                            ? null
                            : update(profile.copyWith(recommendationStyle: v)),
                      ),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.speed),
                      title: const Text('Show RPE / RIR fields'),
                      value: profile.showRpeRir,
                      onChanged: (v) => update(profile.copyWith(showRpeRir: v)),
                    ),
                    _resetTile(
                      title: 'Reset recommendations to defaults',
                      onTap: () => update(profile.copyWith(
                        recommendationStyle: RecommendationStyle.balanced,
                        showRpeRir: true,
                      )),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.timer_outlined),
                  title: const Text('Rest Timer & Notifications'),
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.timer_outlined),
                      title: const Text('Auto-start rest timer'),
                      value: profile.restTimerEnabled,
                      onChanged: (v) =>
                          update(profile.copyWith(restTimerEnabled: v)),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_outlined),
                      title: const Text('Rest / workout notifications'),
                      subtitle: const Text('Silent, ongoing while training'),
                      value: profile.restNotificationsEnabled,
                      onChanged: (v) => update(
                          profile.copyWith(restNotificationsEnabled: v)),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.volume_up_outlined),
                      title: const Text('Sound on rest finished'),
                      value: profile.soundEnabled,
                      onChanged: (v) =>
                          update(profile.copyWith(soundEnabled: v)),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.vibration),
                      title: const Text('Vibration on rest finished'),
                      value: profile.vibrationEnabled,
                      onChanged: (v) =>
                          update(profile.copyWith(vibrationEnabled: v)),
                    ),
                    _dropdownTile<int>(
                      context,
                      icon: Icons.more_time,
                      title: 'Default "add rest" seconds',
                      value: profile.defaultAddRestSeconds,
                      options: _addRestOptions,
                      labelOf: (v) => '$v s',
                      onChanged: (v) =>
                          update(profile.copyWith(defaultAddRestSeconds: v)),
                    ),
                    _resetTile(
                      title: 'Reset rest timer & notifications to defaults',
                      onTap: () => update(profile.copyWith(
                        restTimerEnabled: true,
                        restNotificationsEnabled: true,
                        soundEnabled: false,
                        vibrationEnabled: false,
                        defaultAddRestSeconds: 30,
                      )),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.fitness_center),
                  title: const Text('Equipment & Increments'),
                  children: [
                    _dropdownTile<double>(
                      context,
                      icon: Icons.fitness_center,
                      title: 'Default increment',
                      value: profile.preferredWeightIncrementKg,
                      options: _incrementOptions,
                      labelOf: (v) => '$v kg',
                      onChanged: (v) => update(
                          profile.copyWith(preferredWeightIncrementKg: v)),
                    ),
                    _incrementTile(
                      context,
                      'Dumbbell',
                      profile.dumbbellIncrementKg,
                      (v) => update(_profileWithIncrements(
                        profile,
                        dumbbellIncrementKg: v,
                        resetDumbbellIncrement: v == null,
                      )),
                    ),
                    _incrementTile(
                      context,
                      'Barbell',
                      profile.barbellIncrementKg,
                      (v) => update(_profileWithIncrements(
                        profile,
                        barbellIncrementKg: v,
                        resetBarbellIncrement: v == null,
                      )),
                    ),
                    _incrementTile(
                      context,
                      'Machine / cable',
                      profile.machineIncrementKg,
                      (v) => update(_profileWithIncrements(
                        profile,
                        machineIncrementKg: v,
                        resetMachineIncrement: v == null,
                      )),
                    ),
                    _resetTile(
                      title: 'Reset increments to defaults',
                      onTap: () => update(_profileWithIncrements(
                        profile,
                        preferredWeightIncrementKg:
                            AppConstants.defaultIncrementKg,
                        resetDumbbellIncrement: true,
                        resetBarbellIncrement: true,
                        resetMachineIncrement: true,
                      )),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.hourglass_bottom),
                  title: const Text('Session'),
                  children: [
                    _dropdownTile<int>(
                      context,
                      icon: Icons.hourglass_bottom,
                      title: 'Auto-end after inactivity',
                      value: _timeoutOptions
                              .contains(profile.autoEndTimeoutMinutes)
                          ? profile.autoEndTimeoutMinutes
                          : AppConstants.autoEndAfterNoActivityMinutes,
                      options: _timeoutOptions,
                      labelOf: (v) => '$v min',
                      onChanged: (v) => update(
                          profile.copyWith(autoEndTimeoutMinutes: v)),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About & Data'),
                  children: const [
                    AboutListTile(
                      icon: Icon(Icons.info_outline),
                      applicationName: AppConstants.appName,
                      applicationVersion: '1.1.0',
                      aboutBoxChildren: [
                        SizedBox(height: 12),
                        Text(AppConstants.medicalDisclaimer),
                      ],
                      child: Text('About & disclaimer'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        AppConstants.medicalDisclaimer,
                        style: TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  String _styleHint(RecommendationStyle s) {
    switch (s) {
      case RecommendationStyle.conservative:
        return 'Progress only when reps exceed the range at low effort.';
      case RecommendationStyle.balanced:
        return 'Progress when you reach the top of the range.';
      case RecommendationStyle.aggressive:
        return 'Progress at the top of the range unless near failure.';
    }
  }

  Widget _resetTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: const Icon(Icons.restart_alt),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _dropdownTile<T>(
    BuildContext context, {
    required IconData icon,
    required String title,
    required T value,
    required List<T> options,
    required String Function(T) labelOf,
    required void Function(T) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<T>(
        value: value,
        items: options
            .map((o) => DropdownMenuItem(value: o, child: Text(labelOf(o))))
            .toList(),
        onChanged: (v) => v == null ? null : onChanged(v),
      ),
    );
  }

  Widget _incrementTile(BuildContext context, String label, double? value,
      void Function(double?) onChanged) {
    return ListTile(
      leading: const Icon(Icons.straighten),
      title: Text('$label increment'),
      subtitle: Text(value == null ? 'Use default' : '$value kg'),
      trailing: DropdownButton<double?>(
        value: value,
        hint: const Text('Default'),
        items: [
          const DropdownMenuItem<double?>(value: null, child: Text('Default')),
          ..._incrementOptions.map((o) =>
              DropdownMenuItem<double?>(value: o, child: Text('$o kg'))),
        ],
        onChanged: onChanged,
      ),
    );
  }

  UserProfile _profileWithIncrements(
    UserProfile profile, {
    double? preferredWeightIncrementKg,
    double? dumbbellIncrementKg,
    double? barbellIncrementKg,
    double? machineIncrementKg,
    bool resetDumbbellIncrement = false,
    bool resetBarbellIncrement = false,
    bool resetMachineIncrement = false,
  }) {
    return UserProfile(
      id: profile.id,
      name: profile.name,
      age: profile.age,
      sex: profile.sex,
      heightCm: profile.heightCm,
      bodyWeightKg: profile.bodyWeightKg,
      trainingExperience: profile.trainingExperience,
      primaryGoal: profile.primaryGoal,
      preferredWeightIncrementKg:
          preferredWeightIncrementKg ?? profile.preferredWeightIncrementKg,
      restTimerEnabled: profile.restTimerEnabled,
      recommendationStyle: profile.recommendationStyle,
      autoEndTimeoutMinutes: profile.autoEndTimeoutMinutes,
      restNotificationsEnabled: profile.restNotificationsEnabled,
      soundEnabled: profile.soundEnabled,
      vibrationEnabled: profile.vibrationEnabled,
      defaultAddRestSeconds: profile.defaultAddRestSeconds,
      showRpeRir: profile.showRpeRir,
      dumbbellIncrementKg: resetDumbbellIncrement
          ? null
          : dumbbellIncrementKg ?? profile.dumbbellIncrementKg,
      barbellIncrementKg: resetBarbellIncrement
          ? null
          : barbellIncrementKg ?? profile.barbellIncrementKg,
      machineIncrementKg: resetMachineIncrement
          ? null
          : machineIncrementKg ?? profile.machineIncrementKg,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
