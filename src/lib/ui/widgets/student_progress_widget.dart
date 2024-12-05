import 'package:flutter/material.dart';

class StudentProgressWidget extends StatelessWidget {
  const StudentProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildProgressItem('Mathematics', 0.85),
            _buildProgressItem('Science', 0.75),
            _buildProgressItem('English', 0.90),
            _buildProgressItem('History', 0.70),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String subject, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subject),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 16),
          child: Text('${(progress * 100).toInt()}%'),
        ),
      ],
    );
  }
}