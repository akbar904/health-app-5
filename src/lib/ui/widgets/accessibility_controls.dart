import 'package:flutter/material.dart';

class AccessibilityControls extends StatelessWidget {
  final double textScale;
  final bool highContrast;
  final Function(double) onTextScaleChanged;
  final Function(bool) onHighContrastChanged;

  const AccessibilityControls({
    Key? key,
    required this.textScale,
    required this.highContrast,
    required this.onTextScaleChanged,
    required this.onHighContrastChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accessibility Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextScaleControl(),
            const SizedBox(height: 16),
            _buildHighContrastControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextScaleControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text Size',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: textScale,
          min: 0.8,
          max: 1.4,
          divisions: 6,
          label: '${(textScale * 100).round()}%',
          onChanged: onTextScaleChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('A', style: TextStyle(fontSize: 14)),
            Text('A', style: TextStyle(fontSize: 24)),
          ],
        ),
      ],
    );
  }

  Widget _buildHighContrastControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'High Contrast',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: highContrast,
          onChanged: onHighContrastChanged,
        ),
      ],
    );
  }
}