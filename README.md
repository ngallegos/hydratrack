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
  - Google Drive, stored in a hidden app-only folder (one-tap sign-in; [author setup](docs/drive-setup.md))
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
docs/learn/      notes and exercises for learning Flutter/Dart
```

## Learning exercises

Several small functions are deliberately left as `// EXERCISE:` stubs with failing tests. The app still runs, but those
features stay inert until you implement them. See [docs/learn](docs/learn/README.md).

Find them with `flutter test` (failures) or by searching for `EXERCISE`.
