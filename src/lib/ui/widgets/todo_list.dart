import 'package:flutter/material.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:gyde_app/ui/widgets/todo_item.dart';
import 'package:stacked/stacked.dart';

class TodoList extends ViewModelWidget<TodoViewModel> {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.todos.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        final todo = viewModel.todos[index];
        return TodoItem(todo: todo);
      },
    );
  }
}
