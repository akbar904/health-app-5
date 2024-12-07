import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TodoItem({
    required this.todo,
    required this.onTap,
    required this.onToggleComplete,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        onTap: onTap,
        leading: IconButton(
          icon: Icon(
            todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: todo.isCompleted ? Colors.green : kcMediumGrey,
          ),
          onPressed: onToggleComplete,
        ),
        title: Text(
          todo.title,
          style: titleMediumStyle.copyWith(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: bodySmallStyle.copyWith(color: kcMediumGrey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${todo.createdAt.day}/${todo.createdAt.month}/${todo.createdAt.year}',
              style: labelSmallStyle,
            ),
            horizontalSpaceSmall,
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
