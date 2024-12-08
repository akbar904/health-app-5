import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/utils/enums/todo_priority.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoDialogModel extends BaseViewModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TodoPriority _selectedPriority = TodoPriority.low;

  TodoPriority get selectedPriority => _selectedPriority;

  void init(Todo todo) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    _selectedPriority = todo.priority;
  }

  void setPriority(TodoPriority? priority) {
    if (priority != null) {
      _selectedPriority = priority;
      notifyListeners();
    }
  }

  void updateTodo(Todo todo, Function(DialogResponse) completer) {
    if (titleController.text.isEmpty) return;

    final updatedTodo = todo.copyWith(
      title: titleController.text,
      description: descriptionController.text,
      priority: _selectedPriority,
    );

    completer(DialogResponse(
      confirmed: true,
      data: updatedTodo,
    ));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
