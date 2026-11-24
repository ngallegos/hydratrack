# 08 — Backup, export and the PWA

No exercise in this phase.

## Concepts

### Reuse the sync format for backups
A backup is a `SyncSnapshot` serialised to JSON, and importing calls `SyncStore.apply`. So restore uses the same last-write-wins
merge as sync: importing an old backup can't overwrite newer edits, and importing twice changes nothing.

### Platform file dialogs behind an interface
`FileTransfer` wraps `file_picker`. On web, "save" becomes a browser download and "pick" an `<input type=file>`; on Android it uses
the system document UI. Tests use a fake, so no platform channel is touched.

### CSV by hand
CSV is simple until a field contains a comma, quote or newline. Quote the field and double any inner quotes (RFC 4180).
`entriesToCsv` is a pure function with tests for exactly those cases.

### Generating assets with code
The app icon was rendered by a throwaway test that reused `AvatarShape.drop.buildPath`, via a `RepaintBoundary` and
`matchesGoldenFile` pointed at an output folder. Handy trick: a golden test is also a "render widget to PNG" tool.

### PWA basics
- `web/manifest.json` makes the site installable: name, colors, `display: standalone`, icons.
- *Maskable* icons are full-bleed so Android can crop them to a circle or squircle; keep the artwork inside the central ~60%.
- `drift_worker.js` and `sqlite3.wasm` in `web/` let SQLite run in the browser. Versions must match `pubspec.lock`.

### Launcher icons
`flutter_launcher_icons` (config at the bottom of `pubspec.yaml`) regenerates Android mipmaps from one PNG.

## Tracked follow-ups
Android-only extras that need the Android SDK to build and verify:
- Home-screen widget: [#10](https://github.com/ngallegos/hydratrack/issues/10)
- Health Connect: [#11](https://github.com/ngallegos/hydratrack/issues/11)
- Shake to undo: [#8](https://github.com/ngallegos/hydratrack/issues/8)
