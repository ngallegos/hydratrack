import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/providers.dart';
import 'package:hydratrack/data/repositories/log_repository.dart';
import 'package:hydratrack/domain/drink_category.dart';
import 'package:hydratrack/domain/log_entry.dart';
import 'package:hydratrack/domain/streaks.dart';
import 'package:hydratrack/features/history/history_providers.dart';
import 'package:hydratrack/features/history/history_screen.dart';
import 'package:hydratrack/features/home/home_providers.dart';
import 'package:material_ui/material_ui.dart';

final _stamp = DateTime.utc(2026);
final _today = dateOnly(DateTime.now());

DrinkCategory _category(String id, String name, double factor, int order) =>
    DrinkCategory(
      id: id,
      name: name,
      colorValue: 0xFF2196F3,
      hydrationFactor: factor,
      sortOrder: order,
      updatedAt: _stamp,
      deviceId: 't',
    );

LogEntry _entry(String id, String category, int ml) => LogEntry(
  id: id,
  categoryId: category,
  volumeMl: ml,
  loggedAt: _today.copyWith(hour: 9, minute: 30),
  updatedAt: _stamp,
  deviceId: 't',
);

class _FakeLogRepository extends Fake implements LogRepository {
  final added = <DateTime?>[];
  final updated = <LogEntry>[];
  final deleted = <String>[];
  final restored = <String>[];

  @override
  Future<LogEntry> add({
    required String categoryId,
    required int volumeMl,
    DateTime? at,
  }) async {
    added.add(at);
    return _entry('new', categoryId, volumeMl);
  }

  @override
  Future<void> update(LogEntry entry) async => updated.add(entry);

  @override
  Future<void> softDelete(String id) async => deleted.add(id);

  @override
  Future<void> restore(String id) async => restored.add(id);
}

Widget _host(_FakeLogRepository logs, {List<LogEntry>? entries}) =>
    ProviderScope(
      overrides: [
        categoriesProvider.overrideWith(
          (ref) => Stream.value([
            _category('water', 'Water', 1, 0),
            _category('coffee', 'Coffee', 0.5, 1),
          ]),
        ),
        selectedDayEntriesProvider.overrideWith(
          (ref) => Stream.value(
            entries ?? [_entry('a', 'water', 500), _entry('b', 'coffee', 200)],
          ),
        ),
        logRepositoryProvider.overrideWithValue(logs),
      ],
      child: const MaterialApp(home: HistoryScreen()),
    );

void main() {
  testWidgets('shows the day total and entries', (tester) async {
    await tester.pumpWidget(_host(_FakeLogRepository()));
    await tester.pumpAndSettle();

    expect(find.text('600 ml'), findsOneWidget);
    expect(find.text('500 ml Water'), findsOneWidget);
    expect(find.text('200 ml Coffee'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('shows an empty state', (tester) async {
    await tester.pumpWidget(_host(_FakeLogRepository(), entries: const []));
    await tester.pumpAndSettle();

    expect(find.text('Nothing logged this day'), findsOneWidget);
  });

  testWidgets('swiping deletes an entry and offers undo', (tester) async {
    final logs = _FakeLogRepository();
    await tester.pumpWidget(_host(logs));
    await tester.pumpAndSettle();

    await tester.drag(find.byKey(const Key('entry-a')), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(logs.deleted, ['a']);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(logs.restored, ['a']);
  });

  testWidgets('adds a back-dated entry for the selected day', (tester) async {
    final logs = _FakeLogRepository();
    await tester.pumpWidget(_host(logs));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add entry'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('time-tile')), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Log'));
    await tester.pumpAndSettle();

    expect(dateOnly(logs.added.single!), _today);
  });

  testWidgets('editing an entry saves the new category', (tester) async {
    final logs = _FakeLogRepository();
    await tester.pumpWidget(_host(logs));
    await tester.pumpAndSettle();

    await tester.tap(find.text('500 ml Water'));
    await tester.pumpAndSettle();
    expect(find.text('Edit entry'), findsOneWidget);
    await tester.tap(find.byKey(const Key('category-coffee')));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    final saved = logs.updated.single;
    expect(saved.id, 'a');
    expect(saved.categoryId, 'coffee');
    expect(saved.volumeMl, 500);
  });

  testWidgets('previous day button leaves today', (tester) async {
    await tester.pumpWidget(_host(_FakeLogRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Previous day'));
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsNothing);
    expect(
      tester
          .widget<IconButton>(
            find.widgetWithIcon(IconButton, Icons.chevron_right),
          )
          .onPressed,
      isNotNull,
    );
  });
}
