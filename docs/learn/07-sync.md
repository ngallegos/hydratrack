# 07 — Sync

## Exercise

Implement `remoteWins` in `lib/data/sync/last_write_wins.dart`. The rules are in the comment above it. Run
`flutter test test/data/sync/last_write_wins_test.dart`. Afterwards the end-to-end test in
`test/data/sync/sync_service_test.dart` ("works end to end with the real last-write-wins rule") should pass too.

Hints:
- `DateTime.compareTo` returns negative, zero or positive, like C#'s `CompareTo`
- `String.compareTo` works the same way and compares code units
- Compare timestamps first; only when they are equal compare device ids

Until it is done, sync still publishes your data and copies *new* records from other devices, but it can't pick a winner when
two devices hold different versions of the same record, so the app throws on that path.

## Design

```
device A  ->  hydratrack-<A>.json  ->  [Drive appDataFolder | shared folder]  <-  hydratrack-<B>.json  <-  device B
```

- **One writer per file.** Each device writes only its own snapshot and only reads the others'. Drive never sees concurrent
  writes to one file; Syncthing never creates `.sync-conflict` copies.
- **Snapshots hold everything**, including tombstones (`deleted: true`), so a delete on one device reaches the rest.
- **Last write wins** per record, by `updatedAt`, with the device id as a deterministic tiebreak so all devices converge.
- **Merge is separate from transport.** `SyncService` and `SyncStore` know nothing about Drive or folders. A `SyncBackend`
  only lists, reads and writes text, so adding another provider (WebDAV, Dropbox) is one small class.
- **Opt-in.** With sync off, no network and no files outside app storage are touched.

## Concepts

### Interfaces for I/O, plain classes for logic
`SyncBackend`, `DriveFiles`, `DriveSignIn`, `FolderPicker` and `ReminderScheduler` all hide something awkward (network,
OS dialogs, platform channels). Tests substitute tiny fakes (`implements`) or `Fake` (`extends Fake implements`) and exercise
the real logic.

### Testing with two devices
`sync_service_test.dart` builds two real in-memory databases with different device ids, a shared in-memory backend, and an
injectable clock per device. That reproduces concurrent edits, stale writes and tombstones deterministically, with no mocks.

### Sealed classes and exhaustive switches
`SyncState` is `sealed` with three `final` subclasses. A `switch` over it must handle all three or the analyzer errors, and
patterns destructure fields (`SyncFailed(:final message)`).

### Defensive error handling
- Catch what you can handle: a corrupt peer file is skipped; a database failure is not.
- Catch `Exception`, not `Object`: `Error`s (like `UnimplementedError`) mean a bug and should surface.
- `return future` inside `try` doesn't catch its errors; `return await future` does. The `unawaited_return_in_try_block`
  lint catches this.

### Triggers without loops
Syncing writes the "last synced" setting. If a change listener watched *all* tables, that write would retrigger a sync forever.
So the listener watches only synced tables, and is debounced (30 s) so a burst of edits syncs once.

### Configuration at build time
`String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID')` is read from `--dart-define` at compile time, which keeps
OAuth identifiers out of the repository.

## Known limitations
- Settings (goal, avatar, reminders) are per device and not synced; only categories, drinks and entries are.
- Past days' goal results use the current goal when computing streaks.
- Android folder sync uses real file paths plus "all files access", not the Storage Access Framework.
- Folder sync isn't available in the browser (needs the File System Access API); web can use Drive once web sign-in exists.
- Drive sign-in and Android folder access haven't run on a device. See [drive-setup.md](../drive-setup.md).

## Docs
- [Drive appDataFolder](https://developers.google.com/drive/api/guides/appdata)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [Dart sealed classes](https://dart.dev/language/class-modifiers#sealed)
- [Syncthing](https://syncthing.net/)
