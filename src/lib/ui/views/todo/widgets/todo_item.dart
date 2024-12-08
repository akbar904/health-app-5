import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(String) onToggle;
  final Function(String) onEdit;
  final Function(String) onDelete;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
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
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDelete(todo.id),
      direction: DismissDirection.endToStart,
      child: ListTile(
        leading: Checkbox(
          value: todo.isComplete,
          onChanged: (_) => onToggle(todo.id),
          activeColor: kcPrimaryColor,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isComplete ? TextDecoration.lineThrough : null,
            color: todo.isComplete ? kcMediumGrey : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onEdit(todo.id),
          color: kcPrimaryColor,
        ),
      ),
    );
  }
}
