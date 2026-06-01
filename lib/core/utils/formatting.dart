import 'package:intl/intl.dart';

/// Formatting helpers for displaying numbers and durations.
class Format {
  Format._();

  static final NumberFormat _kg = NumberFormat('0.##');

  /// Formats a weight, dropping trailing zeros (e.g. 57.5, 60).
  static String kg(double value) => '${_kg.format(value)} kg';

  static String number(num value) => _kg.format(value);

  /// Formats seconds as m:ss.
  static String mmss(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    final m = s ~/ 60;
    final rem = s % 60;
    return '$m:${rem.toString().padLeft(2, '0')}';
  }

  /// Human-friendly duration like "1h 12m" or "34m".
  static String duration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m';
    return '${d.inSeconds}s';
  }

  static String dateTime(DateTime dt) =>
      DateFormat('EEE, d MMM yyyy • HH:mm').format(dt);

  static String date(DateTime dt) => DateFormat('d MMM yyyy').format(dt);

  static String time(DateTime dt) => DateFormat('HH:mm').format(dt);
}
