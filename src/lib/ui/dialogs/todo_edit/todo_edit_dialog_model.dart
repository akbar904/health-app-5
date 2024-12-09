import 'package:stacked/stacked.dart';

class TodoEditDialogModel extends BaseViewModel {
  String _title = '';
  String get title => _title;

  String _description = '';
  String get description => _description;

  bool get canSave => _title.isNotEmpty;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }
}
