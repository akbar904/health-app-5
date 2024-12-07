import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onToggle;
  final Function(Todo) onDelete;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet. Add one by tapping the + button!',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: onToggle,
          onDelete: onDelete,
        );
      },
    );
  }
}
