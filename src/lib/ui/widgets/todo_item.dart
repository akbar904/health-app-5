import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onToggle;

  const TodoItem({
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: onToggle,
          activeColor: kcPrimaryColor,
        ),
        title: Text(
          todo.title,
          style: titleMediumStyle.copyWith(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.description,
              style: bodySmallStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
              style: labelSmallStyle.copyWith(color: kcMediumGrey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
