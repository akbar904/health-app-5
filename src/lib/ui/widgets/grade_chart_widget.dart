import 'package:flutter/material.dart';

class GradeChartWidget extends StatelessWidget {
  final Map<String, double>? grades;
  final double width;
  final double height;

  const GradeChartWidget({
    Key? key,
    this.grades,
    this.width = 300,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (grades == null || grades!.isEmpty) {
      return const Center(child: Text('No grades available'));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grade Distribution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: GradeChartPainter(grades!),
              ),
            ),
            const SizedBox(height: 16),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: grades!.entries.map((entry) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              color: _getColorForGrade(entry.key),
            ),
            const SizedBox(width: 4),
            Text('${entry.key}: ${entry.value.toStringAsFixed(1)}%'),
          ],
        );
      }).toList(),
    );
  }

  Color _getColorForGrade(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.yellow;
      case 'D':
        return Colors.orange;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class GradeChartPainter extends CustomPainter {
  final Map<String, double> grades;

  GradeChartPainter(this.grades);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    double total = grades.values.reduce((a, b) => a + b);
    double startAngle = 0;

    grades.forEach((grade, value) {
      final sweepAngle = (value / total) * 2 * 3.14159;
      paint.color = _getColorForGrade(grade);

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Color _getColorForGrade(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.yellow;
      case 'D':
        return Colors.orange;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}