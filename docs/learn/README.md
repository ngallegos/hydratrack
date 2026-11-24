# Learning Flutter/Dart with HydraTrack

One note per build phase. Phases 2-7 each had an exercise, now implemented; the hints stay in the notes. Written for a C#/.NET developer.

| Phase | Notes |
| --- | --- |
| 1 | [Scaffold](01-scaffold.md) |
| 2 | [Data layer](02-data.md) — exercise: `hydrationByCategory` |
| 3 | [Home screen](03-home.md) — exercise: `StarredDrinkChip` |
| 4 | [Configuration](04-config.md) — exercise: `suggestedDailyGoalMl` |
| 5 | [History and stats](05-history.md) — exercise: `currentStreak` |
| 6 | [Reminders](06-reminders.md) — exercise: `reminderSlots` |
| 7 | [Sync](07-sync.md) — exercise: `remoteWins` |
| 8 | [Backup, export and PWA](08-backup-and-pwa.md) |

## Toolchain cheatsheet

| Task | Command | .NET analogy |
| --- | --- | --- |
| Restore packages | `flutter pub get` | `dotnet restore` |
| Add package | `flutter pub add <pkg>` | `dotnet add package` |
| Static analysis | `flutter analyze` | Roslyn analyzers / build warnings |
| Run tests | `flutter test` | `dotnet test` |
| Run app | `flutter run -d chrome` | `dotnet run` |
| Codegen | `dart run build_runner build` | source generators (but run explicitly) |
| Environment check | `flutter doctor` | `dotnet --info` |

While `flutter run` is active: `r` hot reload (keeps state), `R` hot restart (resets state), `q` quit.
