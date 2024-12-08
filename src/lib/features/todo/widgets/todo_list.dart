import 'package:flutter/material.dart';
import 'package:gyde_app/features/todo/widgets/todo_item.dart';
import 'package:gyde_app/models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(Todo) onEdit;

  const TodoList({
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggle(todo.id),
          onDelete: () => onDelete(todo.id),
          onEdit: () => onEdit(todo),
        );
      },
    );
  }
}
