import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_controller.dart';
import 'widgets/profile_form.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(activeProfileProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: profile == null
          ? const Center(child: Text('No profile'))
          : ProfileForm(
              initial: profile,
              submitLabel: 'Save changes',
              onSubmit: (data) async {
                final updated = profile.copyWith(
                  name: data.name,
                  age: data.age,
                  sex: data.sex,
                  heightCm: data.heightCm,
                  bodyWeightKg: data.bodyWeightKg,
                  trainingExperience: data.experience,
                  primaryGoal: data.goal,
                  preferredWeightIncrementKg: data.incrementKg,
                  restTimerEnabled: data.restTimerEnabled,
                );
                await ref
                    .read(activeProfileProvider.notifier)
                    .updateProfile(updated);
                if (context.mounted) context.pop();
              },
            ),
    );
  }
}
