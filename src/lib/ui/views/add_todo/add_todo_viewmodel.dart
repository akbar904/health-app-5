import 'package:flutter/material.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void saveTodo() {
    if (formKey.currentState?.validate() ?? false) {
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );

      _todoService.addTodo(todo);
      _navigationService.back();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
