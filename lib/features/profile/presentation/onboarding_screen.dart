import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_controller.dart';
import 'widgets/profile_form.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Gymbo')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              'Set up your local profile. Only your name is required — '
              'everything is stored on this device.',
            ),
          ),
          Expanded(
            child: ProfileForm(
              submitLabel: 'Create profile',
              onSubmit: (data) async {
                await ref.read(activeProfileProvider.notifier).createProfile(
                      name: data.name,
                      age: data.age,
                      sex: data.sex,
                      heightCm: data.heightCm,
                      bodyWeightKg: data.bodyWeightKg,
                      experience: data.experience,
                      goal: data.goal,
                      incrementKg: data.incrementKg,
                      restTimerEnabled: data.restTimerEnabled,
                    );
                if (context.mounted) context.go('/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
