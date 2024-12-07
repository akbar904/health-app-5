import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';
import 'package:gyde_app/models/todo_model.dart';

class AddTodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> addTodo() async {
    if (titleController.text.isEmpty) {
      return;
    }

    setBusy(true);

    try {
      final todo = Todo(
        id: const Uuid().v4(),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );

      await _todoService.addTodo(todo);
      _navigationService.back();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
