# 02 — Data layer

## Exercise (done)

`hydrationByCategory` in `lib/domain/hydration.dart` is implemented and covered by `test/domain/hydration_test.dart`.

Hints that were given:
- `Map<String, double>` with a loop and `result[id] = (result[id] ?? 0) + ml` (`??` is null-coalescing, same as C#)
- Or `putIfAbsent` / `update(key, (v) => v + x, ifAbsent: () => x)`
- Look up the category with `categoriesById[entry.categoryId]`; a map lookup returns `T?`, so check for `null` first. Dart promotes a local `final` variable to non-null after the check, like C# flow analysis
- Skip deleted entries and deleted/missing categories with `continue`

## Concepts

### Immutable models with freezed
`@freezed abstract class X with _$X` plus a `const factory` generates `==`, `hashCode`, `copyWith`,
and `toString`. C# analogy: `record`. `json_serializable` adds `toJson` / `fromJson`. Both run through
`build_runner` and write `*.freezed.dart` / `*.g.dart` next to the source (the `part` directives).
We commit generated files so a fresh clone builds without running codegen.

Regenerate after changing annotated classes or tables:
`dart run build_runner build --delete-conflicting-outputs`

### drift (typed SQLite)
Tables are Dart classes; drift generates row classes, companions (for inserts/updates), and query
helpers. Analogy: EF Core `DbContext` + entities, but code-first via generator rather than reflection.
`@DataClassName('DrinkRow')` renames generated rows so they don't collide with domain types.

On web, SQLite runs as WebAssembly (`web/sqlite3.wasm`) in a worker (`web/drift_worker.js`). Their
versions must match the resolved `sqlite3` / `drift` packages in `pubspec.lock`.

### Streams
`Stream<List<T>> watchX()` emits the current result, then again whenever the table changes. Analogy:
`IAsyncEnumerable<T>` or an Rx `IObservable<T>`. UI layers rebuild from these. `Future<T>` ≈ `Task<T>`.

### Soft deletes + sync metadata
Every record has `updatedAt`, `deviceId`, `deleted`. Deleting sets `deleted = true` instead of removing
the row, so the delete can sync to other devices (a tombstone). Undo is just `deleted = false`.

### Stable seed ids
Seed rows use fixed ids (`'water'`, `'coffee'`) and `insertOrIgnore`. Two devices seeding independently
produce identical rows instead of duplicates, and re-seeding never overwrites user edits.

### Riverpod (dependency injection)
`Provider<T>` is a lazily built, cached value, like a service registered in DI. `ref.watch(other)`
declares a dependency. `databaseProvider` and `deviceIdProvider` throw by default and are overridden in
`main()` after async startup work finishes (open DB, read device id). Tests can override the same
providers with in-memory fakes.

### Testing the DB
`AppDatabase(NativeDatabase.memory())` gives a fresh in-memory SQLite per test, similar to EF Core's
SQLite in-memory provider. The repository `clock` is injectable so tests control `updatedAt`.

## Docs
- [Dart collections](https://dart.dev/libraries/dart-core#collections)
- [Null safety](https://dart.dev/null-safety/understanding-null-safety)
- [freezed](https://pub.dev/packages/freezed)
- [drift](https://drift.simonbinder.eu/)
- [Riverpod](https://riverpod.dev/)
