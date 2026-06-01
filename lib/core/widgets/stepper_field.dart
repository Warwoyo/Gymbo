import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A large, workout-friendly numeric input with +/- steppers.
class StepperField extends StatelessWidget {
  const StepperField({
    super.key,
    required this.label,
    required this.controller,
    required this.step,
    this.allowDecimal = true,
    this.suffix,
    this.min = 0,
  });

  final String label;
  final TextEditingController controller;
  final double step;
  final bool allowDecimal;
  final String? suffix;
  final double min;

  double get _value => double.tryParse(controller.text) ?? 0;

  void _set(double v) {
    final clamped = v < min ? min : v;
    controller.text = allowDecimal
        ? (clamped == clamped.roundToDouble()
            ? clamped.toStringAsFixed(0)
            : clamped.toString())
        : clamped.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 6),
        Row(
          children: [
            _RoundButton(
              icon: Icons.remove,
              onTap: () => _set(_value - step),
              semanticLabel: 'Decrease $label',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: allowDecimal),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(allowDecimal ? r'[0-9.]' : r'[0-9]')),
                ],
                decoration: InputDecoration(suffixText: suffix),
              ),
            ),
            const SizedBox(width: 8),
            _RoundButton(
              icon: Icons.add,
              onTap: () => _set(_value + step),
              semanticLabel: 'Increase $label',
            ),
          ],
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: scheme.secondaryContainer,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(icon, color: scheme.onSecondaryContainer),
          ),
        ),
      ),
    );
  }
}
