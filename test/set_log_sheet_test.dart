import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymbo/core/enums.dart';
import 'package:gymbo/features/exercise_catalog/domain/exercise.dart';
import 'package:gymbo/features/workout/presentation/set_log_sheet.dart';

void main() {
  group('showSetLogSheet weight helper text', () {
    testWidgets('shows dumbbell helper text', (tester) async {
      await _pumpSheet(
        tester,
        _exercise(equipmentType: EquipmentType.dumbbell),
      );

      expect(find.text('Enter weight per hand.'), findsOneWidget);
    });

    testWidgets('shows bodyweight helper text', (tester) async {
      await _pumpSheet(
        tester,
        _exercise(equipmentType: EquipmentType.bodyweight),
      );

      expect(
        find.text('Use 0 kg for bodyweight only, or added load if weighted.'),
        findsOneWidget,
      );
    });

    testWidgets('shows assisted helper text', (tester) async {
      await _pumpSheet(
        tester,
        _exercise(
          equipmentType: EquipmentType.assistedBodyweight,
          exerciseCategory: ExerciseCategory.assistedBodyweight,
        ),
      );

      expect(
        find.text('Enter assistance weight. Lower is harder.'),
        findsOneWidget,
      );
    });

    testWidgets('shows machine helper text', (tester) async {
      await _pumpSheet(
        tester,
        _exercise(equipmentType: EquipmentType.machine),
      );

      expect(
        find.text('Enter stack weight shown on the machine.'),
        findsOneWidget,
      );
    });
  });
}

Future<void> _pumpSheet(WidgetTester tester, Exercise exercise) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showSetLogSheet(
              context,
              initialWeight: 0,
              initialReps: 8,
              increment: 2.5,
              exercise: exercise,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Exercise _exercise({
  required EquipmentType equipmentType,
  ExerciseCategory? exerciseCategory,
}) {
  final now = DateTime(2026);
  return Exercise(
    id: 'exercise-${equipmentType.name}',
    name: equipmentType.label,
    primaryMuscleGroup: 'Chest',
    movementPattern: 'Press',
    equipmentType: equipmentType,
    exerciseCategory: exerciseCategory ?? ExerciseCategory.compoundUpper,
    isBodyweight: equipmentType == EquipmentType.bodyweight ||
        equipmentType == EquipmentType.assistedBodyweight,
    isUnilateral: false,
    createdAt: now,
    updatedAt: now,
  );
}
