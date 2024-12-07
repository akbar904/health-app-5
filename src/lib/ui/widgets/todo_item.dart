import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoItem extends ViewModelWidget<TodoViewModel> {
  final TodoModel todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: kcDeleteColor,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => viewModel.deleteTodo(todo.id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => viewModel.toggleTodoCompletion(todo.id),
            activeColor: kcCompletedColor,
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isCompleted ? kcMediumGrey : Colors.black,
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
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: kcTodoColor),
            onPressed: () async {
              // Open edit dialog
              // Implementation will be completed when edit_todo_dialog is implemented
            },
          ),
        ),
      ),
    );
  }
}
