import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheetModel extends BaseViewModel {
  final todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  void saveTodo(Function(SheetResponse)? completer) {
    if (todoController.text.trim().isEmpty) return;

    completer?.call(
      SheetResponse(
        confirmed: true,
        data: todoController.text.trim(),
      ),
    );
  }
}
