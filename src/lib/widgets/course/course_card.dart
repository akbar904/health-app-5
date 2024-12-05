import 'package:flutter/material.dart';
import '../../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CourseCard({
    Key? key,
    required this.course,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: course.coverImageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(course.coverImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          course.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onEdit != null || onDelete != null)
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            if (onEdit != null)
                              PopupMenuItem(
                                child: const Text('Edit'),
                                onTap: onEdit,
                              ),
                            if (onDelete != null)
                              PopupMenuItem(
                                child: const Text('Delete'),
                                onTap: onDelete,
                              ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grade ${course.gradeLevel}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${course.enrolledStudents.length} Students',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (course.progress != null) ...[
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: course.progress,
                      backgroundColor: Colors.grey[200],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}