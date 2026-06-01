import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../profile/presentation/profile_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _incrementOptions = [0.5, 1.0, 2.0, 2.5, 5.0];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;
    final controller = ref.read(activeProfileProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          if (profile != null) ...[
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit profile'),
              subtitle: Text('${profile.name} • ${profile.primaryGoal.label}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/edit-profile'),
            ),
            const Divider(),
            SwitchListTile(
              secondary: const Icon(Icons.timer_outlined),
              title: const Text('Auto-start rest timer'),
              value: profile.restTimerEnabled,
              onChanged: (v) => controller
                  .updateProfile(profile.copyWith(restTimerEnabled: v)),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Weight increment'),
              subtitle:
                  Text('${profile.preferredWeightIncrementKg} kg rounding'),
              trailing: DropdownButton<double>(
                value: _incrementOptions
                        .contains(profile.preferredWeightIncrementKg)
                    ? profile.preferredWeightIncrementKg
                    : null,
                items: _incrementOptions
                    .map((v) =>
                        DropdownMenuItem(value: v, child: Text('$v kg')))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    controller.updateProfile(
                        profile.copyWith(preferredWeightIncrementKg: v));
                  }
                },
              ),
            ),
            const Divider(),
          ],
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('Switch / add profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profiles'),
          ),
          const Divider(),
          AboutListTile(
            icon: const Icon(Icons.info_outline),
            applicationName: AppConstants.appName,
            applicationVersion: '1.0.0',
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
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
