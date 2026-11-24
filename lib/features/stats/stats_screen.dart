import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/stats.dart';
import '../../domain/volume_unit.dart';
import '../../domain/streaks.dart';
import '../home/home_providers.dart';
import '../settings/settings_providers.dart';
import 'stats_providers.dart';

enum StatsRange {
  week(7, 'Week'),
  month(30, 'Month');

  const StatsRange(this.days, this.label);

  final int days;
  final String label;
}

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  var _range = StatsRange.week;

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(statsDataProvider);
    final unit = ref.watch(volumeUnitProvider);
    final today = ref.watch(todayProvider).value ?? dateOnly(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: stats == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SegmentedButton<StatsRange>(
                  segments: [
                    for (final range in StatsRange.values)
                      ButtonSegment(value: range, label: Text(range.label)),
                  ],
                  selected: {_range},
                  onSelectionChanged: (s) => setState(() => _range = s.single),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: _DailyChart(
                    stats: stats,
                    days: [
                      for (var i = _range.days - 1; i >= 0; i--)
                        DateTime(today.year, today.month, today.day - i),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _Summary(
                  stats: stats,
                  today: today,
                  days: _range.days,
                  unit: unit,
                ),
                const SizedBox(height: 24),
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final a in Achievement.values)
                      Tooltip(
                        message: a.description,
                        child: Chip(
                          key: Key('achievement-${a.name}'),
                          avatar: Icon(
                            stats.achievements.contains(a)
                                ? Icons.emoji_events
                                : Icons.lock_outline,
                          ),
                          label: Text(a.title),
                        ),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _DailyChart extends StatelessWidget {
  const _DailyChart({required this.stats, required this.days});

  final StatsData stats;
  final List<DateTime> days;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final maxTotal = days
        .map((d) => stats.dailyTotals[d] ?? 0)
        .fold<double>(stats.goalMl.toDouble(), (a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxTotal * 1.1,
        barGroups: [
          for (var i = 0; i < days.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: stats.dailyTotals[days[i]] ?? 0,
                  color: (stats.dailyTotals[days[i]] ?? 0) >= stats.goalMl
                      ? colors.primary
                      : colors.primary.withValues(alpha: 0.45),
                  width: days.length > 7 ? 6 : 16,
                ),
              ],
            ),
        ],
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: stats.goalMl.toDouble(),
              color: colors.tertiary,
              strokeWidth: 2,
              dashArray: [6, 4],
            ),
          ],
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: days.length > 7 ? 5 : 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= days.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('${days[index].day}'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.stats,
    required this.today,
    required this.days,
    required this.unit,
  });

  final StatsData stats;
  final DateTime today;
  final int days;
  final VolumeUnit unit;

  @override
  Widget build(BuildContext context) {
    final window = [
      for (var i = 0; i < days; i++)
        DateTime(today.year, today.month, today.day - i),
    ];
    final totalMl = window.fold<double>(
      0,
      (sum, d) => sum + (stats.dailyTotals[d] ?? 0),
    );
    final goalDays = window
        .where((d) => (stats.dailyTotals[d] ?? 0) >= stats.goalMl)
        .length;

    Widget tile(String label, String value) => Expanded(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );

    return Row(
      children: [
        tile('Daily average', unit.format(totalMl / days)),
        tile('Goal met', '$goalDays / $days days'),
        tile('Current streak', '${stats.currentStreak}'),
        tile('Best streak', '${stats.longestStreak}'),
      ],
    );
  }
}
