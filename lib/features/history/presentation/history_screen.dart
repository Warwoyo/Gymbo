import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/enums.dart';
import '../../../core/utils/formatting.dart';
import '../../workout/domain/workout_session.dart';
import '../../workout/presentation/session_providers.dart';

enum _HistoryFilter { all, push, pull, legs, pr, autoEnded }

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  _HistoryFilter _selectedFilter = _HistoryFilter.all;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(
      monthlyWorkoutHistorySummaryProvider(_selectedMonth),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (summary) {
          final filteredList = _filterSessions(summary.sessions, summary);

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: filteredList.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (_, i) {
              if (i == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MonthSelector(
                      month: _selectedMonth,
                      onPrevious: () => setState(() {
                        _selectedMonth = DateTime(
                          _selectedMonth.year,
                          _selectedMonth.month - 1,
                        );
                      }),
                      onNext: () => setState(() {
                        _selectedMonth = DateTime(
                          _selectedMonth.year,
                          _selectedMonth.month + 1,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    _RecapHeader(summary: summary),
                    const SizedBox(height: 8),
                    _FilterChips(
                      selectedFilter: _selectedFilter,
                      onSelected: (filter) => setState(() {
                        _selectedFilter = filter;
                      }),
                    ),
                    if (filteredList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: Text('No workouts match this filter.'),
                        ),
                      ),
                  ],
                );
              }

              final s = filteredList[i - 1];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.event_available),
                  title: Text(s.sessionName ?? s.dayType?.label ?? 'Workout'),
                  subtitle: Text(
                    '${Format.dateTime(s.startedAt)} • ${Format.duration(s.duration)}'
                    '${s.status == WorkoutSessionStatus.autoCompleted ? ' • auto-ended' : ''}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/summary/${s.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<WorkoutSession> _filterSessions(
    List<WorkoutSession> sessions,
    MonthlyWorkoutHistorySummary summary,
  ) {
    return sessions.where((s) {
      switch (_selectedFilter) {
        case _HistoryFilter.all:
          return true;
        case _HistoryFilter.push:
          return s.dayType == DayType.push;
        case _HistoryFilter.pull:
          return s.dayType == DayType.pull;
        case _HistoryFilter.legs:
          return s.dayType == DayType.leg;
        case _HistoryFilter.pr:
          return summary.personalRecordSessionIds.contains(s.id);
        case _HistoryFilter.autoEnded:
          return s.status == WorkoutSessionStatus.autoCompleted;
      }
    }).toList(growable: false);
  }
}

class _MonthSelector extends StatelessWidget {
  const _MonthSelector({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Previous month',
              icon: const Icon(Icons.chevron_left),
              onPressed: onPrevious,
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat('MMMM yyyy').format(month),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Next month',
              icon: const Icon(Icons.chevron_right),
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecapHeader extends StatelessWidget {
  const _RecapHeader({required this.summary});

  final MonthlyWorkoutHistorySummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _RecapTile(
              label: 'Workouts',
              value: '${summary.totalWorkouts}',
              icon: Icons.fitness_center,
            ),
            _RecapTile(
              label: 'Duration',
              value: Format.duration(summary.totalDuration),
              icon: Icons.timer_outlined,
            ),
            _RecapTile(
              label: 'Volume',
              value: Format.kg(summary.totalVolumeLoad),
              icon: Icons.scale_outlined,
            ),
            _RecapTile(
              label: 'PRs',
              value: '${summary.personalRecordCount}',
              icon: Icons.emoji_events_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecapTile extends StatelessWidget {
  const _RecapTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelMedium),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.selectedFilter,
    required this.onSelected,
  });

  final _HistoryFilter selectedFilter;
  final ValueChanged<_HistoryFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final filter in _HistoryFilter.values)
          FilterChip(
            label: Text(_filterLabel(filter)),
            selected: selectedFilter == filter,
            onSelected: (_) => onSelected(filter),
          ),
      ],
    );
  }

  String _filterLabel(_HistoryFilter filter) {
    switch (filter) {
      case _HistoryFilter.all:
        return 'All';
      case _HistoryFilter.push:
        return 'Push';
      case _HistoryFilter.pull:
        return 'Pull';
      case _HistoryFilter.legs:
        return 'Legs';
      case _HistoryFilter.pr:
        return 'PR';
      case _HistoryFilter.autoEnded:
        return 'Auto-ended';
    }
  }
}
