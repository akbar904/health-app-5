import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(String) onToggle;
  final Function(String) onEdit;
  final Function(String) onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggle(todo.id),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isCompleted ? kcMediumGrey : kcDarkGreyColor,
            ),
          ),
          subtitle: Text(
            todo.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: todo.isCompleted ? kcLightGrey : kcMediumGrey,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(todo.priority.emoji),
              IconButton(
                icon: const Icon(Icons.edit, color: kcPrimaryColor),
                onPressed: () => onEdit(todo.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
