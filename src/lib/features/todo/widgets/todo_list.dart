import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/features/todo/widgets/todo_item.dart';
import 'package:gyde_app/ui/dialogs/todo_edit/todo_edit_dialog.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(String, String, String) onEdit;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet',
          style: TextStyle(fontSize: 18, color: Colors.grey),
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
          onEdit: (id, title, description) async {
            final result = await showDialog<Map<String, String>>(
              context: context,
              builder: (context) => TodoEditDialog(
                initialTitle: title,
                initialDescription: description,
              ),
            );

            if (result != null) {
              onEdit(
                id,
                result['title'] ?? '',
                result['description'] ?? '',
              );
            }
          },
        );
      },
    );
  }
}
