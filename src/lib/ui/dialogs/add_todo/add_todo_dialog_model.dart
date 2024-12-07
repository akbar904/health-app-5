import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoDialogModel extends BaseViewModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void submit(Function(DialogResponse) completer) {
    if (titleController.text.isEmpty) {
      return;
    }

    final todo = TodoItem(
      title: titleController.text,
      description: descriptionController.text,
    );

    completer(DialogResponse(confirmed: true, data: todo));
  }
}
