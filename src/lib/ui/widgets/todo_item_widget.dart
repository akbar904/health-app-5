import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;

  const TodoItemWidget({
    required this.todo,
    required this.onTap,
    required this.onToggleComplete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggleComplete(),
          activeColor: kcPrimaryColor,
        ),
        title: Text(
          todo.title,
          style: bodyLargeStyle.copyWith(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.description,
          style: bodySmallStyle.copyWith(
            color: kcMediumGrey,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
