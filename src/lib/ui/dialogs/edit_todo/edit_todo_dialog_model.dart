import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/models/todo_model.dart';

class EditTodoDialogModel extends BaseViewModel {
  final Todo todo;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  EditTodoDialogModel(this.todo) {
    titleController = TextEditingController(text: todo.title);
    descriptionController = TextEditingController(text: todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void updateTodo(Function(DialogResponse) completer) {
    if (titleController.text.isEmpty) return;

    final updatedTodo = todo.copyWith(
      title: titleController.text,
      description: descriptionController.text,
    );

    completer(DialogResponse(
      confirmed: true,
      data: updatedTodo,
    ));
  }
}
