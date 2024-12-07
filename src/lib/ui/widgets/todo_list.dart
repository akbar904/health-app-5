import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/widgets/empty_state.dart';
import 'package:gyde_app/ui/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo, bool?) onToggleComplete;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  const TodoList({
    required this.todos,
    required this.onToggleComplete,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const EmptyState(
        message: 'No todos yet!\nAdd your first todo to get started.',
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggleComplete: (bool? value) => onToggleComplete(todo, value),
          onDelete: () => onDelete(todo),
          onEdit: () => onEdit(todo),
        );
      },
    );
  }
}
