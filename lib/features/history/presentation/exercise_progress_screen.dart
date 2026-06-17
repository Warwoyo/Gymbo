import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting.dart';
import '../../workout/domain/workout_repository.dart';
import '../../workout/presentation/session_providers.dart';

enum _ProgressMetric {
  e1rm('e1RM'),
  volume('Volume'),
  topWeight('Top weight');

  const _ProgressMetric(this.label);

  final String label;
}

enum _ProgressPeriod {
  days30('30 days', Duration(days: 30)),
  days90('90 days', Duration(days: 90)),
  allTime('All time', null);

  const _ProgressPeriod(this.label, this.duration);

  final String label;
  final Duration? duration;
}

class ExerciseProgressScreen extends ConsumerStatefulWidget {
  const ExerciseProgressScreen({
    super.key,
    required this.exerciseId,
    required this.exerciseName,
  });

  final String exerciseId;
  final String exerciseName;

  @override
  ConsumerState<ExerciseProgressScreen> createState() =>
      _ExerciseProgressScreenState();
}

class _ExerciseProgressScreenState extends ConsumerState<ExerciseProgressScreen> {
  _ProgressMetric _metric = _ProgressMetric.e1rm;
  _ProgressPeriod _period = _ProgressPeriod.days90;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(
      exerciseProgressProvider((exerciseId: widget.exerciseId)),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.exerciseName)),
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (points) {
          if (points.isEmpty) {
            return const Center(child: Text('No history for this exercise yet.'));
          }

          final filteredPoints = _filterPoints(points, _period);
          final best = points
              .map((p) => p.bestEstimatedOneRepMaxKg)
              .fold<double>(0, (a, b) => b > a ? b : a);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('All-time best e1RM'),
                      Text(
                        Format.kg(best),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ProgressControls(
                metric: _metric,
                period: _period,
                onMetricChanged: (value) => setState(() => _metric = value),
                onPeriodChanged: (value) => setState(() => _period = value),
              ),
              const SizedBox(height: 12),
              _ProgressChartCard(
                points: filteredPoints,
                metric: _metric,
                period: _period,
              ),
              const SizedBox(height: 16),
              Text(
                'Session by session',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final p in filteredPoints.reversed)
                Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    title: Text(Format.date(p.date)),
                    subtitle: Text(
                      'Top: ${Format.kg(p.topWeightKg)} × ${p.topWeightReps} • '
                      'Volume ${Format.kg(p.totalVolume)}',
                    ),
                    trailing: Text(
                      Format.kg(p.bestEstimatedOneRepMaxKg),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  List<ExerciseProgressPoint> _filterPoints(
    List<ExerciseProgressPoint> points,
    _ProgressPeriod period,
  ) {
    final duration = period.duration;
    if (duration == null || points.isEmpty) return points;

    final newestDay = points.last.date;
    final cutoff = DateTime(
      newestDay.year,
      newestDay.month,
      newestDay.day,
    ).subtract(duration);
    return points.where((point) => !point.date.isBefore(cutoff)).toList();
  }
}

class _ProgressControls extends StatelessWidget {
  const _ProgressControls({
    required this.metric,
    required this.period,
    required this.onMetricChanged,
    required this.onPeriodChanged,
  });

  final _ProgressMetric metric;
  final _ProgressPeriod period;
  final ValueChanged<_ProgressMetric> onMetricChanged;
  final ValueChanged<_ProgressPeriod> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Metric', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<_ProgressMetric>(
            segments: [
              for (final value in _ProgressMetric.values)
                ButtonSegment(value: value, label: Text(value.label)),
            ],
            selected: {metric},
            onSelectionChanged: (selected) => onMetricChanged(selected.single),
          ),
        ),
        const SizedBox(height: 12),
        Text('Period', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<_ProgressPeriod>(
            segments: [
              for (final value in _ProgressPeriod.values)
                ButtonSegment(value: value, label: Text(value.label)),
            ],
            selected: {period},
            onSelectionChanged: (selected) => onPeriodChanged(selected.single),
          ),
        ),
      ],
    );
  }
}

