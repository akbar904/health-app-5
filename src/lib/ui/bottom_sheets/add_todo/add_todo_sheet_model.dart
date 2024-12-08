import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddTodoSheetModel extends BaseViewModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get canSubmit =>
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
