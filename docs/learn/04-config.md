# 04 — Configuration: settings, editors, onboarding

## Exercise (done)

`suggestedDailyGoalMl` in `lib/domain/goal.dart` is implemented and covered by `test/domain/goal_test.dart`; the
onboarding "Suggest my goal" test (`test/features/onboarding/onboarding_screen_test.dart`) exercises it too. The formula
and rules are in the comment above it.

Hints that were given:
- `weightKg * mlPerKg * activity.multiplier` gives a `double`
- Round to a step: `(value / step).round() * step`
- `num.clamp(min, max)` returns `num`; use `.toInt()` or keep the types as `int` by clamping after rounding
- Validate first: `if (weightKg <= 0) throw ArgumentError.value(weightKg, 'weightKg', 'must be positive');`

## Concepts

### Navigation with go_router
Routes are declared as data: `GoRoute(path: '/settings', routes: [GoRoute(path: 'categories', ...)])`.
`context.push('/settings')` stacks a page (back button works); `context.go('/')` replaces the stack.
Analogy: ASP.NET attribute routing, but for screens. URLs also work as deep links on web.

`redirect` is middleware: return a new location or `null` for "carry on". `refreshListenable` re-runs it when
something changes, here the settings stream, so finishing onboarding navigates automatically.

### Forms without a form framework
Each editor keeps local state in `State` fields (`_color`, `_percent`) and a `TextEditingController` for text.
`onChanged: (_) => setState(() {})` makes the Save button re-evaluate its enabled state. A button with
`onPressed: null` is disabled.

Controllers own native resources, so `dispose()` them in `State.dispose`, the way you'd dispose `IDisposable`.

### Bottom sheets and dialogs return values
`showDialog<bool>` / `showModalBottomSheet<T>` return a `Future<T?>` that completes when the route is popped
(`Navigator.pop(context, value)`), or with `null` when dismissed. That makes confirm flows a plain `await`:

```dart
final confirmed = await showDialog<bool>(...);
if (confirmed != true) return;
```

### BuildContext after await
`BuildContext` may be gone after an `await` (the widget was disposed). Capture what you need first
(`final navigator = Navigator.of(context);`) or check `if (!context.mounted) return;`. The analyzer enforces this
(`use_build_context_synchronously`).

### Settings as key/value, parsed into a typed class
Storing strings is simple and sync-friendly; `AppSettings.fromMap` converts them to a typed, immutable value with
defaults for anything missing or corrupt. `provider.select((s) => s.value?.dailyGoalMl)` subscribes to a single
field, so widgets rebuild only when that field changes.

### Strict inference
`const []` has no element type to infer from, so with `strict-inference` it becomes `List<dynamic>` and the analyzer
reports an error. Give it a type, or restructure so the type flows from context (`value ?? const []` where `value`
is `List<DrinkCategory>?` infers correctly; `for (final c in x ?? const [])` does not).

## Docs
- [go_router](https://pub.dev/documentation/go_router/latest/)
- [Navigation and routing](https://docs.flutter.dev/ui/navigation)
- [Forms cookbook](https://docs.flutter.dev/cookbook/forms)
- [Dart type inference](https://dart.dev/language/type-system#type-inference)
