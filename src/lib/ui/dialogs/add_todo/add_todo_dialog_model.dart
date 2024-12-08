import 'package:flutter/material.dart';
import 'package:gyde_app/utils/enums/todo_priority.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoDialogModel extends BaseViewModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TodoPriority _selectedPriority = TodoPriority.low;

  TodoPriority get selectedPriority => _selectedPriority;

  void setPriority(TodoPriority? priority) {
    if (priority != null) {
      _selectedPriority = priority;
      notifyListeners();
    }
  }

  void addTodo(Function(DialogResponse) completer) {
    if (titleController.text.isEmpty) return;

    completer(
      DialogResponse(
        confirmed: true,
        data: {
          'title': titleController.text,
          'description': descriptionController.text,
          'priority': _selectedPriority,
        },
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
