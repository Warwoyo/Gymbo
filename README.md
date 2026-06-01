# Gymbo 🏋️

A **local-first, offline** personal gym workout tracker for Android, built with
Flutter. Plan, perform, and review Push / Pull / Leg workouts with
scientifically grounded load, rep, set, and rest recommendations — no login,
no cloud, no accounts. All data stays on your device.

## Features

- **Local profiles** (no auth) with training goal, experience, and preferred
  weight increment. Multiple profiles supported, selectable by name.
- **Push / Pull / Leg** day types with a seeded, generic, extensible exercise
  catalog (~44 exercises across common gym equipment).
- **Workout sessions**: start, log sets, auto rest timer, manual or automatic
  end (after 120 min of inactivity).
- **Epley-based recommendation engine**:
  - Estimated 1RM: `e1RM = weight × (1 + reps / 30)`
  - Recommended load (inverse Epley): `load = e1RM / (1 + targetReps / 30)`
  - Goal-based rep/set/intensity/rest profiles
  - Performance-based load progression (±2.5 % / 5 % / 10 %)
- **Rest timer**: start/pause/resume/skip/+30 s, wall-clock based so it stays
  accurate across backgrounding; haptic + sound on finish.
- **Workout summary**: duration, exercises, working sets, total reps, total
  volume load, best e1RM per exercise, set-by-set history, personal records.
- **History & per-exercise progress**.

## Architecture

Feature-first **Clean Architecture** with **Riverpod** for state and **Drift
(SQLite)** for local persistence with migrations.

```
lib/
  app/            App shell, router, theme, DI providers
  core/           enums, constants, utils, shared widgets
  data/db/        Drift database, tables, migrations
  features/
    profile/            data | domain | presentation
    exercise_catalog/   data | domain | presentation
    workout/            data | domain | presentation
    recommendations/    domain (pure engine) | presentation
    history/            presentation
    settings/           presentation
    home/               presentation
```

Presentation depends on domain abstractions (repository interfaces); the Drift
implementations live in `data/`.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generate Drift code
flutter test
flutter run                 # debug on a connected device/emulator
flutter build apk --release # release APK -> build/app/outputs/flutter-apk/
```

## Tests

Pure-Dart unit tests cover the business logic: Epley e1RM, inverse Epley load,
rounding, goal mapping, performance adjustment, rest defaults, auto-end rule,
and summary calculations (`test/`).

## Disclaimer

This app provides general workout tracking and load recommendations based on
common strength-training formulas. It is **not medical advice**. Stop
exercising if you feel pain, dizziness, or unusual discomfort.
