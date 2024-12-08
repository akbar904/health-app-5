import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/widgets/empty_state.dart';
import 'package:gyde_app/ui/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onTodoTap;
  final Function(String) onDeleteTodo;
  final Function(String) onToggleTodo;

  const TodoList({
    required this.todos,
    required this.onTodoTap,
    required this.onDeleteTodo,
    required this.onToggleTodo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const EmptyState(
        message: 'No todos yet.\nTap the + button to add one!',
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onTap: () => onTodoTap(todo.id),
          onDelete: () => onDeleteTodo(todo.id),
          onToggle: (_) => onToggleTodo(todo.id),
        );
      },
    );
  }
}
