import 'package:flutter/material.dart';
import '../../models/assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;
  final VoidCallback? onSubmit;
  final VoidCallback? onGrade;

  const AssignmentCard({
    Key? key,
    required this.assignment,
    this.onTap,
    this.onSubmit,
    this.onGrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      assignment.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                assignment.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due: ${assignment.formatDueDate()}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Course: ${assignment.courseName}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  _buildActionButton(context),
                ],
              ),
              if (assignment.grade != null) ...[
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grade:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${assignment.grade}/100',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: _getGradeColor(assignment.grade!),
                          ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    return Chip(
      label: Text(
        assignment.status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: _getStatusColor(assignment.status),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (onSubmit != null) {
      return ElevatedButton(
        onPressed: onSubmit,
        child: const Text('Submit'),
      );
    }
    if (onGrade != null) {
      return ElevatedButton(
        onPressed: onGrade,
        child: const Text('Grade'),
      );
    }
    return const SizedBox.shrink();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'submitted':
        return Colors.blue;
      case 'graded':
        return Colors.green;
      case 'late':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getGradeColor(double grade) {
    if (grade >= 90) return Colors.green;
    if (grade >= 80) return Colors.blue;
    if (grade >= 70) return Colors.orange;
    return Colors.red;
  }
}