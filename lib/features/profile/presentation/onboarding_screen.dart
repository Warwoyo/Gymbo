import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_controller.dart';
import 'widgets/profile_form.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  var _page = 0;
  var _showProfileForm = false;

  static const _slides = [
    _OnboardingSlide(
      icon: Icons.fitness_center,
      title: 'Track sets quickly',
      description:
          'Log weight, reps, and effort in a few taps so your training stays moving.',
    ),
    _OnboardingSlide(
      icon: Icons.auto_awesome,
      title: 'Get next-set recommendations',
      description:
          'Gymbo uses your recent performance to suggest practical loads for the next set.',
    ),
    _OnboardingSlide(
      icon: Icons.map_outlined,
      title: 'Use recovery map',
      description:
          'See which muscles are fresh or fatigued before choosing your next exercise.',
    ),
    _OnboardingSlide(
      icon: Icons.lock_outline,
      title: 'Offline and private by default',
      description:
          'Your profile and workouts are stored locally on this device by default.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _continueToProfile() {
    setState(() => _showProfileForm = true);
  }

  Future<void> _nextSlide() async {
    if (_page == _slides.length - 1) {
      _continueToProfile();
      return;
    }
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Gymbo'),
        actions: [
          if (!_showProfileForm)
            TextButton(
              onPressed: _continueToProfile,
              child: const Text('Skip'),
            ),
        ],
      ),
      body: _showProfileForm ? _buildProfileCreation() : _buildOnboarding(),
    );
  }

  Widget _buildOnboarding() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (value) => setState(() => _page = value),
              itemBuilder: (context, index) => _OnboardingSlideView(
                slide: _slides[index],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _page == index ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: _page == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: _nextSlide,
              child: Text(_page == _slides.length - 1
                  ? 'Create profile'
                  : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCreation() {
    return Column(
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
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _OnboardingSlideView extends StatelessWidget {
  const _OnboardingSlideView({required this.slide});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
            child: Icon(slide.icon, size: 44),
          ),
          const SizedBox(height: 28),
          Text(
            slide.title,
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            slide.description,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
