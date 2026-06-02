import '../../../core/enums.dart';

/// Maps a [MuscleGroup] to the SVG path ids it should colour, for the front
/// and back body maps. Ids must match those in assets/body_map/*.svg.
///
/// Missing ids are tolerated by the colorizer, so a muscle without a matching
/// path simply isn't drawn.
class MuscleSvgMapping {
  const MuscleSvgMapping._();

  static const Map<MuscleGroup, List<String>> front = {
    MuscleGroup.chest: ['chest_left', 'chest_right'],
    MuscleGroup.shoulders: ['shoulder_left', 'shoulder_right'],
    MuscleGroup.biceps: ['biceps_left', 'biceps_right'],
    MuscleGroup.forearms: ['forearm_left', 'forearm_right'],
    MuscleGroup.abs: ['abs'],
    MuscleGroup.obliques: ['obliques_left', 'obliques_right'],
    MuscleGroup.quads: ['quads_left', 'quads_right'],
    MuscleGroup.calves: ['calves_left', 'calves_right'],
  };

  static const Map<MuscleGroup, List<String>> back = {
    MuscleGroup.back: ['lats_left', 'lats_right', 'upper_back'],
    MuscleGroup.traps: ['traps'],
    MuscleGroup.shoulders: ['rear_delt_left', 'rear_delt_right'],
    MuscleGroup.triceps: ['triceps_left', 'triceps_right'],
    MuscleGroup.forearms: ['forearm_back_left', 'forearm_back_right'],
    MuscleGroup.lowerBack: ['lower_back'],
    MuscleGroup.glutes: ['glutes_left', 'glutes_right'],
    MuscleGroup.hamstrings: ['hamstrings_left', 'hamstrings_right'],
    MuscleGroup.calves: ['calves_left', 'calves_right'],
  };

  static Map<MuscleGroup, List<String>> forSide({required bool isFront}) =>
      isFront ? front : back;
}
