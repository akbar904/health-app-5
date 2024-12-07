import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final Function(String) onDelete;
  final Function(String) onToggleComplete;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    required this.onDelete,
    required this.onToggleComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggleComplete(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete(todo.id),
        ),
      ),
    );
  }
}
