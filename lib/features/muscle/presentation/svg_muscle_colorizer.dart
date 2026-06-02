import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

import 'muscle_map_color_scale.dart';

/// Recolours an SVG body map by element `id`.
///
/// Elements whose `id` is present in `pathColors` get their `fill` set to that
/// colour. Unmatched elements keep whatever fill they already have. Parsing is
/// tolerant: a malformed SVG or missing ids never throw.
class SvgMuscleColorizer {
  const SvgMuscleColorizer();

  static const _shapeTags = {'path', 'polygon', 'rect', 'ellipse', 'circle', 'line', 'polyline'};

  /// Pure transform — recolour [source] SVG text. Unit-testable.
  String recolorSvg(
    String source,
    Map<String, Color> pathColors, {
    Color? strokeColor,
  }) {
    final XmlDocument doc;
    try {
      doc = XmlDocument.parse(source);
    } catch (_) {
      return source; // fail gracefully — render the original
    }

    for (final element in doc.descendantElements) {
      if (!_shapeTags.contains(element.name.local)) continue;
      final id = element.getAttribute('id');
      if (id == null) continue;
      final color = pathColors[id];
      if (color == null) continue;
      element.setAttribute('fill', colorToHex(color));
      if (strokeColor != null) {
        element.setAttribute('stroke', colorToHex(strokeColor));
      }
    }
    return doc.toXmlString();
  }

  /// Loads [assetPath] from the bundle and recolours it. Returns null if the
  /// asset can't be loaded (so callers can fall back gracefully).
  Future<String?> colorizeAsset({
    required String assetPath,
    required Map<String, Color> pathColors,
    Color? strokeColor,
  }) async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      return recolorSvg(raw, pathColors, strokeColor: strokeColor);
    } catch (_) {
      return null;
    }
  }
}
