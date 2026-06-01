import 'dart:math' as math;

/// Rounds [value] to the nearest multiple of [increment].
///
/// Used to snap recommended loads to practical gym increments
/// (e.g. 2.5 kg for barbells, 1.0/2.0 kg for dumbbells).
double roundToNearestIncrement(double value, double increment) {
  if (increment <= 0) return value;
  final rounded = (value / increment).round() * increment;
  // Avoid floating point noise like 57.50000000001.
  return double.parse(rounded.toStringAsFixed(3));
}

/// Rounds a value to [fractionDigits] decimal places.
double roundTo(double value, [int fractionDigits = 1]) {
  final factor = math.pow(10, fractionDigits);
  return (value * factor).round() / factor;
}
