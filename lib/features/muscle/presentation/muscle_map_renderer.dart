import 'package:flutter/material.dart';

import '../../../core/enums.dart';

abstract class MuscleMapRenderer {
  Widget buildMuscleMap(Map<MuscleGroup, double> scores);
}

class SimpleMuscleMapRenderer extends StatelessWidget implements MuscleMapRenderer {
  const SimpleMuscleMapRenderer({super.key, this.scores = const {}});

  final Map<MuscleGroup, double> scores;

  @override
  Widget build(BuildContext context) => buildMuscleMap(scores);

  @override
  Widget buildMuscleMap(Map<MuscleGroup, double> scores) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Body map placeholder', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Front/back SVG muscle paths can be connected here later.'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in scores.entries)
                  InputChip(
                    label: Text('${entry.key.label} ${entry.value.round()}%'),
                    selected: entry.value >= 60,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
