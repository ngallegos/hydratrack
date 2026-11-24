# HydraTrack

Free, login-free hydration tracker. Flutter app for Android and the web (installable PWA).

## Features

- Quick-log starred drinks with one tap, with undo
- Drink categories with their own hydration level and color (water counts fully, coffee less, and so on); fully editable
- Avatars (bottle, drop, cactus, fish) that fill with a wave, in stacked category colors
- Reminders inside a daily window, on chosen weekdays, stopping once you hit your goal
- History with editing and back-dating, week/month charts, streaks and achievements
- Goal suggestion from weight and activity
- Works fully offline with no account. Optional sync:
  - a shared folder (Syncthing, Dropbox, ...), or
  - Google Drive on Android, stored in a hidden app-only folder (one-tap sign-in; [author setup](docs/drive-setup.md),
    tracked in [#3](https://github.com/ngallegos/hydratrack/issues/3); browser sign-in in
    [#13](https://github.com/ngallegos/hydratrack/issues/13))
- JSON backup/restore and CSV export

## Develop

```sh
flutter pub get
flutter analyze
flutter test
flutter run -d chrome          # or an Android device/emulator
dart run build_runner build --delete-conflicting-outputs   # after changing freezed/drift/json classes
```

Android builds need the Android SDK with platform 37 (required by the notifications plugin).

## Project layout

```
lib/domain/      pure models and rules (hydration, goals, streaks, reminders)
lib/data/        drift database, repositories, sync, backup
lib/platform/    wrappers around plugins (notifications, pickers, Google sign-in)
lib/features/    screens and providers, one folder per feature
docs/learn/      notes for learning Flutter/Dart
```

## Learning notes

The build is documented phase by phase in [docs/learn](docs/learn/README.md). Six small functions were left as
exercises along the way; all are implemented, and their notes keep the hints as a reference.

## Status

The initial implementation is complete. Remaining work is tracked in the
[roadmap](https://github.com/ngallegos/hydratrack/issues/15).
