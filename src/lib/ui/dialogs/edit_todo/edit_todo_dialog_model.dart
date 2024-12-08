import 'package:flutter/material.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoDialogModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void updateTodo(String id, Function(DialogResponse) completer) {
    if (titleController.text.trim().isEmpty) {
      return;
    }

    final updatedTodo = Todo(
      id: id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdAt: DateTime.now(),
      isCompleted: false,
    );

    _todoService.updateTodo(updatedTodo);
    completer(DialogResponse(confirmed: true));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
