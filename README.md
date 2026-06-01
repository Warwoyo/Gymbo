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
- **Evidence-informed recommendation engine** (autoregulated progressive overload):
  - Epley e1RM (`weight × (1 + reps/30)`) + inverse Epley for load.
  - Per-**exercise-category** rep/set/rest defaults (compound vs isolation vs
    machine vs bodyweight vs assisted vs core).
  - Ascending-load progression: hit the top of the range with manageable
    effort → increase load and drop reps (e.g. 15 kg×12 → 17.5 kg×8–10).
  - Autoregulation from RPE/RIR/failure, **rest-aware** adjustments, and
    performance-drop detection.
  - Isolation guardrails (no aggressive low-rep jumps), assisted-bodyweight
    progression (reduce assistance), and suggested working-set counts.
  - Configurable style: conservative / balanced / aggressive. Recommendations
    are described as *evidence-informed heuristics*, never medical advice.
- **Rest timer**: start/pause/resume/skip/+30 s, wall-clock based so it stays
  accurate across backgrounding; **persisted** so it survives process death.
- **Silent notifications**: ongoing "workout in progress" + rest countdown,
  rest-finished update with +30 s / skip / end actions (sound & vibration off
  by default).
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
