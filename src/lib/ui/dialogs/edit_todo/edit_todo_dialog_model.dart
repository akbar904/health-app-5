import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditTodoDialogModel extends BaseViewModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
