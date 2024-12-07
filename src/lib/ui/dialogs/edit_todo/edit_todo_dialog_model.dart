import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditTodoDialogModel extends BaseViewModel {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  bool _canSubmit = true;
  bool get canSubmit => _canSubmit;

  void onTitleChanged(String value) {
    _canSubmit = value.trim().isNotEmpty;
    notifyListeners();
  }

  void onDescriptionChanged(String value) {
    notifyListeners();
  }

  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
