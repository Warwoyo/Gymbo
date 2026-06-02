import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/enums.dart';
import 'muscle_map_color_resolver.dart';
import 'muscle_map_color_scale.dart';
import 'svg_muscle_colorizer.dart';

/// A front/back human body map whose muscles are coloured by [scores]
/// (0–100) according to [mode].
///
/// Reuses the existing muscle taxonomy/scores; it only handles rendering.
/// Fails gracefully (shows chips) if the SVG assets are unavailable.
class HumanMuscleMap extends StatelessWidget {
  const HumanMuscleMap({
    super.key,
    required this.scores,
    required this.mode,
    this.showFront = true,
    this.showBack = true,
    this.showLegend = true,
    this.height = 240,
    this.onMuscleTap,
  });

  final Map<MuscleGroup, double> scores;
  final MuscleMapMode mode;
  final bool showFront;
  final bool showBack;
  final bool showLegend;
  final double height;
  final void Function(MuscleGroup muscle)? onMuscleTap;

  static const _frontAsset = 'assets/body_map/front.svg';
  static const _backAsset = 'assets/body_map/back.svg';
  static const _scale = MuscleMapColorScale();
  static const _resolver = MuscleMapColorResolver();
  static const _colorizer = SvgMuscleColorizer();

  // Cache colorized SVG strings so we don't reparse on every rebuild.
  static final Map<String, String> _cache = {};

  String _cacheKey(bool front) {
    final entries = scores.entries.map((e) => '${e.key.name}:${e.value.round()}').toList()
      ..sort();
    return '${front ? 'F' : 'B'}|${mode.name}|${entries.join(',')}';
  }

  Future<String?> _colorized(bool front) async {
    final key = _cacheKey(front);
    final cached = _cache[key];
    if (cached != null) return cached;
    final pathColors = _resolver.resolvePathColors(
      scores: scores,
      mode: mode,
      front: front,
    );
    final svg = await _colorizer.colorizeAsset(
      assetPath: front ? _frontAsset : _backAsset,
      pathColors: pathColors,
      strokeColor: MuscleMapColorScale.stroke,
    );
    if (svg != null) {
      if (_cache.length > 40) _cache.clear();
      _cache[key] = svg;
    }
    return svg;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showFront) Expanded(child: _BodySide(future: _colorized(true), label: 'Front')),
              if (showBack) Expanded(child: _BodySide(future: _colorized(false), label: 'Back')),
            ],
          ),
        ),
        if (showLegend) ...[
          const SizedBox(height: 8),
          _Legend(entries: _scale.legend(mode)),
        ],
        if (onMuscleTap != null && scores.isNotEmpty) ...[
          const SizedBox(height: 8),
          _MuscleChips(scores: scores, mode: mode, onTap: onMuscleTap!),
        ],
      ],
    );
  }
}

class _BodySide extends StatelessWidget {
  const _BodySide({required this.future, required this.label});

  final Future<String?> future;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<String?>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              final svg = snapshot.data;
              if (svg == null) {
                return const Center(
                  child: Icon(Icons.accessibility_new, size: 64),
                );
              }
              return SvgPicture.string(svg, fit: BoxFit.contain);
            },
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.entries});
  final List<(String, Color)> entries;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        for (final (label, color) in entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 4),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
      ],
    );
  }
}

class _MuscleChips extends StatelessWidget {
  const _MuscleChips({
    required this.scores,
    required this.mode,
    required this.onTap,
  });

  final Map<MuscleGroup, double> scores;
  final MuscleMapMode mode;
  final void Function(MuscleGroup muscle) onTap;

  @override
  Widget build(BuildContext context) {
    const scale = MuscleMapColorScale();
    final sorted = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final e in sorted)
          ActionChip(
            avatar: CircleAvatar(backgroundColor: scale.colorFor(mode, e.value)),
            label: Text('${e.key.label} ${e.value.round()}%'),
            onPressed: () => onTap(e.key),
          ),
      ],
    );
  }
}
