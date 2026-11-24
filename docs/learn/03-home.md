# 03 — Home screen

## Exercise (done)

`StarredDrinkChip` in `lib/features/home/starred_drink_chip.dart` is implemented and covered by
`test/features/home/starred_drink_chip_test.dart`. The requirements are in the comment above the class.

Hints that were given:
- `ActionChip(avatar: ..., label: ..., onPressed: ...)`
- String interpolation: `'${drink.name} · ${formatMl(drink.volumeMl)}'`
- A dot is a `Container` with `width`/`height` and `BoxDecoration(shape: BoxShape.circle, color: Color(category.colorValue))`
- Keys let tests find a specific widget: `Container(key: const Key('category-dot'), ...)`

## Concepts

### Widgets, state, and rebuilds
- `StatelessWidget`: output depends only on inputs.
- `StatefulWidget` + `State`: holds mutable state across rebuilds; `setState(() {...})` marks it dirty (`_LogSheetState`).
- `ConsumerWidget` / `ConsumerStatefulWidget` (Riverpod): same, plus a `ref` to read providers.
- `ref.watch(p)` in `build` subscribes: the widget rebuilds when `p` changes.
- `ref.read(p)` in event handlers reads once with no subscription. Never `watch` in a callback.

C# analogy: `watch` is a binding, `read` is a one-off property access.

### AsyncValue
`StreamProvider` exposes `AsyncValue<T>` (loading / data / error). `.value` is `T?`, which is `null` until
the first emission, hence `?? const []` in `HomeScreen`.

### Custom painting
`CustomPainter.paint(Canvas, Size)` draws imperatively: `clipPath`, `drawPath`, `drawRect`. `Path` has the
same primitives as SVG (`moveTo`, `lineTo`, `cubicTo`, `arcToPoint`) plus `Path.combine` for boolean ops.
`shouldRepaint` is how Flutter skips redundant repaints, so it must compare everything the painter uses.

### Animation
- `AnimationController` produces a value 0..1 over a duration. It needs a `vsync` (a `TickerProvider`), supplied by
  `TickerProviderStateMixin`, so animations pause when the widget isn't visible.
- `AnimatedBuilder` rebuilds only its subtree each tick.
- Two controllers here: an endlessly repeating wave and a 600 ms fill tween driven through `lerpAvatarBands`.
- Always `dispose()` controllers.

### Pure logic first
`computeAvatarBands` and `lerpAvatarBands` take data and return data. They are unit-tested without any
widget, then the painter is a thin layer on top. Do this whenever you can.

### Dart 3 patterns
- `if (categoriesById[id] case final category?)` is a null-check pattern: binds a non-null local or skips.
- Records like `({String categoryId, int volumeMl})` are lightweight anonymous value types with structural `==`
  (the test asserts `expect(logs.added.single, (categoryId: 'water', volumeMl: 250))`).
- `switch` expressions with enums (`AvatarShape.buildPath`) are exhaustive; the analyzer flags a missing case.
- Enhanced enums carry fields and constructors (`AvatarShape.aspectRatio`).

### Widget testing
- `pumpWidget` builds, `pump(duration)` advances time by one frame, `pumpAndSettle` pumps until no frames are
  scheduled (hangs with infinite animations).
- Animations start on the first frame after scheduling, so `pump()` then `pump(500ms)`.
- Override providers instead of mocking frameworks: `provider.overrideWithValue(...)` / `.overrideWith(...)`.
- Subclass `Fake implements Repo` (from `flutter_test`) to stub only the methods a test touches.
- Taps outside the viewport print a hit-test warning and silently miss; read warnings when a tap "does nothing".

## Docs
- [StatefulWidget lifecycle](https://api.flutter.dev/flutter/widgets/State-class.html)
- [CustomPainter](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
- [Animations intro](https://docs.flutter.dev/ui/animations)
- [Dart patterns](https://dart.dev/language/patterns)
- [Riverpod: reading providers](https://riverpod.dev/docs/concepts/reading)
- [Widget testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
