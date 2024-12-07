import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggleComplete,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => onToggleComplete(),
                  activeColor: kcPrimaryColor,
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: kcPrimaryColor),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            if (todo.description.isNotEmpty) ...[
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  todo.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    decoration:
                        todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
