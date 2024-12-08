import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            todo.isCompleted
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
            color: todo.isCompleted ? kcSuccessColor : kcMediumGrey,
          ),
          onPressed: onToggle,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: todo.isCompleted ? kcMediumGrey : kcDarkGreyColor,
          ),
        ),
        subtitle: Text(
          todo.description,
          style: bodySmallStyle.copyWith(
            color: kcMediumGrey,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: kcErrorColor),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
