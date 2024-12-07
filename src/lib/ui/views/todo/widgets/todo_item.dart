import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onToggle;
  final Function(Todo) onDelete;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo),
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: (_) => onToggle(todo),
          activeColor: kcPrimaryColor,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? kcMediumGrey : kcDarkGreyColor,
          ),
        ),
      ),
    );
  }
}