class _ProgressChartCard extends StatelessWidget {
  const _ProgressChartCard({
    required this.points,
    required this.metric,
    required this.period,
  });

  final List<ExerciseProgressPoint> points;
  final _ProgressMetric metric;
  final _ProgressPeriod period;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final values = points.map((point) => _valueFor(point, metric)).toList();
    final latest = values.isEmpty ? 0.0 : values.last;
    final highest = values.fold<double>(0, math.max);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${metric.label} trend',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      period.label,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatMetric(latest, metric),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Best ${_formatMetric(highest, metric)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (points.isEmpty)
              Container(
                height: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.surfaceContainerHighest,
                ),
                child: Text('No sessions in this period.'),
              )
            else
              SizedBox(
                height: 220,
                width: double.infinity,
                child: CustomPaint(
                  painter: _LineChartPainter(
                    values: values,
                    lineColor: colorScheme.primary,
                    gridColor: colorScheme.outlineVariant,
                    labelColor: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            if (points.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Format.date(points.first.date)),
                  Text(Format.date(points.last.date)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  const _LineChartPainter({
    required this.values,
    required this.lineColor,
    required this.gridColor,
    required this.labelColor,
  });

  final List<double> values;
  final Color lineColor;
  final Color gridColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    const leftPadding = 44.0;
    const rightPadding = 8.0;
    const topPadding = 8.0;
    const bottomPadding = 28.0;
    final chartRect = Rect.fromLTRB(
      leftPadding,
      topPadding,
      size.width - rightPadding,
      size.height - bottomPadding,
    );

    final maxValue = values.fold<double>(0, math.max);
    final minValue = values.fold<double>(maxValue, math.min);
    final range = math.max(maxValue - minValue, maxValue * 0.1);
    final yMin = math.max(0.0, minValue - range * 0.15);
    final yMax = maxValue + range * 0.15;
    final yRange = yMax - yMin == 0 ? 1.0 : yMax - yMin;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    final textStyle = TextStyle(color: labelColor, fontSize: 11);

    for (var i = 0; i <= 4; i++) {
      final y = chartRect.top + chartRect.height * i / 4;
      canvas.drawLine(
        Offset(chartRect.left, y),
        Offset(chartRect.right, y),
        gridPaint,
      );
      final labelValue = yMax - yRange * i / 4;
      _drawText(canvas, Format.number(labelValue), Offset(0, y - 7), textStyle);
    }

    if (values.length == 1) {
      final point = Offset(
        chartRect.center.dx,
        _valueToY(values.single, yMin, yRange, chartRect),
      );
      canvas.drawCircle(point, 4, Paint()..color = lineColor);
      return;
    }

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = chartRect.left + chartRect.width * i / (values.length - 1);
      final y = _valueToY(values[i], yMin, yRange, chartRect);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    final dotPaint = Paint()..color = lineColor;
    for (var i = 0; i < values.length; i++) {
      final x = chartRect.left + chartRect.width * i / (values.length - 1);
      final y = _valueToY(values[i], yMin, yRange, chartRect);
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  double _valueToY(double value, double yMin, double yRange, Rect chartRect) {
    final normalized = (value - yMin) / yRange;
    return chartRect.bottom - chartRect.height * normalized;
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 40);
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.labelColor != labelColor;
  }
}

double _valueFor(ExerciseProgressPoint point, _ProgressMetric metric) {
  return switch (metric) {
    _ProgressMetric.e1rm => point.bestEstimatedOneRepMaxKg,
    _ProgressMetric.volume => point.totalVolume,
    _ProgressMetric.topWeight => point.topWeightKg,
  };
}

String _formatMetric(double value, _ProgressMetric metric) {
  return switch (metric) {
    _ProgressMetric.e1rm => Format.kg(value),
    _ProgressMetric.volume => Format.kg(value),
    _ProgressMetric.topWeight => Format.kg(value),
  };
}
