import 'package:stacked/stacked.dart';

class AddTodoDialogModel extends BaseViewModel {
  String title = '';
  String description = '';

  bool get canSubmit => title.isNotEmpty && description.isNotEmpty;

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }
}
