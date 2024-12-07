import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddTodoFAB extends ViewModelWidget<TodoViewModel> {
  const AddTodoFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () {
        // Show add todo dialog
        // Implementation will be completed when add_todo_dialog is implemented
      },
      backgroundColor: kcTodoColor,
      child: const Icon(Icons.add),
    );
  }
}
