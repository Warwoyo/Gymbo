/// App-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'Gymbo';

  /// Default inactivity timeout (minutes) before an open session auto-completes.
  static const int autoEndAfterNoActivityMinutes = 120;

  /// Default weight increment (kg) when none is configured.
  static const double defaultIncrementKg = 2.5;

  /// Default dumbbell increment options.
  static const double dumbbellIncrementSmall = 1.0;
  static const double dumbbellIncrementLarge = 2.0;

  /// Performance adjustment factors (see spec §4).
  static const double increaseFactor = 1.025;
  static const double largeIncreaseFactor = 1.05;
  static const double smallDecreaseFactor = 0.95;
  static const double largeDecreaseFactor = 0.90;

  /// SharedPreferences keys.
  static const String prefsActiveProfileId = 'active_profile_id';

  static const String medicalDisclaimer =
      'This app provides general workout tracking and load recommendations '
      'based on common strength-training formulas. It is not medical advice. '
      'Stop exercising if you feel pain, dizziness, or unusual discomfort.';
}
