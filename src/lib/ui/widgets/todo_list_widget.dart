import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/widgets/empty_state_widget.dart';
import 'package:gyde_app/ui/widgets/todo_item_widget.dart';

class TodoListWidget extends StatelessWidget {
  final List<TodoItem> todos;
  final Function(TodoItem) onTodoTap;
  final Function(TodoItem) onToggleComplete;

  const TodoListWidget({
    required this.todos,
    required this.onTodoTap,
    required this.onToggleComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const EmptyStateWidget();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: todos.length,
      separatorBuilder: (context, index) => verticalSpaceSmall,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItemWidget(
          todo: todo,
          onTap: () => onTodoTap(todo),
          onToggleComplete: () => onToggleComplete(todo),
        );
      },
    );
  }
}
