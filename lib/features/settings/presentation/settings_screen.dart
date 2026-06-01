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
                _header(context, 'Profile'),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Edit profile'),
                  subtitle:
                      Text('${profile.name} • ${profile.primaryGoal.label}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/edit-profile'),
                ),
                ListTile(
                  leading: const Icon(Icons.people_alt_outlined),
                  title: const Text('Switch / add profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/profiles'),
                ),

                _header(context, 'Recommendations'),
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

                _header(context, 'Rest & notifications'),
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
                  onChanged: (v) =>
                      update(profile.copyWith(restNotificationsEnabled: v)),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_outlined),
                  title: const Text('Sound on rest finished'),
                  value: profile.soundEnabled,
                  onChanged: (v) => update(profile.copyWith(soundEnabled: v)),
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

                _header(context, 'Weight increments'),
                _dropdownTile<double>(
                  context,
                  icon: Icons.fitness_center,
                  title: 'Default increment',
                  value: profile.preferredWeightIncrementKg,
                  options: _incrementOptions,
                  labelOf: (v) => '$v kg',
                  onChanged: (v) =>
                      update(profile.copyWith(preferredWeightIncrementKg: v)),
                ),
                _incrementTile(context, 'Dumbbell', profile.dumbbellIncrementKg,
                    (v) => update(profile.copyWith(dumbbellIncrementKg: v))),
                _incrementTile(context, 'Barbell', profile.barbellIncrementKg,
                    (v) => update(profile.copyWith(barbellIncrementKg: v))),
                _incrementTile(context, 'Machine / cable',
                    profile.machineIncrementKg,
                    (v) => update(profile.copyWith(machineIncrementKg: v))),

                _header(context, 'Session'),
                _dropdownTile<int>(
                  context,
                  icon: Icons.hourglass_bottom,
                  title: 'Auto-end after inactivity',
                  value: _timeoutOptions.contains(profile.autoEndTimeoutMinutes)
                      ? profile.autoEndTimeoutMinutes
                      : 120,
                  options: _timeoutOptions,
                  labelOf: (v) => '$v min',
                  onChanged: (v) =>
                      update(profile.copyWith(autoEndTimeoutMinutes: v)),
                ),

                const Divider(),
                AboutListTile(
                  icon: const Icon(Icons.info_outline),
                  applicationName: AppConstants.appName,
                  applicationVersion: '1.1.0',
                  aboutBoxChildren: const [
                    SizedBox(height: 12),
                    Text(AppConstants.medicalDisclaimer),
                  ],
                  child: const Text('About & disclaimer'),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    AppConstants.medicalDisclaimer,
                    style:
                        TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _header(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
      );

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
}
